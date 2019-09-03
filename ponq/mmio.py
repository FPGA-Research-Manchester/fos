import mmap, os, numpy as np, sys

class mmio:
  def __init__(self, reqbase):
    self.reqbase = int(reqbase)
    # self.reqrange = int(reqrange) % mmap.PAGESIZE
    self.reqrange = mmap.PAGESIZE

    # align requested range to page boundaries
    #self.base = reqbase & ~(mmap.PAGESIZE - 1)  # chops off sub-page bits
    #self.shift = self.reqbase - self.base       # calculates window shift
    #self.range = self.shift + self.reqrange     # adds shift value to range

    self.devmem = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)
    self.memmap = mmap.mmap(self.devmem, self.reqrange, mmap.MAP_SHARED,
        mmap.PROT_READ | mmap.PROT_WRITE, offset=self.reqbase)

    # create numpy uint32 array from buffer
    # self.array = np.frombuffer(self.memmap, np.uint32, int(self.reqrange/4))

  def write(self, address, value):
    byteval = value.to_bytes(4, byteorder=sys.byteorder)
    self.memmap[address*4:(address+1)*4] = byteval

  def read(self, address):
    byteval = self.memmap[address*4:(address+1)*4]
    value = int.from_bytes(byteval, byteorder=sys.byteorder)
    return value

  def close(self):
    self.memmap.close()
    os.close(self.devmem)
