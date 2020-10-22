#pragma once

#include "mmio.h"

#include <iostream>
#include <map>
#include <string>
#include <vector>


struct FPGAFullException : std::exception {
public:
  virtual char const * what() const throw(){ return "FPGA is full"; }
};

struct AccelNotFoundException : std::exception {
public:
  virtual char const * what() const throw(){ return "No such accelerator"; }
};

struct RegionNotFoundException : std::exception {
public:
  virtual char const * what() const throw(){ return "No such region"; }
};

struct NoSuchRegisterException : std::exception {
public:
  virtual char const * what() const throw(){ return "No such register"; }
};

typedef std::map<std::string, uint32_t> paramlist;

// represents an fpga bitstream which can be programmed onto an fpga
class Bitstream {
public:
  std::string bitstream, mainRegion;
  std::vector<std::string> stubRegions;
  int slotCount;
  bool multiSlot;
  Bitstream();
  Bitstream(std::string bits, std::string main, std::vector<std::string> stubs);
  Bitstream(std::string bits, std::string main);
  bool isInstalled();
  void install();
  bool isFull();
};



// represents an accelerator which can be loaded into the shell regions
class Accel {
public:
  std::string name;                       // name of this accelerator
  std::vector<Bitstream> bitstreams;      // bitstreams with this accelerator
  std::map<std::string, int> registers;   // register offsets of this accelerator
  long address;                           // address of peripheral when not using shell
  Accel();
  Accel(std::string name);
  void addBitstream(const Bitstream &bits);
  void addRegister(std::string name, int offset);
  int getRegister(std::string name);
  void setupSiblings();
  static Accel loadFromJSON(std::string jsonpath);
};



class Shell {
  public:
  std::string name, bitstream;
  std::map<std::string, std::string> blanks;
  std::map<std::string, long> blockers;
  std::map<std::string, long> addrs;
  
  static Shell loadFromJSON(std::string jsonpath);
  bool isInstalled();
  void install();
};


// represents a slot in the shell
class Region {
public:
  std::string name;               // region name
  Bitstream blank;                // blanking bitstream

  long blockerAddr;               // blocker address
  mapped_device blockerDev;       // mapped blocker
  uint8_t *blockerRegs;           // blocker registers

  long periphAddr;                // peripheral address
  mapped_device periphDev;        // mapped peripheral registers
  uint32_t *periphRegs;           // mapped peripheral regs (u32)

  bool mapped;                    // is the blocker and peripheral mmap-ped?

  Accel *accel;                   // currently (or last) loaded accelerator
  Bitstream *bitstream;           // currently (or last) loaded bitstream
  bool stub;                      // this accelerator is contolled elsewhere
  bool locked;                    // accelerator is in use

  // uninintialised region
  Region();
  Region(std::string name, std::string blankName, long blocker, long address);
  ~Region();

  // copy constructo and assign operato is deleteo
  Region(const Region& a) = delete;
  Region& operator=(const Region& a) = delete;

  // moove constructo and moove assignment
  Region(Region&& a);
  Region& operator=(Region&& a);

  // mmap blockers and peripheral address ranges
  void mapDevs();
  void unmapDevs();

  void setBlock(bool status);
  bool canElideLoad(Bitstream &bs);
  void loadAccel(Accel &acc, Bitstream &bs);
  void loadStub(Accel &acc, Bitstream &bs);
  void unloadAccel();
};


class AccelInst {
public:
  Accel *accel;             // accelerator
  Bitstream *bitstream;     // bitstream loaded
  Region *region;           // controlling region
  
  void programAccel(paramlist &regvals);
  void runAccel();
  bool running();
  void wait();
};

class PRManager;

class StaticAccelInst {
public:
  Accel *accel;
  Bitstream *bitstream;
  PRManager *prmanager;
  
  void programAccel(paramlist &regvals);
  void runAccel();
  bool running();
  void wait();
  void unload();
};


// manages the fpga, its regions, accelerators, and jobs
class PRManager {
public:
  std::map<std::string, Region> regions;
  std::map<std::string, Shell> shells;    // loadable shells  
  std::map<std::string, Accel> accels;    // loadable accelerators
  
  Shell *shell = nullptr;
  Accel *accel = nullptr;
  mapped_device accelMap;
  uint32_t *accelRegs;

  PRManager();

  void fpgaLoadRegions(Accel& acc, Bitstream &bs);
  void fpgaUnloadRegions(AccelInst &inst);
  AccelInst fpgaLoad(std::string accname);
  AccelInst fpgaRun(std::string accname, paramlist &regvals);

  // check if regions used by a bitstream are free and cached
  bool canQuickLoadBitstream(Bitstream &bs);
  bool canLoadBitstream(Bitstream &bs);

  void fpgaLoadShell(std::string name);
  StaticAccelInst fpgaLoadStatic(std::string name);
  
  // sets up initial datastructures with bitstream info
  void importAccel(std::string name);
  void importShell(std::string name);
  void importDefs();
};
