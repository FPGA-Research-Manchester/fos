#!/usr/bin/python3
import subprocess


# bit hackin funcs
def getMask(offset, length):
  return ((1 << length) - 1) << offset

def getBits(offset, length, base):
  return (base >> offset) & getMask(0, length)

def setBits(offset, length, base, val):
  return (base & ~getMask(offset, length)) | (val << offset)


# mmio functions
def mmioread(addr):
  val = int(subprocess.check_output(f"busybox devmem {hex(addr)}", shell=True), 0)
  print(f"Reading {hex(addr)}: {hex(val)}")
  return val

def mmiowrite(addr, data):
  print(f"Writing {hex(addr)}: {hex(data)}")
  subprocess.check_output(f"busybox devmem {hex(addr)} w {hex(data)}", shell=True)


# atb unit register offsets
atb_cmd_store_en_off = 0x6010 # one per atb
atb_resp_en_off      = 0x6014 # one per atb
atb_resp_type_off    = 0x6018 # one per atb
atb_prescale_off     = 0x6020 # common to block

# atb domians slcr bases
# 0: fpd switch -> pcie / gpu
# 1: fpd switch -> pl fpd axi 0
# 2: fpd switch -> pl fpd axi 1
fpd_base = 0xfd610000 
# 0: lpd switch -> pl lpd axi 0
# 1: lpd inbound -> lpd periphs
lpd_base = 0xff410000

# set timer val on timeout blocks
timer_val = 0x1e0c # 5 sec timeout


# atb domain manager
class ATB_Domain:
  def __init__(self, base, count):
    self.base = base

  def setTrackEnable(self, idx, enabled):
    addr = self.base + atb_cmd_store_en_off
    mmiowrite(addr, setBits(idx, 1, mmioread(addr), 1 if enabled else 0))

  def setRespEnable(self, idx, enabled):
    addr = self.base + atb_resp_en_off
    mmiowrite(addr, setBits(idx, 1, mmioread(addr), 1 if enabled else 0))

  def setRespType(self, idx, errtype):
    addr = self.base + atb_resp_type_off
    mmiowrite(addr, setBits(idx, 1, mmioread(addr), errtype))

  def setTimerScale(self, scale):
    addr = self.base + atb_prescale_off
    mmiowrite(addr, setBits(0, 16, mmioread(addr), scale))

  def setTimerEnable(self, enabled):
    addr = self.base + atb_prescale_off
    mmiowrite(addr, setBits(16, 1, mmioread(addr), 1 if enabled else 0))


# atb managers
fpd_timeouts = ATB_Domain(fpd_base, 3)
lpd_timeouts = ATB_Domain(lpd_base, 2)


# lpd blockers
print("Enabling LPD ATBs")
lpd_timeouts.setRespType(1, 1)
lpd_timeouts.setRespEnable(1, True)

print("Enabling LPD ATB Timers")
lpd_timeouts.setTimerScale(0x1e0c)
lpd_timeouts.setTimerEnable(True)

# fpd blockers
print("Enabling FPD ATBs")
fpd_timeouts.setRespType(1, 1)
fpd_timeouts.setRespEnable(1, True)
fpd_timeouts.setRespType(2, 1)
fpd_timeouts.setRespEnable(2, True)

print("Enabling FPD ATB Timer")
fpd_timeouts.setTimerScale(0x1e0c)
fpd_timeouts.setTimerEnable(True)

print("ATBs Enabled")
