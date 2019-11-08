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

#include "sobel.h"

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

  // background thread to run mandelbrot
  void dispatcher() {
    int buffer = device->phys_addr;
    char* virt_buffer = device->buffer;
    cv::VideoCapture cap(0);
    auto calcstart = std::chrono::high_resolution_clock::now();
    while(toggleLoopActive && !shuttingDown) {

      int units = currentSelection;

      // fill cv mat with either video from camera or generated image
      cv::Mat src_colour(width, height, CV_8UC3);
      if (cap.isOpened()) {
        cap >> src_colour;
      } else {
        src_colour = cv::Scalar(0,0,0);
        auto timenow = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> elapsed_seconds = timenow-calcstart;
        cv::Point point(width/2 + std::cos(elapsed_seconds.count())*height/10,
                        height/2 + std::sin(elapsed_seconds.count())*height/10);
        cv::circle(src_colour, point, height / 10, {0, 0, 255}, 10);
        cv::circle(src_colour, {width/2,height/2}, height / 10, {255, 255, 0}, 10);
      }

      // convert input to grayscale
      cv::Mat src;
      cv::cvtColor(src_colour, src, cv::COLOR_BGR2GRAY);

      // populate udma buffer with image data
      for (int y = 0; y < height; y++) {
        int lineoff = y*width;
        for (int x = 0; x < width; x++)
          virt_buffer[lineoff+x] = src.at<char>(y,x);
      }

      // softare path
      if (units <= 0) {
        auto start = std::chrono::high_resolution_clock::now();
        soft_sobel((bus_t*)virt_buffer, (bus_t*)&virt_buffer[width*height]);
        auto stop = std::chrono::high_resolution_clock::now();
        duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
        jobCount = units;
        continue;
      }

      // Set up for the sobel hardware units
      std::vector<Job> jobs;
      for (int unit = 0; unit < units; unit++) {
        Job &job = jobs.emplace_back();
        job.accname = "Partial_sobel";
        job.params["in_pixels"] = (buffer + unit*(width*(height/units)));
        job.params["in_pixels_msb"] = 0;
        job.params["out_pixels"] = (buffer + src_size + unit*(width*(height/units))) + 2*unit*width;
        job.params["out_pixels_msb"] = 0;
        job.params["im_width"]  = width;
        job.params["im_height"] = (height/units)+2;
      }

      // dispatch job to fpga daemon
      auto start = std::chrono::high_resolution_clock::now();
      fpgaRpc.Run(jobs);
      auto stop = std::chrono::high_resolution_clock::now();
      duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
      jobCount = units;
    }
  }

  // update gui bitmap with buffer contents
  void updateFrames() {
    copySobelData(bitmapData, &device->buffer[src_size]);
    bitmapFrame->SetBitmap(bitmap);
    if (jobCount > 0)
      imageText->SetLabelMarkup("<big>Took " + std::to_string(duration) + "ms with " + std::to_string(jobCount) + " p factor</big>");
    else
      imageText->SetLabelMarkup("<big>Took " + std::to_string(duration) + "ms in software</big>");
  }

  void copySobelData(wxNativePixelData &dst, char *src) {
    wxNativePixelData::Iterator p(dst);
    int units = jobCount > 0 ? jobCount : 1;
    for (int unit = 0; unit < units; unit++) {
      int segheight = height/units;
      int segbase = unit*width*segheight + 2*(unit+1)*width;
      for (int y = 0; y < segheight; y++) {
        for (int x = 0; x < width; x++, p++) {
          char iter = src[segbase+y*width+x];
          p.Red() = iter;
          p.Green() = iter;
          p.Blue() = iter;
	}
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
