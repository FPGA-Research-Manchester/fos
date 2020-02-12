#include <wx/wxprec.h>
#ifndef WX_PRECOMP
  #include <wx/wx.h>
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
#include "sobel.h"


constexpr int width = 640;
constexpr int height = 480;
constexpr int pixel_count = width*height;
constexpr int src_cpp = 1;
constexpr int dst_cpp = 3;
constexpr int src_size = pixel_count * src_cpp;
constexpr int dst_size = pixel_count * dst_cpp;

double cre = -0.36, cim = 0.641, zoom = 0.01;

// events used in the program
enum {
  RELOAD_IMAGE = 1,
  CALC_IMAGE = 2,
  TIMER_TICK = 3,
  UPDATE_UNITS = 4,
  LOOP_TOGGLE = 5
};

// the main application window
class MainFrame : public wxFrame {
private:
  UdmaRepo *repo;
  UdmaDevice *device0, *device1;
  int bufno0, bufno1;
  wxToolBar *toolbar;
  wxBitmap bitmap0, bitmap1;
  wxStaticBitmap *bitmapFrame0, *bitmapFrame1;
  wxNativePixelData bitmapData0, bitmapData1;
  wxStaticText *imageText0, *imageText1;
  wxChoice *unitChooser;
  wxToolBarToolBase *stopStartButton;
  wxBitmap gtkStop, gtkPlay;
  FPGARPCClient fpgaRpc0, fpgaRpc1;
  int duration0, duration1;
  std::thread *dispatcherThread0, *dispatcherThread1;
  int currentSelection;
  bool toggleLoopActive;
  bool shuttingDown;
public:
  MainFrame(const wxString& title, const wxPoint& pos, const wxSize& size) :
      wxFrame(NULL, wxID_ANY, title, pos, size),
      bitmap0(width, height, dst_cpp*8), bitmap1(width, height, dst_cpp*8),
      bitmapData0(bitmap0), bitmapData1(bitmap1),
      fpgaRpc0(), fpgaRpc1(),
      shuttingDown(false) {

    // setup layout sizer
    wxBoxSizer *imageSizer = new wxBoxSizer(wxHORIZONTAL);
    wxBoxSizer *lImageSizer = new wxBoxSizer(wxVERTICAL);
    wxBoxSizer *rImageSizer = new wxBoxSizer(wxVERTICAL);

    // setup toolbar
    toolbar = CreateToolBar();
    toolbar->AddTool(wxID_EXIT, "Exit", wxArtProvider::GetBitmap("gtk-quit"));
    toolbar->AddTool(wxID_ABOUT, "About", wxArtProvider::GetBitmap("help-about"));
    toolbar->AddTool(RELOAD_IMAGE, "Reload", wxArtProvider::GetBitmap("gtk-refresh"));
    toolbar->AddTool(CALC_IMAGE, "SW Mandel", wxArtProvider::GetBitmap("application-x-executable"));


    // setup dropdown
    unitChooser = new wxChoice(toolbar, UPDATE_UNITS);
    wxArrayString hwLevel;
    hwLevel.Add("Software");
    hwLevel.Add("1 Unit");
    hwLevel.Add("2 Units");
    hwLevel.Add("3 Units");
    unitChooser->Set(hwLevel);
    unitChooser->SetSelection(0);
    currentSelection = 0;
    toolbar->AddControl(unitChooser);

    // setup start/stop button
    gtkStop = wxArtProvider::GetBitmap("gtk-cancel");
    gtkPlay = wxArtProvider::GetBitmap("gtk-media-play-ltr");
    stopStartButton = toolbar->AddTool(LOOP_TOGGLE, "Stop right application", gtkStop);

    // instanciate the toolbar
    toolbar->Realize();

    // map the boofers
    repo = new UdmaRepo();
    bufno0 = fpgaRpc0.Alloc();
    bufno1 = fpgaRpc0.Alloc();
    if (bufno0 < 0 || bufno1 < 0) {
      std::cerr << "could no allocate buffers" << std::endl;
      throw std::runtime_error("could no allocate buffers\n");
    }
    device0 = repo->device(bufno0);
    device1 = repo->device(bufno1);
    device0->map();
    device1->map();

    // side by side bitmap and text view
    imageText0 = new wxStaticText(this, wxID_ANY, ":D");
    bitmapFrame0 = new wxStaticBitmap(this, wxID_ANY, bitmap0);
    lImageSizer->Add(imageText0, 0, wxALIGN_CENTER | wxALL, 5);
    lImageSizer->Add(bitmapFrame0, 0, 0, 0);
    imageText1 = new wxStaticText(this, wxID_ANY, ":)");
    bitmapFrame1 = new wxStaticBitmap(this, wxID_ANY, bitmap1);
    rImageSizer->Add(imageText1, 0, wxALIGN_CENTER | wxALL, 5);
    rImageSizer->Add(bitmapFrame1, 0, 0, 0);

    // setup timer
    wxTimer *updateTimer = new wxTimer(this, TIMER_TICK);
    updateTimer->Start(200);

    // start loop threads
    toggleLoopActive = true;
    dispatcherThread0 = new std::thread(&MainFrame::dispatcherMandel, this, 0, cre, cim);
    dispatcherThread1 = new std::thread(&MainFrame::dispatcherSobel, this, 1);

    // setup heirarchy of layout
    imageSizer->Add(lImageSizer);
    imageSizer->Add(rImageSizer);

    SetSizer(imageSizer);
    imageSizer->SetSizeHints(this);

    // fit the window to the contents
    Fit();
  }
private:

  void OnTogggleLoop(wxCommandEvent &event) {
    if (toggleLoopActive) {
      toggleLoopActive = false;
      stopStartButton->SetLabel("Start right application");
      toolbar->SetToolNormalBitmap(LOOP_TOGGLE, gtkPlay);
    } else {
      toggleLoopActive = true;
      stopStartButton->SetLabel("Stop right application");
      toolbar->SetToolNormalBitmap(LOOP_TOGGLE, gtkStop);
      // dispatcherThread0 = new std::thread(&MainFrame::dispatcher, this, 0, cre, cim);
      dispatcherThread1 = new std::thread(&MainFrame::dispatcherSobel, this, 1);
    }
  }

  void OnUpdateSelection(wxCommandEvent& event) {
    currentSelection = unitChooser->GetCurrentSelection();
  }

  void updateFrames() {
    copyMandelData(bitmapData0, device0->buffer);
    bitmapFrame0->SetBitmap(bitmap0);
    imageText0->SetLabelMarkup("<big>Took " + std::to_string(duration0) + "ms</big>");

    copySobelData(bitmapData1, &device1->buffer[src_size]);
    bitmapFrame1->SetBitmap(bitmap1);
    imageText1->SetLabelMarkup("<big>Took " + std::to_string(duration1) + "ms</big>");
  }

  void OnTimerTick(wxTimerEvent &event) {
    updateFrames();
  }

  void OnCalc(wxCommandEvent& event) {
    int selected = unitChooser->GetCurrentSelection();
    switch(selected) {
      case 0: {
        softMandelbrot2(width, height, cre, cim, zoom, 256, device0->buffer);
        break;
      }

      default: {
        int units = selected;
        std::vector<Job> jobs;
        for (int unit = 0; unit < units; unit++) {
          Job &job = jobs.emplace_back();
          job.accname = "Partial_mandelbrot";
          initParams(width, height, cre, cim, zoom, 256, device0->phys_addr, job.params);
          multParams(width, height, cre, cim, zoom, 256, device0->phys_addr, job.params, unit, units);
        }
        fpgaRpc0.Run(jobs);
        break;
      }
    }
  }

  void dispatcherSobel(int index) {
    int buffer = device1->phys_addr;
    char* virt_buffer = device1->buffer;
    bool opposite = index > 0;
    // std::cout << "starting looper thread (index: " << index << ")" << std::endl;
    FPGARPCClient &fpgaRpc = opposite ? fpgaRpc1 : fpgaRpc0;
    cv::VideoCapture cap(0);
    int* timerVariable = opposite ? &duration1 : &duration0;
    auto calcstart = std::chrono::high_resolution_clock::now();
    while((toggleLoopActive || !opposite) && !shuttingDown) {

      int units = opposite ? 3-currentSelection : currentSelection;

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
      cv::Mat src;
      cv::cvtColor(src_colour, src, cv::COLOR_BGR2GRAY);

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
        int duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
        *timerVariable = duration;
        continue;
      }

      // Set up for the sobel hardware units
      std::vector<Job> jobs;
      for (int unit = 0; unit < units; unit++) {
        Job &job = jobs.emplace_back();
        job.accname = "Partial_sobel";
        job.params["in_pixels_1"] = (buffer + unit*(width*(height/units)))+ 2*width;
        job.params["in_pixels_2"] = 0;
        job.params["out_pixels_1"] = (buffer + src_size + unit*(width*(height/units)));
        job.params["out_pixels_2"] = 0;
        job.params["image_width"]  = width;
        job.params["image_height"] = (height/units)+2;
        // std::cout << job.params["in_pixels_msb"] << ":" << job.params["in_pixels"] << ", ";
        // std::cout << job.params["out_pixels_msb"] << ":" << job.params["out_pixels"] << ", ";
        // std::cout << job.params["im_width"] << "," << job.params["im_height"] << std::endl;
      }

      // dispatch job to fpga daemon
      auto start = std::chrono::high_resolution_clock::now();
      fpgaRpc.Run(jobs);
      auto stop = std::chrono::high_resolution_clock::now();
      int duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
      *timerVariable = duration;

    }
  }

  void dispatcherMandel(int index, double cre, double cim) {
    int buffer = device0->phys_addr + src_size*index;
    char* virt_buffer = device0->buffer + src_size*index;
    bool opposite = index > 0;
    // std::cout << "starting looper thread (index: " << index << ")" << std::endl;
    double myzoom = zoom;
    FPGARPCClient &fpgaRpc = opposite ? fpgaRpc1 : fpgaRpc0;
    int* timerVariable = opposite ? &duration1 : &duration0;
    while((toggleLoopActive || !opposite) && !shuttingDown) {

      myzoom *= 0.95;
      if (myzoom < 1.0e-8)
        myzoom = 0.01;

      int units = opposite ? 3-currentSelection : currentSelection;

      if (units <= 0) {
        auto start = std::chrono::high_resolution_clock::now();
        softMandelbrot2(width, height, cre, cim, myzoom, 256, virt_buffer);
        auto stop = std::chrono::high_resolution_clock::now();
        int duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
        *timerVariable = duration;
        continue;
      }

      std::vector<Job> jobs;
      for (int unit = 0; unit < units; unit++) {
        Job &job = jobs.emplace_back();
        job.accname = "Partial_mandelbrot";
        initParams(width, height, cre, cim, myzoom, 256, buffer, job.params);
        multParams(width, height, cre, cim, myzoom, 256, buffer, job.params, unit, units);
      }

      auto start = std::chrono::high_resolution_clock::now();
      fpgaRpc.Run(jobs);
      auto stop = std::chrono::high_resolution_clock::now();
      int duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count();
      *timerVariable = duration;
    }
  }

  void OnUpdate(wxCommandEvent& event) {
    updateFrames();
  }

  void copySobelData(wxNativePixelData &dst, char *src) {
    wxNativePixelData::Iterator p(dst);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++, p++) {
        char iter = src[y*width+x];
        p.Red() = iter;
        p.Green() = iter;
        p.Blue() = iter;
      }
    }
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

  void OnAbout(wxCommandEvent& event) {
    wxMessageBox("wxMoni\nCS UoM 2019", "wxMoni", wxOK | wxICON_INFORMATION);
  }

  void OnExit(wxCommandEvent& event) {
    Close(true);
  }

  void OnClose(wxCloseEvent& event) {
    shuttingDown = true;
    if (toggleLoopActive)
      dispatcherThread1->join();
    dispatcherThread0->join();
    fpgaRpc0.Free(bufno0);
    fpgaRpc0.Free(bufno1);
    Destroy();
}


  wxDECLARE_EVENT_TABLE();
};


class MainApplication : public wxApp {
public:
  virtual bool OnInit() {
    MainFrame *frame = new MainFrame("wxmoni", wxPoint(50, 50), wxSize(500, 500));
    frame->Show(true);
    return true;
  }
};


wxBEGIN_EVENT_TABLE(MainFrame, wxFrame)
  EVT_MENU(wxID_ABOUT, MainFrame::OnAbout)
  EVT_MENU(wxID_EXIT,  MainFrame::OnExit)
  EVT_MENU(RELOAD_IMAGE,  MainFrame::OnUpdate)
  EVT_MENU(CALC_IMAGE,  MainFrame::OnCalc)
  EVT_MENU(LOOP_TOGGLE, MainFrame::OnTogggleLoop)
  EVT_CHOICE(UPDATE_UNITS,  MainFrame::OnUpdateSelection)
  EVT_TIMER(TIMER_TICK, MainFrame::OnTimerTick)
  EVT_CLOSE(MainFrame::OnClose)
wxEND_EVENT_TABLE()

wxIMPLEMENT_APP(MainApplication);
