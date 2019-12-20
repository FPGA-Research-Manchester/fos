#include "cynq.h"
#include "mmio.h"
#include "json.hpp"
#include "fpga.h"

extern "C" {
  #include "bit_patch/bit_patch.h"
}

#include <experimental/filesystem>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

namespace fs = std::experimental::filesystem;

FPGAManager fpga0(0);

typedef std::map<std::string, uint32_t> paramlist;




Bitstream::Bitstream() {}

Bitstream::Bitstream(std::string bits, std::string main, std::vector<std::string> stubs) :
    bitstream(bits), mainRegion(main), stubRegions(stubs),
    slotCount(1 + stubs.size()), multiSlot(slotCount > 1) {}

Bitstream::Bitstream(std::string bits, std::string main) : Bitstream(bits, main, std::vector<std::string>()) {}

bool Bitstream::isInstalled() {
  std::string path = "/lib/firmware/" + bitstream;
  struct stat buffer;
  return (stat(path.c_str(), &buffer) == 0);
}
void Bitstream::install() {
  if (isInstalled()) return;
  fs::copy_file("../bitstreams/" + bitstream, "/lib/firmware/" + bitstream, \
     fs::copy_options::update_existing);
}

bool Bitstream::isFull() {
  return mainRegion == "full";
}

int zeroSlotID = 0;
std::map<std::string, int> slotIDs = {
  {"pr0", 0},
  {"pr1", 1},
  {"pr2", 2}
};



Accel::Accel() {}
Accel::Accel(std::string name) :
  name(name) {
}
void Accel::addBitstream(const Bitstream &bits) {
  bitstreams.push_back(bits);
  bitstreams.back().install();
}
void Accel::addRegister(std::string name, int offset) {
  registers[name] = offset;
}
int Accel::getRegister(std::string name) {
  return registers[name];
}


// for all 'base' (in slot zero) bitstreams 
//   for all slots which can fit bitstream (slotno < slotcount - bs.segcount)
//     if (bitstreams.contains(slotno, size)) continue;
//     new_bs_file = relocate_bitstream(old, new, slotno);
//     new_bs = Bitstream(new_bs_file, slotno, width)
//     bitstreams.add(new_bs)

void Accel::setupSiblings() {
  std::vector<Bitstream> oldbslist = bitstreams;
  for (Bitstream &bs : oldbslist) { // for each bitstream
    if (bs.isFull()) continue;
    if (slotIDs.find(bs.mainRegion) == slotIDs.end()) continue;
    if (slotIDs.at(bs.mainRegion) == zeroSlotID) { // if bitstream is a candidate (in slot zero)   
      std::cout << "Attempting to create siblings for " << bs.bitstream << std::endl;
      std::string relocatablebspath = "../bitstreams/" + bs.bitstream;
      for (auto &newSlot : slotIDs) { // for each slot in shell
        if (newSlot.second > slotIDs.size() - bs.slotCount) continue;
        bool exists = false;
        for (Bitstream &candidate : bitstreams) { // check if bitstream already exists
          if (candidate.slotCount == bs.slotCount && candidate.mainRegion == newSlot.first) {
            exists = true;
            break;
          }
        }
        if (exists) continue; // if not, we need to create it
        std::string newBSName = name + "_slot_" + std::to_string(newSlot.second);
        if (bs.slotCount > 1)
          newBSName += "_width_" + std::to_string(bs.slotCount);
        newBSName += ".gen.bin";
        std::cout << "  creating sibling " << newBSName << std::endl;
        std::string path = "../bitstreams/" + newBSName;
        struct stat buffer;
        if (stat(path.c_str(), &buffer) != 0) // if file doesn't exist (if stat() fails))
          if (relocate_bitstream_file(relocatablebspath.c_str(), path.c_str(), newSlot.second) != 0) // try to relocate
            throw std::runtime_error("Failed to relocate bitstream");
        std::vector<std::string> stubs;
        for (auto& stub : bs.stubRegions) {
          int id = slotIDs[stub];
          for (auto &slot : slotIDs)
            if (slot.second == id)
              stubs.push_back(slot.first);
        }
        addBitstream(Bitstream(newBSName, newSlot.first, stubs));
      }
    }
  }
}

Accel Accel::loadFromJSON(std::string jsonpath) {
  std::ifstream jsonfile(jsonpath);
  nlohmann::json json;
  jsonfile >> json;
  std::string name = json["name"];
  Accel accel(name);
  if (json.contains("address"))
    accel.address = std::stol(json["address"].get<std::string>().c_str(), nullptr, 0);
  else
    accel.address = 0;
  for (auto &bitfile : json["bitfiles"]) {
    if (bitfile.contains("stubregions")) {
      std::vector<std::string> stubs = bitfile["stubregions"];
      accel.addBitstream(Bitstream(bitfile["name"], bitfile["region"], stubs));
    } else {
      accel.addBitstream(Bitstream(bitfile["name"], bitfile["region"]));
    }
  }
  for (auto &reg : json["registers"])
    accel.addRegister(reg["name"], std::stoi(reg["offset"].get<std::string>().c_str(), nullptr, 0));
  accel.setupSiblings();
  return accel;
}




Shell Shell::loadFromJSON(std::string jsonpath) {
  std::ifstream jsonfile(jsonpath);
  nlohmann::json json;
  jsonfile >> json;
  
  Shell shell;
  shell.name = json["name"];
  shell.bitstream = json["bitfile"];
  for (auto &reg : json["regions"]) {
    shell.blanks[reg["name"]]  = reg["blank"];
    shell.blockers[reg["name"]] = std::stol(reg["bridge"].get<std::string>().c_str(), nullptr, 0);
    shell.addrs[reg["name"]]    = std::stol(reg["addr"].get<std::string>().c_str(), nullptr, 0);
  }
  shell.install();
  return shell;
}


bool Shell::isInstalled() {
  std::string path = "/lib/firmware/" + bitstream;
  struct stat buffer;
  return (stat(path.c_str(), &buffer) == 0);
}
void Shell::install() {
  if (isInstalled()) return;
  fs::copy_file("../bitstreams/" + bitstream, "/lib/firmware/" + bitstream, \
     fs::copy_options::update_existing);
}




Region::Region() :
    blockerAddr(0), periphAddr(0),
    mapped(false), locked(false) {}

Region::Region(std::string name, std::string blankName, long blocker, long address) :
    name(name), blank(blankName, name),
    blockerAddr(blocker), periphAddr(address),
    mapped(false), locked(false) {
  blank.install();
  mapDevs();
}

Region::~Region() {
  if (mapped)
    unmapDevs();
}

// moove constructo
Region::Region(Region&& a) :
    name(a.name), blank(a.blank),
    blockerAddr(a.blockerAddr), blockerDev(a.blockerDev), blockerRegs(a.blockerRegs),
    periphAddr(a.periphAddr), periphDev(a.periphDev), periphRegs(a.periphRegs), mapped(a.mapped),
    accel(a.accel), bitstream(a.bitstream), stub(a.stub), locked(a.locked) {
  // std::cout << "move consturctors" << std::endl;
  // we have stolen the mapping from the other object
  a.mapped = false;
}

// moove assignment
Region& Region::operator=(Region&& a) {
  // std::cout << "move assign" << std::endl;
  if (&a == this) return *this;
  if (mapped) unmapDevs();

  name = a.name;
  blank = a.blank;
  blockerAddr = a.blockerAddr;
  blockerDev = a.blockerDev;
  blockerRegs = a.blockerRegs;
  periphAddr = a.periphAddr;
  periphDev = a.periphDev;
  periphRegs = a.periphRegs;
  accel = a.accel;
  bitstream = a.bitstream;
  stub = a.stub;
  locked = a.locked;

  // we have yoinked the mmap's from the other object
  a.mapped = false;

  return *this;
}

// mmap blockers and peripheral address ranges
void Region::mapDevs() {
  std::cout << "Mmapping region " << name << ", " << (void*)periphAddr << ", " << (void*)blockerAddr << std::endl;
  // load blocker register mmap
  blockerDev = mmioGetMmap("/dev/mem", blockerAddr, 4);
  if (blockerDev.fd == -1)
    throw std::runtime_error("Could not load blocker mmio");
  blockerRegs = (uint8_t*)blockerDev.mmap;

  // load device register mmap
  periphDev = mmioGetMmap("/dev/mem", periphAddr, 4096);
  if (periphDev.fd == -1)
    throw std::runtime_error("could not mmap accel");
  periphRegs = (uint32_t*)periphDev.mmap;

  mapped = true;
}

// unmap blockers and peripherals
void Region::unmapDevs() {
  std::cout << "Munmapping region " << name << ", " << (void*)periphAddr << ", " << (void*)blockerAddr << std::endl;
  mmioFreeMmap(blockerDev);
  mmioFreeMmap(periphDev);
  mapped = false;
}

void Region::setBlock(bool status) {
  *blockerRegs = (status ? 1 : 0);
}

bool Region::canElideLoad(Bitstream &bs) {
  return &bs == bitstream;
}

void Region::loadAccel(Accel &acc, Bitstream &bs) {
  if (locked)
    throw std::runtime_error("loading onto locked accel");
  if (bitstream != &bs) { // yeet that bitstream
    std::cout << "Loading accelerator manually" << std::endl;
    setBlock(true);
    fpga0.loadPartial(blank.bitstream);
    fpga0.loadPartial(bs.bitstream);
    setBlock(false);

    stub = false;
    bitstream = &bs;
    accel = &acc;
  }
  locked = true;
}

void Region::loadStub(Accel &acc, Bitstream &bs) {
  if (locked)
    throw std::runtime_error("loading onto locked accel");
  if (bitstream != &bs) { // yeet that bitstream
    stub = true;
    bitstream = &bs;
    accel = &acc;
  } else {
    // opportunistic yeet elision
  }
  locked = true;
}

void Region::unloadAccel() {
  if (!locked)
    throw std::runtime_error("unloading from unlocked accel");
  locked = false;
}



void AccelInst::programAccel(paramlist &regvals) {
  if (!region->locked)
    throw std::runtime_error("running from unlocked accel");
  for (auto &param : regvals) {
    int offy = accel->getRegister(param.first) / 4;
    //std::cout << "setting " << param.first << ":" << offy << ":" << &regs[offy] << " to " << param.second << std::endl;
    region->periphRegs[offy] = param.second;
  }
}

void AccelInst::runAccel() {
  if (!region->locked)
    throw std::runtime_error("running from unlocked accel");
  // std::cout << "Starting Accelerator" << std::endl;
  int offy = accel->getRegister("control") / 4;
  region->periphRegs[offy] = 1;
}

bool AccelInst::running() {
  if (!region->locked)
    throw std::runtime_error("running from unlocked accel");
  int offy = accel->getRegister("control") / 4;
  return (region->periphRegs[offy] & 4) == 0;
}

void AccelInst::wait() {
  if (!region->locked)
    throw std::runtime_error("running from unlocked accel");
  int offy = accel->getRegister("control") / 4;
  while ((region->periphRegs[offy] & 4) == 0);
}



void StaticAccelInst::programAccel(paramlist &regvals) {
  if (!prmanager->accel)
    throw std::runtime_error("running from unlocked accel");
  for (auto &param : regvals) {
    int offy = accel->getRegister(param.first) / 4;
    //std::cout << "setting " << param.first << "(" << offy <<  "): " << param.second << std::endl;
    prmanager->accelRegs[offy] = param.second;
  }
}

void StaticAccelInst::runAccel() {
  if (!prmanager->accel)
    throw std::runtime_error("running from unlocked accel");
  // std::cout << "Starting Accelerator" << std::endl;
  int offy = accel->getRegister("control") / 4;
  prmanager->accelRegs[offy] = 1;
}

bool StaticAccelInst::running() {
  if (!prmanager->accel)
    throw std::runtime_error("running from unlocked accel");
  int offy = accel->getRegister("control") / 4;
  return (prmanager->accelRegs[offy] & 4) == 0;
}

void StaticAccelInst::wait() {
  if (!prmanager->accel)
    throw std::runtime_error("running from unlocked accel");
  int offy = accel->getRegister("control") / 4;
  while ((prmanager->accelRegs[offy] & 4) == 0);
}




// manages the fpga, its regions, accelerators, and jobs
PRManager::PRManager() {
  importDefs();
}

void PRManager::fpgaLoadRegions(Accel& acc, Bitstream &bs) {
  regions.at(bs.mainRegion).loadAccel(acc, bs);   // load main
  for (auto &stub : bs.stubRegions)               // load stubs
    regions.at(stub).loadStub(acc, bs);
}

void PRManager::fpgaUnloadRegions(AccelInst &inst) {
  regions.at(inst.bitstream->mainRegion).unloadAccel();  // unload main
  for (auto &stub : inst.bitstream->stubRegions)         // unload stubs
    regions.at(stub).unloadAccel();
}

// loads a region
AccelInst PRManager::fpgaRun(std::string accname, paramlist &regvals) {
  AccelInst inst = fpgaLoad(accname);
  inst.programAccel(regvals);
  inst.runAccel();
  return inst;
}

AccelInst PRManager::fpgaLoad(std::string accname) {
  Accel &toload = accels[accname];
  AccelInst instance;
  instance.accel = &toload;
  for (auto &bitstream : toload.bitstreams) {
    if (canQuickLoadBitstream(bitstream)) {
      Region &tohost = regions[bitstream.mainRegion];
      fpgaLoadRegions(toload, bitstream);
      instance.bitstream = &bitstream;
      instance.region = &tohost;
      return instance;
    }
  }
  for (auto &bitstream : toload.bitstreams) {
    if (canLoadBitstream(bitstream)) {
      Region &tohost = regions[bitstream.mainRegion];
      fpgaLoadRegions(toload, bitstream);
      instance.bitstream = &bitstream;
      instance.region = &tohost;
      return instance;
    }
  }
  throw std::runtime_error("couldn't find regions to load");
}

// check if regions used by a bitstream are free and cached
bool PRManager::canQuickLoadBitstream(Bitstream &bs) {
  try {
    Region &mainreg = regions.at(bs.mainRegion);
    if (!mainreg.locked && mainreg.canElideLoad(bs)) {
      for (std::string &stub : bs.stubRegions) {
        if (regions.at(stub).locked) {
          return false;
        }
      }
      return true;
    }
  } catch (std::out_of_range a) {
    return false;
  }
  return false;
}

// check if regions used by a bitstream are free
bool PRManager::canLoadBitstream(Bitstream &bs) {
  try {
    if (regions.at(bs.mainRegion).locked)
      return false;
    for (std::string &stub : bs.stubRegions)
      if (regions.at(stub).locked)
        return false;
  } catch (std::out_of_range a) {
    return false;
  }
  return true;
}

void PRManager::fpgaLoadShell(std::string name) {
  if (shell || accel)
    throw std::runtime_error("FPGA already loaded");

  Shell &toLoad = shells.at(name);
  for (auto& blank : toLoad.blanks)
    regions.try_emplace(blank.first, blank.first, blank.second, 
        toLoad.blockers[blank.first], toLoad.addrs[blank.first]);

  fpga0.loadFull(toLoad.bitstream);

  shell = &toLoad;
}

StaticAccelInst PRManager::fpgaLoadStatic(std::string name) {
  if (accel || shell) {
    throw std::runtime_error("FPGA already loaded");
  } else {
    Accel& acc = accels.at(name);
    Bitstream *bs = nullptr;
    for (auto& bitstream : acc.bitstreams)
      if (bitstream.isFull())
        bs = &bitstream;
    if (bs == nullptr)
      throw std::runtime_error("no suitable bitstream");
    StaticAccelInst inst;
    inst.accel = &acc;
    inst.bitstream  = bs;
    inst.prmanager = this;
    fpga0.loadFull(bs->bitstream);
    
    accelMap = mmioGetMmap("/dev/mem", acc.address, 4096);
    if (accelMap.fd == -1)
      throw std::runtime_error("could not mmap accel");
    accelRegs = (uint32_t*)accelMap.mmap;
    
    accel = &acc;
    return inst;
  }
}

void PRManager::importAccel(std::string name) {
  accels.emplace(name, Accel::loadFromJSON("../bitstreams/" + name + ".json"));
}

void PRManager::importShell(std::string name) {
  shells.emplace(name, Shell::loadFromJSON("../bitstreams/" + name + ".json"));
}

// sets up initial datastructures with bitstream info
void PRManager::importDefs() {
  std::ifstream jsonfile("../bitstreams/repo.json");
  nlohmann::json json;
  jsonfile >> json;

  importShell(json["shell"]);
  for (auto &accelname : json["accelerators"])
    importAccel(accelname);
}
