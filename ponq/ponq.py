#!/usr/bin/env python3
import os
import repo, driver

print("PONQ: Starting...")

# manages the whole got damn thing
class Ponq:
  def __init__(self, repository="."):
    self.repo = repo.Repository(repository)
    self.fpga = driver.FPGA("/sys/class/fpga_manager/fpga0")
    self.fpga.loadShell(self.repo.shells[0])

  # loads the accelerator into an fpga
  def load(self, accname):
    acc = self.repo.getAccel(accname)
    return self.fpga.loadAccel(acc)
    # raise driver.PonqException("Could  not find suitable region to load bitstream")


  # loads and runs an accelerator in an fpga
  def run(self, accname, params):
    acc = self.load(accname)
    acc.setRegs(params)
    acc.run()
    acc.wait()
    acc.unload()
