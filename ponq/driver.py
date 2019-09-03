sysfs = "/sys/class/fpga_manager/fpga0"

import time
from mmio import mmio

class PonqException(Exception):
  pass

def setbit(data, bit): return data | (1 << bit)
def unsetbit(data, bit): return data & ~(1 << bit)

# manages the registers of a loaded peripheral
class AccelInst:
  def __init__(self, region, accel):
    self.region = region
    self.accel = accel
    self.mmio = region.mmio

  def setRegs(self, regs):
    for key in regs:
      self.writeReg(key, regs[key])

  def readReg(self, regname):
    return self.mmio.read(int(self.accel.registers[regname] / 4))

  def writeReg(self, regname, value):
    self.mmio.write(int(self.accel.registers[regname] / 4), value)

  def run(self):
    self.writeReg("control", 1)

  def running(self):
    return (self.readReg("control") & 4) == 0

  def wait(self):
    while(self.running()):
      pass

  def unload(self):
    self.region.unload()


class RegionInst:
  def __init__(self, shell, region):
    self.region = region
    self.shell = shell
    self.blocker = mmio(region.blocker)
    self.mmio = mmio(region.address)
    self.accel = None
    self.bitstream = None
    self.loaded = False

  def loadBitstream(self, bitstream):
    if (bitstream == self.bitstream):
      self.loaded = True
      return self.accel

    print("DRIVER: Loading " + bitstream.acc.name + " into region " + self.region.name)

    self.accel = AccelInst(self, bitstream.acc)
    self.bitstream = bitstream
    self.loaded = True

    self.block(True)
    self.shell.fpga.writeFlags(1)
    self.shell.fpga.writeBinfile(self.region.blankstream.binfile)
    self.shell.fpga.writeBinfile(bitstream.binfile)
    self.block(False)

    return self.accel

  def unload(self):
    self.loaded = False

  def block(self, shouldSet):
    self.blocker.write(0, 1 if shouldSet else 0)



# manages a loaded bistream
class ShellInst:
  def __init__(self, fpga, shell):
    self.fpga = fpga
    self.shell = shell
    self.regions = {}
    print("DRIVER: Instanciating Shell {}".format(self.shell.name))
    for region in self.shell.regions:
      self.regions[region.name] = RegionInst(self, region)

  def loadAccel(self, accel):
    region, bitstream = self.findRegion(accel)
    return region.loadBitstream(bitstream)

  def findRegion(self, accel):
    for bitstream in accel.bitfiles:
      for regionname, region in self.regions.items():
        if not region.loaded and region.bitstream is bitstream:
          return (region, bitstream)
      for regionname, region in self.regions.items():
        if not region.loaded and regionname == bitstream.region:
          return (region, bitstream)
    raise PonqException("Could not find suitable region")



# manages the sysfs fpga device and is the root of the bitstream graph
class FPGA:
  def __init__(self, manager):
    self.manager = manager
    self.flagfile = manager + "/flags"
    self.firmfile = manager + "/firmware"
    self.shell = None

  def loadShell(self, shell):
    if self.shell is not None: raise PonqException("called loadShell() on occupied fpga")
    self.writeFlags(0)
    self.writeBinfile(shell.bitfile.binfile)
    self.shell = ShellInst(self, shell)

  def loadAccel(self, accel):
    if self.shell is None: raise PonqException("called loadAccel() on blank fpga")
    return self.shell.loadAccel(accel)

  def unload(self):
    if self.shell is None: raise PonqException("called unload() on blank fpga")
    self.shell = None

  def writeFlags(self, flags):
    with open(self.flagfile, "w") as flagfile:
      flagfile.write(str(flags))
      flagfile.close()

  def writeBinfile(self, inputfile):
    print("DRIVER: Loading bitfile " + inputfile + " onto " + self.manager)
    with open(self.firmfile, "w") as binout:
      binout.write(inputfile)
      binout.close()
