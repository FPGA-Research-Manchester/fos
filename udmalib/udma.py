import os.path
import numpy as np
import mmap

sysfs_root = "/sys/class/udmabuf"
devfs_root = "/dev/"

class udmadev:
  def __init__(self, devno):
    devname = "udmabuf" + str(devno)
    self.sysfs = sysfs_root + "/" + devname
    self.devfs = devfs_root + devname

    self.phys_addr = self.readSysfsInt("phys_addr")
    self.size = self.readSysfsInt("size")
    self.sync_mode = self.readSysfsInt("sync_mode")


  def readSysfsInt(self, filename):
    with open(self.sysfs + "/" + filename) as file:
      return int(file.readlines()[0], 0)

  def writeSysfsInt(self, filename, value):
    with open(self.sysfs + "/" + filename, "w") as file:
      file.write(str(value))

  def map(self):
    self.udmadev = os.open(self.devfs, os.O_RDWR | os.O_SYNC)
    self.udmamap = mmap.mmap(self.udmadev, self.size, mmap.MAP_SHARED,
        mmap.PROT_READ | mmap.PROT_WRITE)
    return np.frombuffer(self.udmamap, np.uint8, int(self.size))

class udmas:
  def __init__(self):
    self.devices = []
    for devno in range(8):
      path = sysfs_root + "/udmabuf" + str(devno)
      if os.path.exists(path):
        self.devices.append(udmadev(devno))

  def getDevice(self, index):
    return self.devices[index]

  def deviceCount(self):
    return len(self.devices)
