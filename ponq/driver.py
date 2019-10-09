sysfs = "/sys/class/fpga_manager/fpga0"

import time
from mmio import mmio

class PonqException(Exception):
  pass

def setbit(data, bit): return data | (1 << bit)
def unsetbit(data, bit): return data & ~(1 << bit)

# manages the registers of a loaded peripheral
class AccelInst:
  def __init__(self, region, bitstream):
    self.region = region
    self.accel = bitstream.acc
    self.bitstream = bitstream
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
    for stub in self.bitstream.stubRegions:
      self.region.regions[stub].unload()


# manages a region of the shell
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
    # if we are a stub region
    if (self.region.name != bitstream.region):
      print("DRIVER: Stubing " + bitstream.acc.name + " into region " + self.region.name)
      self.loaded = True
      return None

    # if we are re-loading the last loaded bitstream
    if (bitstream == self.bitstream):
      print("DRIVER: Reusing " + bitstream.acc.name + " into region " + self.region.name)
      self.loaded = True
      return self.accel

    # if we are going through the entire load process
    print("DRIVER: Loading " + bitstream.acc.name + " into region " + self.region.name)

    self.accel = AccelInst(self, bitstream)
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
    bitstream = self.selectBitstream(accel)
    return self.loadBitstream(bitstream)

  def loadBitstream(self, bs):
    acc = self.regions[bs.region].loadBitstream(bs)
    for stub in bs.stubRegions:
      self.regions[stub].loadBitstream(bs)
    return acc

  def selectBitstream(self, accel):
    for bitstream in accel.bitfiles:
      if self.canQuickLoad(bitstream):
        return bitstream
    for bitstream in accel.bitfiles:
      if self.canLoad(bitstream):
        return bitstream
    raise PonqException("Could not find suitable region")

  def canLoad(self, bs):
    if self.regions[bs.region].loaded:
      return False
    for stub in bs.stubRegions:
      if self.regions[stub].loaded:
        return False
    return True

  def canQuickLoad(self, bs):
    if bs not in self.regions: return False
    reg = self.regions[bs.region]
    if reg.loaded or reg.bitstream is not bs:
      return False
    for stub in bs.stubRegions:
      stubreg = self.regions[stub]
      if stubreg.loaded or stubreg.bitstream is not bs:
        return False
    return True


class RegionInstStub:
  def __init__(self, fpga, address):
    self.mmio = mmio(address)
    self.fpga = fpga

  def unload(self):
    return self.fpga.unload()

# manages the sysfs fpga device and is the root of the bitstream graph
class FPGA:
  def __init__(self, manager):
    self.manager = manager
    self.flagfile = manager + "/flags"
    self.firmfile = manager + "/firmware"
    self.shell = None
    self.regionStub = None

  def loadShell(self, shell):
    if self.shell is not None: raise PonqException("called loadShell() on occupied fpga")
    self.writeFlags(0)
    self.writeBinfile(shell.bitfile.binfile)
    self.shell = ShellInst(self, shell)

  def loadBitstream(self, bs):
    if self.shell is not None:
      raise PonqException("called loadBitstream() on occupied fpga")
    self.writeFlags(0)
    self.writeBinfile(shell.bitfile.binfile)
    self.shell = ShellInst(self, shell)

  def loadAccel(self, accel):
    if self.shell is None:
      full_bs = [x for x in accel.bitfiles if x.isFull()]
      if len(full_bs) > 0:
        bs = full_bs[0]
        self.writeFlags(0)
        self.writeBinfile(bs.binfile)
        self.regionStub = RegionInstStub(self, bs.acc.address)
        self.shell = AccelInst(self.regionStub, bs)
        return self.shell

    if self.shell is None:
      raise PonqException("called loadAccel() on blank fpga")
    return self.shell.loadAccel(accel)

  def unload(self):
    if self.shell is None:
      raise PonqException("called unload() on blank fpga")
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
