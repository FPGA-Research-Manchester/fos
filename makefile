.DEFAULT_GOAL := all

WX_FLAGS    := $(shell wx-config --cxxflags)
WX_LIBS     := $(shell wx-config --libs)
PROTO_FLAGS := $(shell pkg-config --cflags protobuf)
PROTO_LIBS  := $(shell pkg-config --libs protobuf)
GRPC_LIBS   := /usr/lib/libgrpc++.a /usr/lib/libgrpc.a  -lz -lssl -lm -lcrypto -lcares
OCV_FLAGS   := $(shell pkg-config --cflags opencv)
OCV_LIBS    := $(shell pkg-config --libs opencv)

CXXFLAGS := --std=gnu++17 -Wall -Wpedantic -I.
CXXFLAGS += $(OCV_FLAGS) $(PROTO_FLAGS) $(WX_FLAGS)
LDFLAGS  := -lstdc++fs
LDFLAGS  += $(GRPC_LIBS) $(OCV_LIBS) $(PROTO_LIBS) $(WX_LIBS)



SRC_BITPAT_L  := bit_patch/bit_patch.c
SRC_BITPAT_D  := bit_patch/bit_patch_driver.c
SRC_DAEMON    := $(wildcard daemon/*.cpp)
SRC_CYNQ_E1   := cynq/examples/test.cpp
SRC_CYNQ_E2   := cynq/examples/test_full.cpp
SRC_CYNQ_E3   := cynq/examples/test_shrek.cpp
SRC_CYNQ      := $(wildcard cynq/*.cpp)
SRC_PROTO     := proto/fpga_rpc.pb.cc proto/fpga_rpc.grpc.pb.cc
SRC_PROTO_C   := proto/fpga_rpc_c.cc $(SRC_PROTO)
SRC_UDMALIB   := $(wildcard udmalib/*.cpp)
SRC_WXMONI_D  := $(wildcard clients/wxmonitor/wxmoni_double.cpp)
SRC_WXMONI_S  := $(wildcard clients/wxmonitor/wxmoni_sobel.cpp)
SRC_WXMONI_M  := $(wildcard clients/wxmonitor/wxmoni_mandel.cpp)
SRC_WXMONI_G  := $(wildcard clients/wxmonitor/wxmoni_shrek.cpp)
SRC_SIMPLECPP := $(wildcard clients/simple_cpp/*.cpp)
SRC_SIMPLEOCL := $(wildcard clients/simple_cpp_ocl/*.cpp)

OBJ_BITPAT_L   := $(addprefix build/, $(SRC_BITPAT_L:.c=.o))
OBJ_BITPAT_D   := $(addprefix build/, $(SRC_BITPAT_D:.c=.o))
OBJ_DAEMON     := $(addprefix build/, $(SRC_DAEMON:.cpp=.o))
OBJ_CYNQ       := $(addprefix build/, $(SRC_CYNQ:.cpp=.o))
OBJ_CYNQ_E1    := $(addprefix build/, $(SRC_CYNQ_E1:.cpp=.o))
OBJ_CYNQ_E2    := $(addprefix build/, $(SRC_CYNQ_E2:.cpp=.o))
OBJ_CYNQ_E3    := $(addprefix build/, $(SRC_CYNQ_E3:.cpp=.o))
OBJ_PROTO      := $(addprefix build/, $(SRC_PROTO:.cc=.o))
OBJ_PROTO_C    := $(addprefix build/, $(SRC_PROTO_C:.cc=.o))
OBJ_UDMALIB    := $(addprefix build/, $(SRC_UDMALIB:.cpp=.o))
OBJ_WXMONI_D   := $(addprefix build/, $(SRC_WXMONI_D:.cpp=.o))
OBJ_WXMONI_S   := $(addprefix build/, $(SRC_WXMONI_S:.cpp=.o))
OBJ_WXMONI_M   := $(addprefix build/, $(SRC_WXMONI_M:.cpp=.o))
OBJ_WXMONI_G   := $(addprefix build/, $(SRC_WXMONI_G:.cpp=.o))
OBJ_SIMPLECPP  := $(addprefix build/, $(SRC_SIMPLECPP:.cpp=.o))
OBJ_SIMPLEOCL  := $(addprefix build/, $(SRC_SIMPLEOCL:.cpp=.o))

CSERV_OBJS     := $(OBJ_DAEMON) $(OBJ_CYNQ) $(OBJ_UDMALIB) $(OBJ_BITPAT_L) $(OBJ_PROTO)
WXMONI_D_OBJS  := $(OBJ_WXMONI_D) $(OBJ_UDMALIB) $(OBJ_PROTO_C)
WXMONI_S_OBJS  := $(OBJ_WXMONI_S) $(OBJ_UDMALIB) $(OBJ_PROTO_C)
WXMONI_M_OBJS  := $(OBJ_WXMONI_M) $(OBJ_UDMALIB) $(OBJ_PROTO_C)
WXMONI_G_OBJS  := $(OBJ_WXMONI_G) $(OBJ_UDMALIB) $(OBJ_PROTO_C)
SIMPLECPP_OBJS := $(OBJ_SIMPLECPP) $(OBJ_UDMALIB) $(OBJ_PROTO_C)
SIMPLEOCL_OBJS := $(OBJ_SIMPLEOCL) $(OBJ_UDMALIB) $(OBJ_PROTO_C)
BITPAT_OBJS    := $(OBJ_BITPAT_D) $(OBJ_BITPAT_L)
CYNQ_E1_OBJS   := $(OBJ_CYNQ_E1) $(OBJ_CYNQ) $(OBJ_BITPAT_L) $(OBJ_UDMALIB)
CYNQ_E2_OBJS   := $(OBJ_CYNQ_E2) $(OBJ_CYNQ) $(OBJ_BITPAT_L) $(OBJ_UDMALIB)
CYNQ_E3_OBJS   := $(OBJ_CYNQ_E3) $(OBJ_CYNQ) $(OBJ_BITPAT_L) $(OBJ_UDMALIB)

PROTO_CXX_SRCS := proto/fpga_rpc.pb.h proto/fpga_rpc.grpc.pb.h
PROTO_PY_SRCS  := proto/fpga_rpc_pb2.py proto/fpga_rpc_pb2_grpc.py

build/%.o: %.cpp | build
	$(CXX) $(CXXFLAGS) -c -o $@ $^

build/%.o: %.cc | build
	$(CXX) $(CXXFLAGS) -c -o $@ $^

build/%.o: %.c | build
	$(CC) $(CFLAGS) -c -o $@ $^


# build c++ protobuf files
proto/%.pb.cc proto/%.pb.h: proto/%.proto
	protoc --cpp_out=. $^
proto/%.grpc.pb.cc proto/%.grpc.pb.h: proto/%.proto
	protoc --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` $^
proto/%_pb2_grpc.py proto/%_pb2.py: proto/%.proto
	python3 -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. $^

# build directory
build:
	mkdir -p build/daemon build/cynq build/udmalib build/proto build/bit_patch
	mkdir -p build/clients/wxmonitor build/clients/simple_cpp build/cynq/examples
	mkdir -p build/clients/simple_cpp_ocl

# fpga client, wxmoni and cserv depends on protos
proto/fpga_rpc_c.cc $(SRC_WXMONI_D) $(SRC_WXMONI_S) $(SRC_WXMONI_M) $(SRC_CSERV): $(PROTO_CXX_SRCS)

build/daemon_bin: $(CSERV_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/wxmoni_bin: $(WXMONI_D_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/wxmoni_sobel_bin: $(WXMONI_S_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/wxmoni_mandel_bin: $(WXMONI_M_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/wxmoni_shrek_bin: $(WXMONI_G_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS) -O3

build/simple_cpp_bin: $(SIMPLECPP_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/simple_ocl_bin: $(SIMPLEOCL_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/bit_patch_bin: $(BITPAT_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/cynq_example_bin: $(CYNQ_E1_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/cynq_example_full_bin: $(CYNQ_E2_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/cynq_example_shrek_bin: $(CYNQ_E3_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

clean:
	-rm -r build proto/*.pb.h proto/*.pb.cc proto/*_pb2.py proto/*_pb2_grpc.py

all: build/wxmoni_bin build/wxmoni_sobel_bin build/wxmoni_mandel_bin build/wxmoni_shrek_bin build/daemon_bin build/simple_cpp_bin build/simple_ocl_bin build/bit_patch_bin build/cynq_example_bin build/cynq_example_full_bin build/cynq_example_shrek_bin $(PROTO_PY_SRCS)
