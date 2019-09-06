// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Jun  6 17:09:05 2019
// Host        : joe-ubu-vm running 64-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/joe/Ultra96-PYNQ/Ultra96/sensors96b/sensors96b/sensors96b.srcs/sources_1/bd/sensors96b/ip/sensors96b_xlconcat_0_0/sensors96b_xlconcat_0_0_stub.v
// Design      : sensors96b_xlconcat_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu3eg-sbva484-1-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconcat_v2_1_1_xlconcat,Vivado 2018.2" *)
module sensors96b_xlconcat_0_0(In0, dout)
/* synthesis syn_black_box black_box_pad_pin="In0[0:0],dout[0:0]" */;
  input [0:0]In0;
  output [0:0]dout;
endmodule
