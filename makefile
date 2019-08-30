.DEFAULT_GOAL := all

WX_FLAGS    := $(shell wx-config --cxxflags)
WX_LIBS     := $(shell wx-config --libs)
PROTO_FLAGS := $(shell pkg-config --cflags protobuf)
PROTO_LIBS  := $(shell pkg-config --libs protobuf)
GRPC_LIBS   := /usr/lib/libgrpc++.a /usr/lib/libgrpc.a  -lz -lssl -lm -lcrypto -lcares
OCV_FLAGS   := $(shell pkg-config --cflags opencv)
OCV_LIBS    := $(shell pkg-config --libs opencv)

CXXFLAGS := --std=gnu++17 -Wall -Wpedantic -g -O0 -I.
CXXFLAGS += $(OCV_FLAGS) $(PROTO_FLAGS) $(WX_FLAGS)
LDFLAGS  := -lstdc++fs
LDFLAGS  += $(GRPC_LIBS) $(OCV_LIBS) $(PROTO_LIBS) $(WX_LIBS)



SRC_BITPAT  := $(wildcard bit_patch/*.c)
SRC_DAEMON  := $(wildcard daemon/*.cpp)
SRC_CYNQ    := $(wildcard cynq/*.cpp)
SRC_PROTO   := proto/fpga_rpc_c.cc proto/fpga_rpc.pb.cc proto/fpga_rpc.grpc.pb.cc
SRC_UDMALIB := $(wildcard udmalib/*.cpp)
SRC_WXMONI  := $(wildcard wxmonitor/*.cpp)

OBJ_BITPAT  := $(addprefix build/, $(SRC_BITPAT:.c=.o))
OBJ_DAEMON  := $(addprefix build/, $(SRC_DAEMON:.cpp=.o))
OBJ_CYNQ    := $(addprefix build/, $(SRC_CYNQ:.cpp=.o))
OBJ_PROTO   := $(addprefix build/, $(SRC_PROTO:.cc=.o))
OBJ_UDMALIB := $(addprefix build/, $(SRC_UDMALIB:.cpp=.o))
OBJ_WXMONI  := $(addprefix build/, $(SRC_WXMONI:.cpp=.o))

CSERV_OBJS  := $(OBJ_DAEMON) $(OBJ_CYNQ) $(OBJ_UDMALIB) $(OBJ_BITPAT) $(OBJ_PROTO)
WXMONI_OBJS := $(OBJ_WXMONI) $(OBJ_UDMALIB) $(OBJ_PROTO)


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

# build directory
build:
	mkdir -p build/daemon build/cynq build/udmalib build/wxmonitor build/proto build/bit_patch

# fpga client src needs protos
proto/fpga_rpc_c.cc: proto/fpga_rpc.pb.h proto/fpga_rpc.grpc.pb.h

# cserv src depends on protos
$(SRC_CSERV): proto/fpga_rpc.pb.h proto/fpga_rpc.grpc.pb.h

# wxmoni src depends on protos
$(SRC_WXMONI): proto/fpga_rpc.pb.h proto/fpga_rpc.grpc.pb.h

build/daemon_bin: $(CSERV_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

build/wxmoni_bin: $(WXMONI_OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

clean:
	-rm -r build proto/*.pb.h proto/*.pb.cc

all: build/wxmoni_bin build/daemon_bin
