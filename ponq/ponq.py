#!/usr/bin/env python3
import os
from . import repo, driver

# manages the whole got damn thing
class Ponq:
  def __init__(self, repository=".", bitpatchbin="../build/bit_patch_bin"):
    self.repo = repo.Repository(repository, bitpatchbin)
    self.fpga = driver.FPGA("/sys/class/fpga_manager/fpga0")

  # loads the accelerator into an fpga
  def load(self, accname):
    acc = self.repo.getAccel(accname)
    return self.fpga.loadAccel(acc)

  def loadShell(self, shellname):
    shells = [x for x in self.repo.shells if x.name == shellname]
    if len(shells) == 0: raise driver.PonqException("Failed to find shell")
    shell = shells[0]
    self.fpga.loadShell(shell)


  # loads and runs an accelerator in an fpga
  def run(self, accname, params):
    acc = self.load(accname)
    acc.setRegs(params)
    acc.run()
    acc.wait()
    acc.unload()
