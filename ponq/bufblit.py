#!/usr/bin/env python3
from tkinter import *
from PIL import Image, ImageTk
import mmap, os, random, time, numpy as np

from ponq import Ponq

# parameters
testpath = "/home/xilinx/jupyter_notebooks/getting_started/images/logo.png"
realpath = "/dev/udmabuf0"
width = 640
height = 480
bufsize = width * height


# opens and maps the udmabuf
print("Opening and mapping buffer: " + realpath)
devmem = os.open(realpath, os.O_RDWR | os.O_SYNC)
memmap = mmap.mmap(devmem, length=bufsize, flags=mmap.MAP_SHARED, prot=mmap.PROT_READ | mmap.PROT_WRITE)
nparray = np.frombuffer(memmap, np.uint8, bufsize)
npview = nparray.view()
npview.shape = (height, width)
# gets the physical address of teh udmabuf
with open("/sys/class/udmabuf/udmabuf0/phys_addr") as udmafile:
  lines = udmafile.readlines()
  udmaPhysAddr = int(lines[0], 0)


# load ponk objects
ponq = Ponq(repository="../bitstreams")
mandelbrotDrivers = [None] * 3
mandelbrotUtil = [[], [], [], []]

def loadUnit(id):
  if mandelbrotDrivers[id] is None:
    mandelbrotDrivers[id] = ponq.load("Partial_mandelbrot")

# converts a char to a pixel
def char2pixel(data):
  return (data & 0xc0, (data << 2) & 0xe0, (data << 5) & 0xe0)

# setup 3d lut
lut3d = np.zeros((256, 3), dtype=np.uint8)
for i in range(256):
  lut3d[i] = char2pixel(i)

# fills the buffer with random data
def imageYeet(re, im, zoom):
  mandelbrotUtil[0].append(time.time())
  im = -im
  print("starting image dumping")
  t0 = time.time()
  w0 = re - zoom*width*0.5
  h0 = im - zoom*height*0.5
  for h in range(height):
    for w in range(width):
      c = (w0 + w*zoom) + (h0 + h*zoom)*1j
      acc = 0
      iter = 0
      while abs(acc) < 2 and iter < 256:
        acc = acc**2 + c
        iter = iter + 1
      npview[h][w] = iter - 1
  mandelbrotUtil[0].append(time.time())
  return time.time() - t0

# convert uint8 buffer from mandelbrot unit to rgb buffer for display
def bufferConvert(buffer):
  rgbarray = lut3d[npview]
  return rgbarray

# bit hacking functions for driving unit
fixpbits = 29
fixpfactor = 1 << fixpbits

def float2fix(value):
  return int(value * fixpfactor)

def fix2float(value):
  return value / fixpfactor

def round2fix(value):
  return fix2float(float2fix(value))

int32max = (1 << 32) - 1
def top32(data):
  return int((data >> 32) & int32max)

def bot32(data):
  return int(data & int32max)

def multiMandelParam(count, re, im, zoom):
  params = []
  nheight = int(height / count)
  im_base = im + (zoom*height) * 0.5
  for i in range(count):
    nim = im_base - (0.5+i) * (zoom*nheight)
    nbuffer = udmaPhysAddr + width*nheight*i
    params.append((width, nheight, re, nim, zoom, nbuffer))
  return params

# sets up the mandelbrot registers and, starts the unit and waits for competion
def runMandelbrot(unit, width, height, re, im, zoom, buffer):
  print("Programming unit {}: c={}+{}i z={}".format(unit, re, im, zoom))
  #if mandelbrotDrivers[unit] is None:
  loadUnit(unit)
  accel = mandelbrotDrivers[unit]
  accel.setRegs({
    "imageWidth":     width,
    "imageHeight":    height,
    "maxIterations":  256,
    "centreRealLow":  bot32(float2fix(re)),
    "centreRealHi":   top32(float2fix(re)),
    "centreImagLow":  bot32(float2fix(im)),
    "centreImagHi":   top32(float2fix(im)),
    "zoomLow":        bot32(float2fix(zoom)),
    "zoomHi":         top32(float2fix(zoom)),
    "framebufferLow": bot32(buffer),
    "framebufferHi":  top32(buffer)
  })
  accel.run()
  mandelbrotUtil[unit+1].append(time.time())

def waitMandelbrot(unit):
  #if mandelbrotDrivers[unit] is None:
  loadUnit(unit)
  accel = mandelbrotDrivers[unit]
  accel.wait() # wait for done bit
  mandelbrotUtil[unit+1].append(time.time())

def multiMandelbrot(factor, re, im, zoom):
  if factor is 0:
    return imageYeet(round2fix(re), round2fix(im), round2fix(zoom))
  zoom = fix2float(float2fix(zoom))
  params = multiMandelParam(factor, re, im, zoom)
  t0 = time.time()
  for unit in range(factor):
    param = params[unit]
    runMandelbrot(unit, param[0], param[1], param[2], param[3], param[4], param[5])
  for unit in range(factor):
    waitMandelbrot(unit)
  t1 = time.time()
  elapsed = t1 - t0
  print("Mandelbrot Processing took {}s".format(elapsed))
  return elapsed


# extracts the image from the buffer & does colour manip
def imageSucc():
  print("starting image processing")
  t0 = time.time()
  rgbarray = bufferConvert(nparray)
  t1 = time.time()
  print("Python RGB processing took {}s".format(t1-t0))
  print("loading processed image into PIL image")
  return Image.fromarray(rgbarray, "RGB")

class Window(Frame):
  def __init__(self, master=None):
    Frame.__init__(self, master)
    self.master = master
    self.pack(fill=BOTH, expand=1)

    self.master.resizable(False, False)


    self.slidercount = Scale(self, from_=0, to=3, orient=HORIZONTAL, resolution=1)
    self.slidercount.bind("<ButtonRelease-1>", self.refresh)
    self.slidercount.pack(fill=X)
    self.slidercount.set(3)

    
    self.sliderreal = Scale(self, from_=-2.0, to=2.0, orient=HORIZONTAL, resolution=0.0001)
    self.sliderreal.bind("<ButtonRelease-1>", self.refresh)
    self.sliderreal.pack(fill=X)
    self.sliderreal.set(-1.2582)
    
    self.sliderimag = Scale(self, from_=-2.0, to=2.0, orient=HORIZONTAL, resolution=0.0001)
    self.sliderimag.bind("<ButtonRelease-1>", self.refresh)
    self.sliderimag.pack(fill=X)
    self.sliderimag.set(0.3819)
    
    self.sliderzoom = Scale(self, from_=0, to=6, orient=HORIZONTAL, resolution=0.0001)
    self.sliderzoom.bind("<ButtonRelease-1>", self.refresh)
    self.sliderzoom.pack(fill=X)

    self.slidermoniscale = Scale(self, from_=1, to=100, orient=HORIZONTAL, resolution=1)
    self.slidermoniscale.pack(fill=X)
    self.slidermoniscale.set(20)

    self.loopbutton = Button(self, text="Start Loop")
    self.loopbutton.pack()
    self.loopbutton.bind("<Button>", self.looptoggle)

    self.textlabel = Label(self, text="Ready to scan")
    self.textlabel.pack()

    pilimg = Image.open(testpath)
    tkimg = ImageTk.PhotoImage(pilimg)

    self.imglabel = Label(self, image=tkimg)
    self.imglabel.image = tkimg
    self.imglabel.place(x=0, y=0)
    self.imglabel.bind("<Button>", self.refresh)
    self.imglabel.pack()

    self.canvas = Canvas(self, height=105)
    self.canvas.pack(fill=X, expand=True)

    self.looping = False

    #self.zoomlooper()
    self.monitorlooper()

  def printTiming(self, thing=None):
    self.canvas.delete("all")
    timenow = time.time()
    moniscale = self.slidermoniscale.get()
    for unit in range(len(mandelbrotUtil)):
      util = mandelbrotUtil[unit]
      times = len(util)
      completed = int(times / 2)
      running = (times % 2) == 1
      y0 = 5+25*unit
      y1 = y0 + 20
      rootx = 5
      if unit > 0:
        self.canvas.create_line(0, y0 - 2, width, y0 - 2)
        self.canvas.create_text(rootx, y0, text="HW-" + str(unit), anchor="nw")
      else:
        self.canvas.create_text(rootx, y0, text="Software", anchor="nw")
      for iterno in range(completed-1, -1, -1):
        x0 = rootx + (timenow - util[2*iterno]) * moniscale
        if x0 > width: x0 = width
        x1 = rootx + (timenow - util[2*iterno+1]) * moniscale
        if x1 > width: break
        self.canvas.create_rectangle(x0, y0, x1, y1, fill="blue")

  def looptoggle(self, thing=None):
    if self.looping:
      self.looping = False
      self.loopbutton.configure(text="Start Looping")
    else:
      self.looping = True
      self.master.after(1000, self.zoomlooper)
      self.loopbutton.configure(text="Stop Looping")

  def monitorlooper(self):
    now = time.time()
    self.printTiming()
    self.master.after(int(1000/60), self.monitorlooper)    

  def zoomlooper(self):
    print("loopan!")
    if not self.looping: return
    now = time.time()
    newzoom = self.sliderzoom.get()
    if newzoom >= 6:
      newzoom = 0
    else:
      newzoom += 0.1
    self.sliderzoom.set(newzoom)
    self.redraw()
    self.master.after(100, self.zoomlooper)

  def refresh(self, thingy=None):
    if not self.looping:
      self.redraw()
    

  def redraw(self):
    self.textlabel.configure(text="Running mandelbrot unit")
    parallelism = int(self.slidercount.get())
    zoomfactor = 0.1**(self.sliderzoom.get()+2)
    elapsed = multiMandelbrot(parallelism, self.sliderreal.get(), self.sliderimag.get(), zoomfactor)
    self.textlabel.configure(text="Scanning buffer")
    t0 = time.time()
    pilimg = imageSucc()
    tkimg = ImageTk.PhotoImage(pilimg)
    elapsed_rgb = time.time() - t0
    print("loading image into gui")
    self.imglabel.configure(image=tkimg)
    self.image = tkimg
    self.pack()
    status = "calc: {:.5}s on {} units!".format(elapsed, parallelism)
    self.textlabel.configure(text=status)

  

root = Tk()
app = Window(root)

root.wm_title("PR Mandelbrot Viewer")
root.mainloop()
