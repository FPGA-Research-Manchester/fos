#include <wx/wxprec.h>
#ifndef WX_PRECOMP
  #include <wx/wx.h>
  #include <wx/spinctrl.h>
  #include <wx/timer.h>
  #include <wx/rawbmp.h>
  #include <wx/artprov.h>
#endif

#include <iostream>
#include <complex>
#include <cmath>
#include <chrono>
#include <map>
#include <string>
#include <vector>
#include <thread>

// opencv includes to support sobel unit
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgcodecs/imgcodecs.hpp>

#include "udmalib/udma.h"
#include "proto/fpga_rpc_c.h"

#include "mandel.h"

// mandelbrot parameters
constexpr int width = 640;
constexpr int height = 480;
constexpr int pixel_count = width*height;
constexpr int src_cpp = 1;
constexpr int dst_cpp = 3;
constexpr int src_size = pixel_count * src_cpp;
constexpr int dst_size = pixel_count * dst_cpp;
constexpr double init_cre = -0.36, init_cim = 0.641, init_zoom = 0.01;


// events used in the program
enum {
  RELOAD_IMAGE = 1,                     // request to run the accelerator
  CALC_IMAGE = 2,                       // request to update the acc
  TIMER_TICK = 3,                       // timer to update the gui
  UPDATE_UNITS = 4,                     // parallelism spinner change event
  LOOP_TOGGLE = 5                       // mandelbrot zoom loop toogle
};

// the main application window
class MainFrame : public wxFrame {
private:
  UdmaRepo *repo;                       // udma buffer repository
  UdmaDevice *device;                   // selected udma device
  int bufno;                            // udma device number
  wxToolBar *toolbar;                   // main frame toolbar
  wxBitmap bitmap;                      // accel generated image output
  wxStaticBitmap *bitmapFrame;          // gui widget to display bitmap
  wxNativePixelData bitmapData;         // handle to raw bitmap data
  wxStaticText *imageText;              // text directly above bitmap
  wxSpinCtrl *unitChooser;              // parallelism spinner
  wxToolBarToolBase *stopStartButton;   // stop and start button
  wxBitmap gtkStop, gtkPlay;            // play and stop icons
  FPGARPCClient fpgaRpc;                // fpga rpc client object
  int duration, jobCount;               // time taken for accel to run, and on how many jobs
  std::thread *dispatcherThread;        // thread handling fpga dispatch
  int currentSelection;                 // current parallelism
  bool toggleLoopActive;
  bool shuttingDown;
public:
  MainFrame(const wxString& title, const wxPoint& pos, const wxSize& size) :
      wxFrame(NULL, wxID_ANY, title, pos, size),
      bitmap(width, height, dst_cpp*8), bitmapData(bitmap),
      fpgaRpc(), shuttingDown(false) {

    // setup layout sizer
    wxBoxSizer *imageSizer = new wxBoxSizer(wxVERTICAL);

    // setup toolbar
    toolbar = CreateToolBar();
    toolbar->AddTool(wxID_EXIT, "Exit", wxArtProvider::GetBitmap("gtk-quit"));
    toolbar->AddTool(wxID_ABOUT, "About", wxArtProvider::GetBitmap("help-about"));
    toolbar->AddTool(RELOAD_IMAGE, "Reload", wxArtProvider::GetBitmap("gtk-refresh"));
    toolbar->AddTool(CALC_IMAGE, "SW Mandel", wxArtProvider::GetBitmap("application-x-executable"));

    // setup dropdown
    unitChooser = new wxSpinCtrl(toolbar, UPDATE_UNITS, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 100, 0);
    toolbar->AddControl(unitChooser);

    // setup start/stop button
    gtkStop = wxArtProvider::GetBitmap("gtk-cancel");
    gtkPlay = wxArtProvider::GetBitmap("gtk-media-play-ltr");
    stopStartButton = toolbar->AddTool(LOOP_TOGGLE, "Stop application", gtkStop);

    // instanciate the toolbar
    toolbar->Realize();

    // map the boofers
    repo = new UdmaRepo();
    bufno = fpgaRpc.Alloc();
    if (bufno < 0) {
      std::cerr << "could no allocate buffers" << std::endl;
      throw std::runtime_error("could no allocate buffers\n");
    }
    device = repo->device(bufno);
    device->map();

    // side by side bitmap and text view
    imageText = new wxStaticText(this, wxID_ANY, ":D");
    bitmapFrame = new wxStaticBitmap(this, wxID_ANY, bitmap);
    imageSizer->Add(imageText, 0, wxALIGN_CENTER | wxALL, 5);
    imageSizer->Add(bitmapFrame, 0, 0, 0);

    // setup timer
    wxTimer *updateTimer = new wxTimer(this, TIMER_TICK);
    updateTimer->Start(150);

    // start loop threads
    toggleLoopActive = true;
    dispatcherThread = new std::thread(&MainFrame::dispatcher, this);

    // setup heirarchy of layout & fit window to contents
    SetSizer(imageSizer);
    imageSizer->SetSizeHints(this);
    Fit();
  }
private:

  // on toggle button
  void OnTogggleLoop(wxCommandEvent &event) {
    if (toggleLoopActive) {
      toggleLoopActive = false;
      stopStartButton->SetLabel("Start application");
      toolbar->SetToolNormalBitmap(LOOP_TOGGLE, gtkPlay);
    } else {
      toggleLoopActive = true;
      stopStartButton->SetLabel("Stop application");
      toolbar->SetToolNormalBitmap(LOOP_TOGGLE, gtkStop);
      dispatcherThread = new std::thread(&MainFrame::dispatcher, this);
    }
  }

  // on parallelism spinner change
  void OnUpdateSelection(wxSpinEvent& event) {
    currentSelection = unitChooser->GetValue();
  }

  // timer tick callback function
  void OnTimerTick(wxTimerEvent &event) {
    updateFrames();
  }

  // calculate button
  void OnCalc(wxCommandEvent& event) {
    int selected = unitChooser->GetValue();
    switch(selected) {
      case 0: {
        softMandelbrot2(width, height, init_cre, init_cim, init_zoom, 256, device->buffer);
        break;
      }

      default: {
        int units = selected;
        std::vector<Job> jobs;
        for (int unit = 0; unit < units; unit++) {
          Job &job = jobs.emplace_back();
          job.accname = "Partial_mandelbrot";
          initParams(width, height, init_cre, init_cim, init_zoom, 256, device->phys_addr, job.params);
          multParams(width, height, init_cre, init_cim, init_zoom, 256, device->phys_addr, job.params, unit, units);
        }
        fpgaRpc.Run(jobs);
        break;
      }
    }
  }

  // background thread to run mandelbrot
  void dispatcher() {
    double myzoom = init_zoom;

    while(toggleLoopActive && !shuttingDown) {

      // zoom in
      myzoom *= 0.95;
      if (myzoom < 1.0e-8)
        myzoom = init_zoom;

      // how many jobs to dispatch
      int units = currentSelection;

      // break into software if no units is 0
      if (units <= 0) {
        auto start = std::chrono::high_resolution_clock::now();
        softMandelbrot2(width, height, init_cre, init_cim, myzoom, 256, device->buffer);
        auto stop = std::chrono::high_resolution_clock::now();
        duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
        jobCount = units;
        continue;
      }

      // build vector of jobs to dispatch to daemon
      std::vector<Job> jobs;
      for (int unit = 0; unit < units; unit++) {
        Job &job = jobs.emplace_back();
        job.accname = "Partial_mandelbrot";
        initParams(width, height, init_cre, init_cim, myzoom, 256, device->phys_addr, job.params);
        multParams(width, height, init_cre, init_cim, myzoom, 256, device->phys_addr, job.params, unit, units);
      }

      // time the run jobs call
      auto start = std::chrono::high_resolution_clock::now();
      fpgaRpc.Run(jobs);
      auto stop = std::chrono::high_resolution_clock::now();

      // update the timer variable wit the data
      duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
      jobCount = units;
    }
  }
  // update button
  void OnUpdate(wxCommandEvent& event) {
    updateFrames();
  }

  // update gui bitmap with buffer contents
  void updateFrames() {
    copyMandelData(bitmapData, device->buffer);
    bitmapFrame->SetBitmap(bitmap);
    if (jobCount > 0)
      imageText->SetLabelMarkup("<big>Took " + std::to_string(duration) + "ms with " + std::to_string(jobCount) + " p factor</big>");
    else
      imageText->SetLabelMarkup("<big>Took " + std::to_string(duration) + "ms in software</big>");
  }

  void copyMandelData(wxNativePixelData &dst, char *src) {
    wxNativePixelData::Iterator p(dst);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++, p++) {
        char iter = src[y*width+x];
        p.Red() = iter & 0xc0;
        p.Green() = (iter << 2) & 0xe0;
        p.Blue() = (iter << 5) & 0xe0;
      }
    }
  }

  // about button
  void OnAbout(wxCommandEvent& event) {
    wxMessageBox("wxMoni\nCS UoM 2019", "wxMoni", wxOK | wxICON_INFORMATION);
  }

  // quit button
  void OnExit(wxCommandEvent& event) {
    Close(true);
  }

  // main quit function
  void OnClose(wxCloseEvent& event) {
    shuttingDown = true;
    if (toggleLoopActive)
      dispatcherThread->join();
    fpgaRpc.Free(bufno);
    Destroy();
}

  wxDECLARE_EVENT_TABLE();
};

// events for MainFrame class
wxBEGIN_EVENT_TABLE(MainFrame, wxFrame)
  EVT_MENU(wxID_ABOUT, MainFrame::OnAbout)
  EVT_MENU(wxID_EXIT,  MainFrame::OnExit)
  EVT_MENU(RELOAD_IMAGE,  MainFrame::OnUpdate)
  EVT_MENU(CALC_IMAGE,  MainFrame::OnCalc)
  EVT_MENU(LOOP_TOGGLE, MainFrame::OnTogggleLoop)
  EVT_SPINCTRL(UPDATE_UNITS,  MainFrame::OnUpdateSelection)
  EVT_TIMER(TIMER_TICK, MainFrame::OnTimerTick)
  EVT_CLOSE(MainFrame::OnClose)
wxEND_EVENT_TABLE()


// main application driver
// all we do is load and show the MainFrame class
class MainApplication : public wxApp {
public:
  virtual bool OnInit() {
    MainFrame *frame = new MainFrame("wxmoni", wxPoint(50, 50), wxSize(500, 500));
    frame->Show(true);
    return true;
  }
};

// wxWidgets will load and run our MainApplication class
wxIMPLEMENT_APP(MainApplication);
