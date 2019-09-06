// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Thu Jun  6 17:09:15 2019
// Host        : joe-ubu-vm running 64-bit Ubuntu 18.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/joe/Ultra96-PYNQ/Ultra96/sensors96b/sensors96b/sensors96b.srcs/sources_1/bd/sensors96b/ip/sensors96b_axi_uart16550_0_0/sensors96b_axi_uart16550_0_0_sim_netlist.v
// Design      : sensors96b_axi_uart16550_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu3eg-sbva484-1-i
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "sensors96b_axi_uart16550_0_0,axi_uart16550,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "axi_uart16550,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module sensors96b_axi_uart16550_0_0
   (s_axi_aclk,
    s_axi_aresetn,
    ip2intc_irpt,
    freeze,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    baudoutn,
    ctsn,
    dcdn,
    ddis,
    dsrn,
    dtrn,
    out1n,
    out2n,
    rin,
    rtsn,
    rxrdyn,
    sin,
    sout,
    txrdyn);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 ACLK CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 99999900, PHASE 0.000, CLK_DOMAIN sensors96b_zynq_ultra_ps_e_0_0_pl_clk0" *) input s_axi_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 ARESETN RST" *) (* x_interface_parameter = "XIL_INTERFACENAME ARESETN, POLARITY ACTIVE_LOW" *) input s_axi_aresetn;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTERRUPT INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME INTERRUPT, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output ip2intc_irpt;
  input freeze;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999900, ID_WIDTH 0, ADDR_WIDTH 13, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN sensors96b_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *) input [12:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [12:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input s_axi_rready;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART BAUDOUTn" *) (* x_interface_parameter = "XIL_INTERFACENAME UART, BOARD.ASSOCIATED_PARAM UART_BOARD_INTERFACE" *) output baudoutn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART CTSn" *) input ctsn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART DCDn" *) input dcdn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART DDIS" *) output ddis;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART DSRn" *) input dsrn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART DTRn" *) output dtrn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART OUT1n" *) output out1n;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART OUT2n" *) output out2n;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART RI" *) input rin;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART RTSn" *) output rtsn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART RXRDYn" *) output rxrdyn;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART RxD" *) input sin;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART TxD" *) output sout;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART TXRDYn" *) output txrdyn;

  wire baudoutn;
  wire ctsn;
  wire dcdn;
  wire ddis;
  wire dsrn;
  wire dtrn;
  wire freeze;
  wire ip2intc_irpt;
  wire out1n;
  wire out2n;
  wire rin;
  wire rtsn;
  wire rxrdyn;
  wire s_axi_aclk;
  wire [12:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [12:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire sin;
  wire sout;
  wire txrdyn;
  wire NLW_U0_xout_UNCONNECTED;

  (* C_EXTERNAL_XIN_CLK_HZ = "25000000" *) 
  (* C_FAMILY = "zynquplus" *) 
  (* C_HAS_EXTERNAL_RCLK = "0" *) 
  (* C_HAS_EXTERNAL_XIN = "0" *) 
  (* C_IS_A_16550 = "1" *) 
  (* C_S_AXI_ACLK_FREQ_HZ = "99999900" *) 
  (* C_S_AXI_ADDR_WIDTH = "13" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  sensors96b_axi_uart16550_0_0_axi_uart16550 U0
       (.baudoutn(baudoutn),
        .ctsn(ctsn),
        .dcdn(dcdn),
        .ddis(ddis),
        .dsrn(dsrn),
        .dtrn(dtrn),
        .freeze(freeze),
        .ip2intc_irpt(ip2intc_irpt),
        .out1n(out1n),
        .out2n(out2n),
        .rclk(1'b0),
        .rin(rin),
        .rtsn(rtsn),
        .rxrdyn(rxrdyn),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .sin(sin),
        .sout(sout),
        .txrdyn(txrdyn),
        .xin(1'b0),
        .xout(NLW_U0_xout_UNCONNECTED));
endmodule

(* ORIG_REF_NAME = "address_decoder" *) 
module sensors96b_axi_uart16550_0_0_address_decoder
   (chipSelect_reg,
    bus2ip_rdce_i,
    Wr,
    bus2ip_wrce_i,
    s_axi_aclk,
    Q,
    s_axi_aresetn,
    IP2Bus_RdAcknowledge_reg,
    IP2Bus_WrAcknowledge_reg,
    bus2ip_rnw_i_reg,
    wrReq_d1);
  output chipSelect_reg;
  output bus2ip_rdce_i;
  output Wr;
  output bus2ip_wrce_i;
  input s_axi_aclk;
  input Q;
  input s_axi_aresetn;
  input IP2Bus_RdAcknowledge_reg;
  input IP2Bus_WrAcknowledge_reg;
  input bus2ip_rnw_i_reg;
  input wrReq_d1;

  wire Bus_RNW_reg;
  wire Bus_RNW_reg_i_1_n_0;
  wire \GEN_BKEND_CE_REGISTERS[0].ce_out_i[0]_i_1_n_0 ;
  wire IP2Bus_RdAcknowledge_reg;
  wire IP2Bus_WrAcknowledge_reg;
  wire Q;
  wire Wr;
  wire bus2ip_rdce_i;
  wire bus2ip_rnw_i_reg;
  wire bus2ip_wrce_i;
  wire chipSelect_reg;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire wrReq_d1;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    Bus_RNW_reg_i_1
       (.I0(bus2ip_rnw_i_reg),
        .I1(Q),
        .I2(Bus_RNW_reg),
        .O(Bus_RNW_reg_i_1_n_0));
  FDRE Bus_RNW_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Bus_RNW_reg_i_1_n_0),
        .Q(Bus_RNW_reg),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h000000E0)) 
    \GEN_BKEND_CE_REGISTERS[0].ce_out_i[0]_i_1 
       (.I0(chipSelect_reg),
        .I1(Q),
        .I2(s_axi_aresetn),
        .I3(IP2Bus_RdAcknowledge_reg),
        .I4(IP2Bus_WrAcknowledge_reg),
        .O(\GEN_BKEND_CE_REGISTERS[0].ce_out_i[0]_i_1_n_0 ));
  FDRE \GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GEN_BKEND_CE_REGISTERS[0].ce_out_i[0]_i_1_n_0 ),
        .Q(chipSelect_reg),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    bus2ip_rdreq_d1_i_1
       (.I0(chipSelect_reg),
        .I1(Bus_RNW_reg),
        .O(bus2ip_rdce_i));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    wrReq_d1_i_1
       (.I0(chipSelect_reg),
        .I1(Bus_RNW_reg),
        .O(bus2ip_wrce_i));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h04)) 
    wr_d_i_1
       (.I0(Bus_RNW_reg),
        .I1(chipSelect_reg),
        .I2(wrReq_d1),
        .O(Wr));
endmodule

(* ORIG_REF_NAME = "axi_lite_ipif" *) 
module sensors96b_axi_uart16550_0_0_axi_lite_ipif
   (ce_out_i,
    s_axi_rvalid,
    s_axi_bvalid,
    s_axi_rdata,
    \addr_d_reg[2] ,
    bus2ip_rdce_i,
    Wr,
    bus2ip_wrce_i,
    bus2ip_reset_int_core,
    s_axi_arvalid,
    s_axi_aclk,
    s_axi_aresetn,
    IP2Bus_RdAcknowledge_reg,
    IP2Bus_WrAcknowledge_reg,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_bready,
    s_axi_rready,
    s_axi_araddr,
    s_axi_awaddr,
    Q,
    wrReq_d1);
  output ce_out_i;
  output s_axi_rvalid;
  output s_axi_bvalid;
  output [7:0]s_axi_rdata;
  output [2:0]\addr_d_reg[2] ;
  output bus2ip_rdce_i;
  output Wr;
  output bus2ip_wrce_i;
  input bus2ip_reset_int_core;
  input s_axi_arvalid;
  input s_axi_aclk;
  input s_axi_aresetn;
  input IP2Bus_RdAcknowledge_reg;
  input IP2Bus_WrAcknowledge_reg;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input s_axi_bready;
  input s_axi_rready;
  input [2:0]s_axi_araddr;
  input [2:0]s_axi_awaddr;
  input [7:0]Q;
  input wrReq_d1;

  wire IP2Bus_RdAcknowledge_reg;
  wire IP2Bus_WrAcknowledge_reg;
  wire [7:0]Q;
  wire Wr;
  wire [2:0]\addr_d_reg[2] ;
  wire bus2ip_rdce_i;
  wire bus2ip_reset_int_core;
  wire bus2ip_wrce_i;
  wire ce_out_i;
  wire s_axi_aclk;
  wire [2:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire [2:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [7:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire s_axi_wvalid;
  wire wrReq_d1;

  sensors96b_axi_uart16550_0_0_slave_attachment I_SLAVE_ATTACHMENT
       (.IP2Bus_RdAcknowledge_reg(IP2Bus_RdAcknowledge_reg),
        .IP2Bus_WrAcknowledge_reg(IP2Bus_WrAcknowledge_reg),
        .Q(Q),
        .Wr(Wr),
        .\addr_d_reg[2] (\addr_d_reg[2] ),
        .bus2ip_rdce_i(bus2ip_rdce_i),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .bus2ip_wrce_i(bus2ip_wrce_i),
        .chipSelect_reg(ce_out_i),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wvalid(s_axi_wvalid),
        .wrReq_d1(wrReq_d1));
endmodule

(* C_EXTERNAL_XIN_CLK_HZ = "25000000" *) (* C_FAMILY = "zynquplus" *) (* C_HAS_EXTERNAL_RCLK = "0" *) 
(* C_HAS_EXTERNAL_XIN = "0" *) (* C_IS_A_16550 = "1" *) (* C_S_AXI_ACLK_FREQ_HZ = "99999900" *) 
(* C_S_AXI_ADDR_WIDTH = "13" *) (* C_S_AXI_DATA_WIDTH = "32" *) (* ORIG_REF_NAME = "axi_uart16550" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module sensors96b_axi_uart16550_0_0_axi_uart16550
   (s_axi_aclk,
    s_axi_aresetn,
    ip2intc_irpt,
    freeze,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready,
    baudoutn,
    ctsn,
    dcdn,
    ddis,
    dsrn,
    dtrn,
    out1n,
    out2n,
    rclk,
    rin,
    rtsn,
    rxrdyn,
    sin,
    sout,
    txrdyn,
    xin,
    xout);
  (* max_fanout = "10000" *) input s_axi_aclk;
  (* max_fanout = "10000" *) input s_axi_aresetn;
  (* sigis = "INTERRUPT" *) output ip2intc_irpt;
  input freeze;
  input [12:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [12:0]s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;
  output baudoutn;
  input ctsn;
  input dcdn;
  output ddis;
  input dsrn;
  output dtrn;
  output out1n;
  output out2n;
  (* sigis = "CLK" *) input rclk;
  input rin;
  output rtsn;
  output rxrdyn;
  input sin;
  output sout;
  output txrdyn;
  (* sigis = "CLK" *) input xin;
  output xout;

  wire \<const0> ;
  wire [2:0]Addr;
  wire [7:0]Dout;
  wire \IPIC_IF_I_1/wrReq_d1 ;
  wire \I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i ;
  wire Wr;
  wire baudoutn;
  wire bus2ip_rdce_i;
  wire bus2ip_reset_int_core;
  wire bus2ip_reset_int_core_i_1_n_0;
  wire bus2ip_wrce_i;
  wire ctsn;
  wire dcdn;
  wire ddis;
  wire dsrn;
  wire dtrn;
  wire freeze;
  wire ip2intc_irpt;
  wire out1n;
  wire out2n;
  wire rin;
  wire rtsn;
  wire rxrdyn;
  (* MAX_FANOUT = "10000" *) (* RTL_MAX_FANOUT = "found" *) wire s_axi_aclk;
  wire [12:0]s_axi_araddr;
  (* MAX_FANOUT = "10000" *) (* RTL_MAX_FANOUT = "found" *) wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [12:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [7:0]\^s_axi_rdata ;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire s_axi_wvalid;
  wire sin;
  wire sout;
  wire txrdyn;

  assign s_axi_awready = s_axi_wready;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7:0] = \^s_axi_rdata [7:0];
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign xout = \<const0> ;
  sensors96b_axi_uart16550_0_0_axi_lite_ipif AXI_LITE_IPIF_I
       (.IP2Bus_RdAcknowledge_reg(s_axi_arready),
        .IP2Bus_WrAcknowledge_reg(s_axi_wready),
        .Q(Dout),
        .Wr(Wr),
        .\addr_d_reg[2] (Addr),
        .bus2ip_rdce_i(bus2ip_rdce_i),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .bus2ip_wrce_i(bus2ip_wrce_i),
        .ce_out_i(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i ),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr[4:2]),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr[4:2]),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(\^s_axi_rdata ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wvalid(s_axi_wvalid),
        .wrReq_d1(\IPIC_IF_I_1/wrReq_d1 ));
  GND GND
       (.G(\<const0> ));
  sensors96b_axi_uart16550_0_0_xuart XUART_I_1
       (.Q(Dout),
        .Wr(Wr),
        .baudoutn(baudoutn),
        .\bus2ip_addr_i_reg[4] (Addr),
        .bus2ip_rdce_i(bus2ip_rdce_i),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .bus2ip_wrce_i(bus2ip_wrce_i),
        .ce_out_i(\I_SLAVE_ATTACHMENT/I_DECODER/ce_out_i ),
        .ctsn(ctsn),
        .dcdn(dcdn),
        .ddis(ddis),
        .dsrn(dsrn),
        .dtrn(dtrn),
        .freeze(freeze),
        .ip2intc_irpt(ip2intc_irpt),
        .out1n(out1n),
        .out2n(out2n),
        .rin(rin),
        .rtsn(rtsn),
        .rxrdyn(rxrdyn),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_arready(s_axi_arready),
        .s_axi_wdata(s_axi_wdata[7:0]),
        .s_axi_wready(s_axi_wready),
        .sin(sin),
        .sout(sout),
        .txrdyn(txrdyn),
        .wrReq_d1(\IPIC_IF_I_1/wrReq_d1 ));
  LUT1 #(
    .INIT(2'h1)) 
    bus2ip_reset_int_core_i_1
       (.I0(s_axi_aresetn),
        .O(bus2ip_reset_int_core_i_1_n_0));
  FDRE bus2ip_reset_int_core_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bus2ip_reset_int_core_i_1_n_0),
        .Q(bus2ip_reset_int_core),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "cntr_incr_decr_addn_f" *) 
module sensors96b_axi_uart16550_0_0_cntr_incr_decr_addn_f
   (fifo_full_p1,
    Q,
    tx_fifo_rd_en_int,
    \GENERATING_FIFOS.fcr_reg[0] ,
    Tx_fifo_rd_en_reg,
    tx_fifo_wr_en_d,
    tx_fifo_full,
    tx_fifo_wr_en_i,
    SS,
    s_axi_aclk);
  output fifo_full_p1;
  output [4:0]Q;
  input tx_fifo_rd_en_int;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input Tx_fifo_rd_en_reg;
  input tx_fifo_wr_en_d;
  input tx_fifo_full;
  input tx_fifo_wr_en_i;
  input [0:0]SS;
  input s_axi_aclk;

  wire FIFO_Full_i_2_n_0;
  wire FIFO_Full_i_3_n_0;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire \INFERRED_GEN.cnt_i[4]_i_3_n_0 ;
  wire [4:0]Q;
  wire [0:0]SS;
  wire Tx_fifo_rd_en_reg;
  wire [4:0]addr_i_p1;
  wire fifo_full_p1;
  wire s_axi_aclk;
  wire tx_fifo_full;
  wire tx_fifo_rd_en_int;
  wire tx_fifo_wr_en_d;
  wire tx_fifo_wr_en_i;

  LUT6 #(
    .INIT(64'h0000000040141414)) 
    FIFO_Full_i_1
       (.I0(FIFO_Full_i_2_n_0),
        .I1(FIFO_Full_i_3_n_0),
        .I2(Q[3]),
        .I3(tx_fifo_rd_en_int),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(Q[4]),
        .O(fifo_full_p1));
  LUT6 #(
    .INIT(64'hDD7DFFDFFFFFBBFB)) 
    FIFO_Full_i_2
       (.I0(Q[2]),
        .I1(Tx_fifo_rd_en_reg),
        .I2(tx_fifo_wr_en_d),
        .I3(tx_fifo_full),
        .I4(Q[0]),
        .I5(Q[1]),
        .O(FIFO_Full_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFF0800EFEE0000)) 
    FIFO_Full_i_3
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(tx_fifo_full),
        .I3(tx_fifo_wr_en_d),
        .I4(Tx_fifo_rd_en_reg),
        .I5(Q[1]),
        .O(FIFO_Full_i_3_n_0));
  LUT6 #(
    .INIT(64'h9A9A9A9A659A9A9A)) 
    \INFERRED_GEN.cnt_i[0]_i_1 
       (.I0(Q[0]),
        .I1(tx_fifo_full),
        .I2(tx_fifo_wr_en_d),
        .I3(tx_fifo_rd_en_int),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(Q[4]),
        .O(addr_i_p1[0]));
  LUT6 #(
    .INIT(64'h6555AAAAAAAA9AAA)) 
    \INFERRED_GEN.cnt_i[1]_i_1 
       (.I0(Q[1]),
        .I1(Q[4]),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(tx_fifo_rd_en_int),
        .I4(Q[0]),
        .I5(tx_fifo_wr_en_i),
        .O(addr_i_p1[1]));
  LUT6 #(
    .INIT(64'hFBFFFF5D040000A2)) 
    \INFERRED_GEN.cnt_i[2]_i_1 
       (.I0(Tx_fifo_rd_en_reg),
        .I1(tx_fifo_wr_en_d),
        .I2(tx_fifo_full),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(Q[2]),
        .O(addr_i_p1[2]));
  LUT6 #(
    .INIT(64'hFF7FFEFF00800100)) 
    \INFERRED_GEN.cnt_i[3]_i_1 
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(tx_fifo_wr_en_i),
        .I3(Tx_fifo_rd_en_reg),
        .I4(Q[1]),
        .I5(Q[3]),
        .O(addr_i_p1[3]));
  LUT6 #(
    .INIT(64'h22221222222E2222)) 
    \INFERRED_GEN.cnt_i[4]_i_1 
       (.I0(Q[4]),
        .I1(Tx_fifo_rd_en_reg),
        .I2(Q[3]),
        .I3(Q[1]),
        .I4(\INFERRED_GEN.cnt_i[4]_i_3_n_0 ),
        .I5(Q[2]),
        .O(addr_i_p1[4]));
  LUT6 #(
    .INIT(64'hDFDFDFDF45DFDFDF)) 
    \INFERRED_GEN.cnt_i[4]_i_3 
       (.I0(Q[0]),
        .I1(tx_fifo_full),
        .I2(tx_fifo_wr_en_d),
        .I3(tx_fifo_rd_en_int),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(Q[4]),
        .O(\INFERRED_GEN.cnt_i[4]_i_3_n_0 ));
  FDSE \INFERRED_GEN.cnt_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[0]),
        .Q(Q[0]),
        .S(SS));
  FDSE \INFERRED_GEN.cnt_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[1]),
        .Q(Q[1]),
        .S(SS));
  FDSE \INFERRED_GEN.cnt_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[2]),
        .Q(Q[2]),
        .S(SS));
  FDSE \INFERRED_GEN.cnt_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[3]),
        .Q(Q[3]),
        .S(SS));
  FDSE \INFERRED_GEN.cnt_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[4]),
        .Q(Q[4]),
        .S(SS));
endmodule

(* ORIG_REF_NAME = "cntr_incr_decr_addn_f" *) 
module sensors96b_axi_uart16550_0_0_cntr_incr_decr_addn_f_0
   (\lsr_reg[0] ,
    lsr2_rst_reg,
    Rx_fifo_trigger_reg,
    fifo_full_p1,
    \lsr_reg[0]_0 ,
    lsr2_set,
    lsr4_set,
    lsr3_set,
    Q,
    lsr_reg0,
    \GENERATING_FIFOS.fcr_reg[0] ,
    character_received,
    \lsr_reg[0]_1 ,
    rd_d_reg,
    chipSelect,
    wr_d,
    rx_fifo_rd_en_d,
    lsr2_rst,
    rx_fifo_wr_en_i,
    chipSelect_reg,
    \addr_d_reg[0] ,
    bus2ip_reset_int_core,
    \GENERATING_FIFOS.fcr_reg[7] ,
    \Lcr_reg[3] ,
    in,
    out,
    rx_fifo_rd_en_d1,
    rx_fifo_rst,
    s_axi_aclk);
  output [4:0]\lsr_reg[0] ;
  output lsr2_rst_reg;
  output Rx_fifo_trigger_reg;
  output fifo_full_p1;
  output \lsr_reg[0]_0 ;
  output lsr2_set;
  output lsr4_set;
  output lsr3_set;
  input [0:0]Q;
  input lsr_reg0;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input character_received;
  input \lsr_reg[0]_1 ;
  input rd_d_reg;
  input chipSelect;
  input wr_d;
  input rx_fifo_rd_en_d;
  input lsr2_rst;
  input rx_fifo_wr_en_i;
  input chipSelect_reg;
  input \addr_d_reg[0] ;
  input bus2ip_reset_int_core;
  input [1:0]\GENERATING_FIFOS.fcr_reg[7] ;
  input [0:0]\Lcr_reg[3] ;
  input [2:0]in;
  input [2:0]out;
  input rx_fifo_rd_en_d1;
  input rx_fifo_rst;
  input s_axi_aclk;

  wire FIFO_Full_i_2__0_n_0;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire [1:0]\GENERATING_FIFOS.fcr_reg[7] ;
  wire \INFERRED_GEN.cnt_i[3]_i_2_n_0 ;
  wire \INFERRED_GEN.cnt_i[4]_i_2__0_n_0 ;
  wire \INFERRED_GEN.cnt_i[4]_i_3__0_n_0 ;
  wire [0:0]\Lcr_reg[3] ;
  wire [0:0]Q;
  wire Rx_fifo_trigger_i_2_n_0;
  wire Rx_fifo_trigger_reg;
  wire \addr_d_reg[0] ;
  wire [4:0]addr_i_p1;
  wire bus2ip_reset_int_core;
  wire character_received;
  wire chipSelect;
  wire chipSelect_reg;
  wire fifo_full_p1;
  wire [2:0]in;
  wire lsr2_rst;
  wire lsr2_rst_reg;
  wire lsr2_set;
  wire lsr3_set;
  wire lsr4_set;
  wire \lsr[0]_i_2_n_0 ;
  wire \lsr[2]_i_5_n_0 ;
  wire lsr_reg0;
  wire [4:0]\lsr_reg[0] ;
  wire \lsr_reg[0]_0 ;
  wire \lsr_reg[0]_1 ;
  wire [2:0]out;
  wire rd_d_reg;
  wire rx_fifo_rd_en_d;
  wire rx_fifo_rd_en_d1;
  wire rx_fifo_rst;
  wire rx_fifo_wr_en_i;
  wire s_axi_aclk;
  wire wr_d;

  LUT6 #(
    .INIT(64'h4555C9D900000000)) 
    FIFO_Full_i_1__0
       (.I0(\lsr_reg[0] [4]),
        .I1(\lsr_reg[0] [3]),
        .I2(rx_fifo_rd_en_d),
        .I3(\INFERRED_GEN.cnt_i[4]_i_2__0_n_0 ),
        .I4(\INFERRED_GEN.cnt_i[4]_i_3__0_n_0 ),
        .I5(FIFO_Full_i_2__0_n_0),
        .O(fifo_full_p1));
  LUT6 #(
    .INIT(64'h8008008000000100)) 
    FIFO_Full_i_2__0
       (.I0(\lsr_reg[0] [2]),
        .I1(\lsr_reg[0] [1]),
        .I2(rx_fifo_wr_en_i),
        .I3(\INFERRED_GEN.cnt_i[3]_i_2_n_0 ),
        .I4(\lsr_reg[0] [0]),
        .I5(\lsr_reg[0] [3]),
        .O(FIFO_Full_i_2__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h659A)) 
    \INFERRED_GEN.cnt_i[0]_i_1__0 
       (.I0(\lsr_reg[0] [0]),
        .I1(\lsr_reg[0] [4]),
        .I2(rx_fifo_rd_en_d),
        .I3(rx_fifo_wr_en_i),
        .O(addr_i_p1[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h77E78818)) 
    \INFERRED_GEN.cnt_i[1]_i_1__0 
       (.I0(rx_fifo_wr_en_i),
        .I1(\lsr_reg[0] [0]),
        .I2(rx_fifo_rd_en_d),
        .I3(\lsr_reg[0] [4]),
        .I4(\lsr_reg[0] [1]),
        .O(addr_i_p1[1]));
  LUT6 #(
    .INIT(64'h75FFFFEF8A000010)) 
    \INFERRED_GEN.cnt_i[2]_i_1__0 
       (.I0(\lsr_reg[0] [0]),
        .I1(\lsr_reg[0] [4]),
        .I2(rx_fifo_rd_en_d),
        .I3(rx_fifo_wr_en_i),
        .I4(\lsr_reg[0] [1]),
        .I5(\lsr_reg[0] [2]),
        .O(addr_i_p1[2]));
  LUT6 #(
    .INIT(64'h9AAAAAAAAAAAAAA6)) 
    \INFERRED_GEN.cnt_i[3]_i_1__0 
       (.I0(\lsr_reg[0] [3]),
        .I1(\INFERRED_GEN.cnt_i[3]_i_2_n_0 ),
        .I2(\lsr_reg[0] [2]),
        .I3(\lsr_reg[0] [1]),
        .I4(rx_fifo_wr_en_i),
        .I5(\lsr_reg[0] [0]),
        .O(addr_i_p1[3]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \INFERRED_GEN.cnt_i[3]_i_2 
       (.I0(rx_fifo_rd_en_d),
        .I1(\lsr_reg[0] [4]),
        .O(\INFERRED_GEN.cnt_i[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'hBAAA3626)) 
    \INFERRED_GEN.cnt_i[4]_i_1__0 
       (.I0(\lsr_reg[0] [4]),
        .I1(\lsr_reg[0] [3]),
        .I2(rx_fifo_rd_en_d),
        .I3(\INFERRED_GEN.cnt_i[4]_i_2__0_n_0 ),
        .I4(\INFERRED_GEN.cnt_i[4]_i_3__0_n_0 ),
        .O(addr_i_p1[4]));
  LUT6 #(
    .INIT(64'h5151515151515155)) 
    \INFERRED_GEN.cnt_i[4]_i_2__0 
       (.I0(\lsr_reg[0] [2]),
        .I1(rx_fifo_rd_en_d),
        .I2(\lsr_reg[0] [4]),
        .I3(\lsr_reg[0] [0]),
        .I4(\lsr_reg[0] [1]),
        .I5(rx_fifo_wr_en_i),
        .O(\INFERRED_GEN.cnt_i[4]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h7F7F007FFFFF01FF)) 
    \INFERRED_GEN.cnt_i[4]_i_3__0 
       (.I0(\lsr_reg[0] [2]),
        .I1(\lsr_reg[0] [1]),
        .I2(rx_fifo_wr_en_i),
        .I3(rx_fifo_rd_en_d),
        .I4(\lsr_reg[0] [4]),
        .I5(\lsr_reg[0] [0]),
        .O(\INFERRED_GEN.cnt_i[4]_i_3__0_n_0 ));
  FDSE \INFERRED_GEN.cnt_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[0]),
        .Q(\lsr_reg[0] [0]),
        .S(rx_fifo_rst));
  FDSE \INFERRED_GEN.cnt_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[1]),
        .Q(\lsr_reg[0] [1]),
        .S(rx_fifo_rst));
  FDSE \INFERRED_GEN.cnt_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[2]),
        .Q(\lsr_reg[0] [2]),
        .S(rx_fifo_rst));
  FDSE \INFERRED_GEN.cnt_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[3]),
        .Q(\lsr_reg[0] [3]),
        .S(rx_fifo_rst));
  FDSE \INFERRED_GEN.cnt_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(addr_i_p1[4]),
        .Q(\lsr_reg[0] [4]),
        .S(rx_fifo_rst));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT2 #(
    .INIT(4'h1)) 
    Rx_fifo_trigger_i_1
       (.I0(\lsr_reg[0] [4]),
        .I1(Rx_fifo_trigger_i_2_n_0),
        .O(Rx_fifo_trigger_reg));
  LUT6 #(
    .INIT(64'h222AABBB00002AAA)) 
    Rx_fifo_trigger_i_2
       (.I0(\GENERATING_FIFOS.fcr_reg[7] [1]),
        .I1(\lsr_reg[0] [2]),
        .I2(\lsr_reg[0] [1]),
        .I3(\lsr_reg[0] [0]),
        .I4(\lsr_reg[0] [3]),
        .I5(\GENERATING_FIFOS.fcr_reg[7] [0]),
        .O(Rx_fifo_trigger_i_2_n_0));
  LUT6 #(
    .INIT(64'h44444FFF44444444)) 
    lsr2_rst_i_1
       (.I0(\lsr_reg[0] [4]),
        .I1(rd_d_reg),
        .I2(chipSelect),
        .I3(wr_d),
        .I4(rx_fifo_rd_en_d),
        .I5(lsr2_rst),
        .O(lsr2_rst_reg));
  LUT6 #(
    .INIT(64'h00000E000F000E00)) 
    \lsr[0]_i_1 
       (.I0(chipSelect_reg),
        .I1(\addr_d_reg[0] ),
        .I2(bus2ip_reset_int_core),
        .I3(\lsr[0]_i_2_n_0 ),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(\lsr_reg[0] [4]),
        .O(\lsr_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hBFFFBBFB8FFF88F8)) 
    \lsr[0]_i_2 
       (.I0(Q),
        .I1(lsr_reg0),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\lsr_reg[0] [4]),
        .I4(character_received),
        .I5(\lsr_reg[0]_1 ),
        .O(\lsr[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h08AA0808)) 
    \lsr[2]_i_4 
       (.I0(\Lcr_reg[3] ),
        .I1(in[2]),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\lsr[2]_i_5_n_0 ),
        .I4(out[2]),
        .O(lsr2_set));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    \lsr[2]_i_5 
       (.I0(rx_fifo_rd_en_d),
        .I1(\lsr_reg[0] [4]),
        .I2(rx_fifo_rd_en_d1),
        .I3(\GENERATING_FIFOS.fcr_reg[0] ),
        .O(\lsr[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0003AAAA0000AAAA)) 
    \lsr[3]_i_2 
       (.I0(in[1]),
        .I1(rx_fifo_rd_en_d),
        .I2(\lsr_reg[0] [4]),
        .I3(rx_fifo_rd_en_d1),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(out[1]),
        .O(lsr3_set));
  LUT6 #(
    .INIT(64'h0003AAAA0000AAAA)) 
    \lsr[4]_i_2 
       (.I0(in[0]),
        .I1(rx_fifo_rd_en_d),
        .I2(\lsr_reg[0] [4]),
        .I3(rx_fifo_rd_en_d1),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(out[0]),
        .O(lsr4_set));
endmodule

(* ORIG_REF_NAME = "dynshreg_f" *) 
module sensors96b_axi_uart16550_0_0_dynshreg_f
   (tx_fifo_wr_en_i,
    out,
    tx_fifo_wr_en_d,
    tx_fifo_full,
    \Thr_reg[7] ,
    Q,
    s_axi_aclk);
  output tx_fifo_wr_en_i;
  output [7:0]out;
  input tx_fifo_wr_en_d;
  input tx_fifo_full;
  input [7:0]\Thr_reg[7] ;
  input [3:0]Q;
  input s_axi_aclk;

  wire [3:0]Q;
  wire [7:0]\Thr_reg[7] ;
  wire [7:0]out;
  wire s_axi_aclk;
  wire tx_fifo_full;
  wire tx_fifo_wr_en_d;
  wire tx_fifo_wr_en_i;

  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][0]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][0]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [7]),
        .Q(out[7]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][1]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][1]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [6]),
        .Q(out[6]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][2]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][2]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [5]),
        .Q(out[5]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][3]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][3]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [4]),
        .Q(out[4]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][4]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][4]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [3]),
        .Q(out[3]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][5]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][5]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [2]),
        .Q(out[2]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][6]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][6]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [1]),
        .Q(out[1]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.tx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][7]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][7]_srl16 
       (.A0(Q[0]),
        .A1(Q[1]),
        .A2(Q[2]),
        .A3(Q[3]),
        .CE(tx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(\Thr_reg[7] [0]),
        .Q(out[0]));
  LUT2 #(
    .INIT(4'h2)) 
    \INFERRED_GEN.data_reg[15][7]_srl16_i_1 
       (.I0(tx_fifo_wr_en_d),
        .I1(tx_fifo_full),
        .O(tx_fifo_wr_en_i));
endmodule

(* ORIG_REF_NAME = "dynshreg_f" *) 
module sensors96b_axi_uart16550_0_0_dynshreg_f__parameterized0
   (\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ,
    out,
    D,
    rd_d_reg,
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ,
    rx_fifo_rd_en_d,
    dlab_reg,
    \dll_reg[6] ,
    \addr_d_reg[2] ,
    \lsr_reg[6] ,
    \Lcr_reg[6] ,
    \Lcr_reg[3] ,
    iir,
    \addr_d_reg[2]_0 ,
    L,
    \GENERATING_FIFOS.fcr_reg[6] ,
    \msr_reg[2] ,
    \addr_d_reg[2]_1 ,
    \ier_reg[3] ,
    \addr_d_reg[1] ,
    \dll_reg[1] ,
    \addr_d_reg[0] ,
    \GENERATING_FIFOS.fcr_reg[0] ,
    \Rbr_reg[6] ,
    \iir_reg[0] ,
    \ier_reg[0] ,
    dlab_reg_0,
    \addr_d_reg[0]_0 ,
    p_0_in2_in,
    \addr_d_reg[1]_0 ,
    \scr_reg[6] ,
    \iir_reg[7] ,
    rx_fifo_wr_en_i,
    in,
    \INFERRED_GEN.cnt_i_reg[3] ,
    s_axi_aclk);
  output \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ;
  output [5:0]out;
  output [4:0]D;
  input rd_d_reg;
  input \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ;
  input rx_fifo_rd_en_d;
  input dlab_reg;
  input [0:0]\dll_reg[6] ;
  input \addr_d_reg[2] ;
  input \lsr_reg[6] ;
  input \Lcr_reg[6] ;
  input \Lcr_reg[3] ;
  input [2:0]iir;
  input \addr_d_reg[2]_0 ;
  input [0:0]L;
  input [3:0]\GENERATING_FIFOS.fcr_reg[6] ;
  input \msr_reg[2] ;
  input \addr_d_reg[2]_1 ;
  input [2:0]\ier_reg[3] ;
  input \addr_d_reg[1] ;
  input \dll_reg[1] ;
  input \addr_d_reg[0] ;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input [4:0]\Rbr_reg[6] ;
  input \iir_reg[0] ;
  input \ier_reg[0] ;
  input dlab_reg_0;
  input \addr_d_reg[0]_0 ;
  input p_0_in2_in;
  input \addr_d_reg[1]_0 ;
  input [0:0]\scr_reg[6] ;
  input \iir_reg[7] ;
  input rx_fifo_wr_en_i;
  input [0:10]in;
  input [3:0]\INFERRED_GEN.cnt_i_reg[3] ;
  input s_axi_aclk;

  wire [4:0]D;
  wire \Dout[1]_i_3_n_0 ;
  wire \Dout[2]_i_3_n_0 ;
  wire \Dout[3]_i_3_n_0 ;
  wire \Dout[6]_i_4_n_0 ;
  wire \Dout[6]_i_6_n_0 ;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire [3:0]\GENERATING_FIFOS.fcr_reg[6] ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ;
  wire [3:0]\INFERRED_GEN.cnt_i_reg[3] ;
  wire [0:0]L;
  wire \Lcr_reg[3] ;
  wire \Lcr_reg[6] ;
  wire [4:0]\Rbr_reg[6] ;
  wire \addr_d_reg[0] ;
  wire \addr_d_reg[0]_0 ;
  wire \addr_d_reg[1] ;
  wire \addr_d_reg[1]_0 ;
  wire \addr_d_reg[2] ;
  wire \addr_d_reg[2]_0 ;
  wire \addr_d_reg[2]_1 ;
  wire dlab_reg;
  wire dlab_reg_0;
  wire \dll_reg[1] ;
  wire [0:0]\dll_reg[6] ;
  wire \ier_reg[0] ;
  wire [2:0]\ier_reg[3] ;
  wire [2:0]iir;
  wire \iir_reg[0] ;
  wire \iir_reg[7] ;
  wire [0:10]in;
  wire \lsr_reg[6] ;
  wire \msr_reg[2] ;
  wire [5:0]out;
  wire p_0_in2_in;
  wire rd_d_reg;
  wire [6:0]rx_fifo_data_out;
  wire rx_fifo_rd_en_d;
  wire rx_fifo_wr_en_i;
  wire s_axi_aclk;
  wire [0:0]\scr_reg[6] ;

  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF4540)) 
    \Dout[0]_i_1 
       (.I0(\addr_d_reg[0] ),
        .I1(rx_fifo_data_out[0]),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\Rbr_reg[6] [0]),
        .I4(\iir_reg[0] ),
        .I5(\ier_reg[0] ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFFBAFFBABA)) 
    \Dout[1]_i_1 
       (.I0(\dll_reg[1] ),
        .I1(\addr_d_reg[1] ),
        .I2(\GENERATING_FIFOS.fcr_reg[6] [0]),
        .I3(\addr_d_reg[2]_1 ),
        .I4(\ier_reg[3] [0]),
        .I5(\Dout[1]_i_3_n_0 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h4F444F4F4F444444)) 
    \Dout[1]_i_3 
       (.I0(dlab_reg_0),
        .I1(iir[0]),
        .I2(\addr_d_reg[0] ),
        .I3(rx_fifo_data_out[1]),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(\Rbr_reg[6] [1]),
        .O(\Dout[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEFEEFFFFEFEEEFEE)) 
    \Dout[2]_i_1 
       (.I0(\msr_reg[2] ),
        .I1(\Dout[2]_i_3_n_0 ),
        .I2(\addr_d_reg[2]_1 ),
        .I3(\ier_reg[3] [1]),
        .I4(\addr_d_reg[1] ),
        .I5(\GENERATING_FIFOS.fcr_reg[6] [1]),
        .O(D[2]));
  LUT6 #(
    .INIT(64'h4540FFFF45404540)) 
    \Dout[2]_i_3 
       (.I0(\addr_d_reg[0] ),
        .I1(rx_fifo_data_out[2]),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\Rbr_reg[6] [2]),
        .I4(dlab_reg_0),
        .I5(iir[1]),
        .O(\Dout[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hEEFFEEFEEEEEEEFE)) 
    \Dout[3]_i_1 
       (.I0(\Lcr_reg[3] ),
        .I1(\Dout[3]_i_3_n_0 ),
        .I2(iir[2]),
        .I3(\addr_d_reg[2]_0 ),
        .I4(L),
        .I5(\GENERATING_FIFOS.fcr_reg[6] [2]),
        .O(D[3]));
  LUT6 #(
    .INIT(64'h4540FFFF45404540)) 
    \Dout[3]_i_3 
       (.I0(\addr_d_reg[0] ),
        .I1(rx_fifo_data_out[3]),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\Rbr_reg[6] [3]),
        .I4(\addr_d_reg[2]_1 ),
        .I5(\ier_reg[3] [2]),
        .O(\Dout[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF4F44)) 
    \Dout[6]_i_1 
       (.I0(dlab_reg),
        .I1(\dll_reg[6] ),
        .I2(\addr_d_reg[2] ),
        .I3(\lsr_reg[6] ),
        .I4(\Lcr_reg[6] ),
        .I5(\Dout[6]_i_4_n_0 ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8F88)) 
    \Dout[6]_i_4 
       (.I0(\addr_d_reg[0]_0 ),
        .I1(p_0_in2_in),
        .I2(\addr_d_reg[1]_0 ),
        .I3(\scr_reg[6] ),
        .I4(\iir_reg[7] ),
        .I5(\Dout[6]_i_6_n_0 ),
        .O(\Dout[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h4F444F4F4F444444)) 
    \Dout[6]_i_6 
       (.I0(\addr_d_reg[1] ),
        .I1(\GENERATING_FIFOS.fcr_reg[6] [3]),
        .I2(\addr_d_reg[0] ),
        .I3(rx_fifo_data_out[6]),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(\Rbr_reg[6] [4]),
        .O(\Dout[6]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hF2F2F2F2F2F2F200)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_1 
       (.I0(rd_d_reg),
        .I1(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ),
        .I2(rx_fifo_rd_en_d),
        .I3(out[4]),
        .I4(out[3]),
        .I5(out[5]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][0]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][0]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[0]),
        .Q(out[5]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][10]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][10]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[10]),
        .Q(rx_fifo_data_out[0]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][1]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][1]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[1]),
        .Q(out[4]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][2]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][2]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[2]),
        .Q(out[3]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][3]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][3]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[3]),
        .Q(out[2]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][4]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][4]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[4]),
        .Q(rx_fifo_data_out[6]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][5]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][5]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[5]),
        .Q(out[1]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][6]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][6]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[6]),
        .Q(out[0]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][7]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][7]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[7]),
        .Q(rx_fifo_data_out[3]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][8]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][8]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[8]),
        .Q(rx_fifo_data_out[2]));
  (* srl_bus_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15] " *) 
  (* srl_name = "U0/\XUART_I_1/UART16550_I_1/GENERATING_FIFOS.rx_fifo_block_1/srl_fifo_rbu_f_i1/DYNSHREG_F_I/INFERRED_GEN.data_reg[15][9]_srl16 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \INFERRED_GEN.data_reg[15][9]_srl16 
       (.A0(\INFERRED_GEN.cnt_i_reg[3] [0]),
        .A1(\INFERRED_GEN.cnt_i_reg[3] [1]),
        .A2(\INFERRED_GEN.cnt_i_reg[3] [2]),
        .A3(\INFERRED_GEN.cnt_i_reg[3] [3]),
        .CE(rx_fifo_wr_en_i),
        .CLK(s_axi_aclk),
        .D(in[9]),
        .Q(rx_fifo_data_out[1]));
endmodule

(* ORIG_REF_NAME = "ipic_if" *) 
module sensors96b_axi_uart16550_0_0_ipic_if
   (wrReq_d1,
    s_axi_wready,
    s_axi_arready,
    Rd,
    bus2ip_reset_int_core,
    bus2ip_wrce_i,
    s_axi_aclk,
    bus2ip_rdce_i);
  output wrReq_d1;
  output s_axi_wready;
  output s_axi_arready;
  output Rd;
  input bus2ip_reset_int_core;
  input bus2ip_wrce_i;
  input s_axi_aclk;
  input bus2ip_rdce_i;

  wire Rd;
  wire bus2ip_rdce_i;
  wire bus2ip_rdreq_d1;
  wire bus2ip_rdreq_d2;
  wire bus2ip_rdreq_d3;
  wire bus2ip_rdreq_d4;
  wire bus2ip_reset_int_core;
  wire bus2ip_wrce_i;
  wire ip2bus_rdack;
  wire ip2bus_rdack_d1;
  wire ip2bus_wrack;
  wire ip2bus_wrack_d1;
  wire s_axi_aclk;
  wire s_axi_arready;
  wire s_axi_wready;
  wire wrReq_d1;
  wire wrReq_d2;
  wire wrReq_d3;

  FDRE IP2Bus_RdAcknowledge_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_rdack_d1),
        .Q(s_axi_arready),
        .R(bus2ip_reset_int_core));
  FDRE IP2Bus_WrAcknowledge_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_wrack_d1),
        .Q(s_axi_wready),
        .R(bus2ip_reset_int_core));
  FDRE bus2ip_rdreq_d1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bus2ip_rdce_i),
        .Q(bus2ip_rdreq_d1),
        .R(bus2ip_reset_int_core));
  FDRE bus2ip_rdreq_d2_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bus2ip_rdreq_d1),
        .Q(bus2ip_rdreq_d2),
        .R(bus2ip_reset_int_core));
  FDRE bus2ip_rdreq_d3_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bus2ip_rdreq_d2),
        .Q(bus2ip_rdreq_d3),
        .R(bus2ip_reset_int_core));
  FDRE bus2ip_rdreq_d4_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bus2ip_rdreq_d3),
        .Q(bus2ip_rdreq_d4),
        .R(bus2ip_reset_int_core));
  LUT2 #(
    .INIT(4'h2)) 
    ip2bus_rdack_d1_i_1
       (.I0(bus2ip_rdreq_d3),
        .I1(bus2ip_rdreq_d4),
        .O(ip2bus_rdack));
  FDRE ip2bus_rdack_d1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_rdack),
        .Q(ip2bus_rdack_d1),
        .R(bus2ip_reset_int_core));
  LUT2 #(
    .INIT(4'h2)) 
    ip2bus_wrack_d1_i_1
       (.I0(wrReq_d2),
        .I1(wrReq_d3),
        .O(ip2bus_wrack));
  FDRE ip2bus_wrack_d1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_wrack),
        .Q(ip2bus_wrack_d1),
        .R(bus2ip_reset_int_core));
  LUT2 #(
    .INIT(4'h2)) 
    rd_d_i_1
       (.I0(bus2ip_rdreq_d1),
        .I1(bus2ip_rdreq_d2),
        .O(Rd));
  FDRE wrReq_d1_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(bus2ip_wrce_i),
        .Q(wrReq_d1),
        .R(bus2ip_reset_int_core));
  FDRE wrReq_d2_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(wrReq_d1),
        .Q(wrReq_d2),
        .R(bus2ip_reset_int_core));
  FDRE wrReq_d3_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(wrReq_d2),
        .Q(wrReq_d3),
        .R(bus2ip_reset_int_core));
endmodule

(* ORIG_REF_NAME = "rx16550" *) 
module sensors96b_axi_uart16550_0_0_rx16550
   (in,
    character_received,
    p_0_in,
    clk1x_reg_0,
    clk1x_reg_1,
    clk1x_reg_2,
    clk1x_reg_3,
    SR,
    rx_fifo_wr_en_i,
    Rx_error_in_fifo0,
    D,
    \Dout_reg[6] ,
    s_axi_aclk,
    rx_sin,
    bus2ip_reset_int_core,
    Q,
    mcr4_d,
    \Lcr_reg[7] ,
    \Lcr_reg[1] ,
    baudoutN_int_i,
    clockDiv,
    \GENERATING_FIFOS.fcr_reg[0] ,
    \INFERRED_GEN.cnt_i_reg[4] ,
    rx_fifo_rd_en_d,
    rx_fifo_rst,
    rx_fifo_full,
    \addr_d_reg[0] ,
    p_0_in5_in,
    \addr_d_reg[0]_0 ,
    \lsr_reg[7] ,
    \Lcr_reg[5] ,
    \scr_reg[5] ,
    out,
    \addr_d_reg[0]_1 ,
    \dlm_reg[4] ,
    \mcr_reg[4] ,
    \GENERATING_FIFOS.fcr_reg[7] ,
    \iir_reg[7] );
  output [0:10]in;
  output character_received;
  output p_0_in;
  output clk1x_reg_0;
  output clk1x_reg_1;
  output clk1x_reg_2;
  output clk1x_reg_3;
  output [0:0]SR;
  output rx_fifo_wr_en_i;
  output Rx_error_in_fifo0;
  output [2:0]D;
  output [4:0]\Dout_reg[6] ;
  input s_axi_aclk;
  input rx_sin;
  input bus2ip_reset_int_core;
  input [0:0]Q;
  input mcr4_d;
  input [6:0]\Lcr_reg[7] ;
  input \Lcr_reg[1] ;
  input baudoutN_int_i;
  input [15:0]clockDiv;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input [0:0]\INFERRED_GEN.cnt_i_reg[4] ;
  input rx_fifo_rd_en_d;
  input rx_fifo_rst;
  input rx_fifo_full;
  input \addr_d_reg[0] ;
  input p_0_in5_in;
  input \addr_d_reg[0]_0 ;
  input \lsr_reg[7] ;
  input \Lcr_reg[5] ;
  input \scr_reg[5] ;
  input [2:0]out;
  input \addr_d_reg[0]_1 ;
  input \dlm_reg[4] ;
  input \mcr_reg[4] ;
  input \GENERATING_FIFOS.fcr_reg[7] ;
  input \iir_reg[7] ;

  wire [2:0]D;
  wire \Dout[7]_i_6_n_0 ;
  wire [4:0]\Dout_reg[6] ;
  wire \FSM_sequential_receive_state[0]_i_2_n_0 ;
  wire \FSM_sequential_receive_state[0]_i_3_n_0 ;
  wire \FSM_sequential_receive_state[0]_i_4_n_0 ;
  wire \FSM_sequential_receive_state[0]_i_5_n_0 ;
  wire \FSM_sequential_receive_state[0]_i_6_n_0 ;
  wire \FSM_sequential_receive_state[1]_i_2_n_0 ;
  wire \FSM_sequential_receive_state[1]_i_3_n_0 ;
  wire \FSM_sequential_receive_state[1]_i_4_n_0 ;
  wire \FSM_sequential_receive_state[3]_i_3_n_0 ;
  wire \FSM_sequential_receive_state[3]_i_4_n_0 ;
  wire \FSM_sequential_receive_state[3]_i_5_n_0 ;
  wire \FSM_sequential_receive_state[3]_i_6_n_0 ;
  wire \FSM_sequential_receive_state[3]_i_7_n_0 ;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire \GENERATING_FIFOS.fcr_reg[7] ;
  wire [0:0]\INFERRED_GEN.cnt_i_reg[4] ;
  wire \Lcr_reg[1] ;
  wire \Lcr_reg[5] ;
  wire [6:0]\Lcr_reg[7] ;
  wire [0:0]Q;
  wire [7:4]Rbr;
  wire Rx_error_in_fifo0;
  wire [0:0]SR;
  wire \addr_d_reg[0] ;
  wire \addr_d_reg[0]_0 ;
  wire \addr_d_reg[0]_1 ;
  wire baudoutN_int_i;
  wire break_interrupt_error_d;
  wire break_interrupt_error_d_i_1_n_0;
  wire break_interrupt_error_d_i_3_n_0;
  wire break_interrupt_error_d_i_4_n_0;
  wire break_interrupt_error_d_i_5_n_0;
  wire break_interrupt_error_d_i_6_n_0;
  wire break_interrupt_error_d_i_7_n_0;
  wire break_interrupt_error_d_i_8_n_0;
  wire break_interrupt_error_d_i_9_n_0;
  wire break_interrupt_error_d_reg_n_0;
  wire break_interrupt_flag;
  wire break_interrupt_flag_i_1_n_0;
  wire break_interrupt_i0;
  wire bus2ip_reset_int_core;
  wire character_received;
  wire character_received_com;
  wire character_received_d;
  wire character_received_flag;
  wire character_received_flag0;
  wire character_received_rclk;
  wire clk1x;
  wire clk1x0;
  wire clk1x_d;
  wire clk1x_i_3_n_0;
  wire clk1x_i_4_n_0;
  wire clk1x_reg_0;
  wire clk1x_reg_1;
  wire clk1x_reg_2;
  wire clk1x_reg_3;
  wire clk2x;
  wire clk2x0;
  wire clk_div_en_i_1_n_0;
  wire clk_div_en_i_2_n_0;
  wire clk_div_en_i_3_n_0;
  wire clk_div_en_reg_n_0;
  wire \clkdiv[0]_i_1_n_0 ;
  wire \clkdiv[1]_i_1__0_n_0 ;
  wire \clkdiv[2]_i_1__0_n_0 ;
  wire \clkdiv[2]_i_2_n_0 ;
  wire \clkdiv[3]_i_1__0_n_0 ;
  wire \clkdiv[3]_i_2__0_n_0 ;
  wire \clkdiv[3]_i_3_n_0 ;
  wire \clkdiv[3]_i_4_n_0 ;
  wire \clkdiv[3]_i_5_n_0 ;
  wire \clkdiv[3]_i_6_n_0 ;
  wire \clkdiv_reg_n_0_[0] ;
  wire \clkdiv_reg_n_0_[1] ;
  wire \clkdiv_reg_n_0_[2] ;
  wire \clkdiv_reg_n_0_[3] ;
  wire [15:0]clockDiv;
  wire clock_1x_early;
  wire clock_1x_early0;
  wire \dlm_reg[4] ;
  wire framing_error_com;
  wire framing_error_d;
  wire framing_error_d_i_2_n_0;
  wire framing_error_flag;
  wire framing_error_flag0;
  wire framing_error_flag_i_1_n_0;
  wire framing_error_i0;
  wire got_start_bit_com;
  wire got_start_bit_d;
  wire have_bi_in_fifo_n;
  wire have_bi_in_fifo_n_i_i_1_n_0;
  wire have_bi_in_fifo_n_i_i_2_n_0;
  wire \iir_reg[7] ;
  wire [0:10]in;
  wire load_rbr_com;
  wire load_rbr_d;
  wire load_rbr_d_i_1_n_0;
  wire \lsr_reg[7] ;
  wire mcr4_d;
  wire \mcr_reg[4] ;
  wire [3:0]next_state;
  wire [2:0]out;
  wire p_0_in;
  wire p_0_in5_in;
  wire parity_error_d;
  wire parity_error_d0;
  wire parity_error_d_i_10_n_0;
  wire parity_error_d_i_2_n_0;
  wire parity_error_d_i_3_n_0;
  wire parity_error_d_i_4_n_0;
  wire parity_error_d_i_5_n_0;
  wire parity_error_d_i_6_n_0;
  wire parity_error_d_i_7_n_0;
  wire parity_error_d_i_8_n_0;
  wire parity_error_d_i_9_n_0;
  wire parity_error_i0;
  wire parity_error_latch;
  wire parity_error_latch_i_1_n_0;
  wire rbr_d0;
  wire \rbr_d[0]_i_1_n_0 ;
  wire \rbr_d[1]_i_1_n_0 ;
  wire \rbr_d[2]_i_1_n_0 ;
  wire \rbr_d[3]_i_1_n_0 ;
  wire \rbr_d[4]_i_1_n_0 ;
  wire \rbr_d[5]_i_1_n_0 ;
  wire \rbr_d[6]_i_1_n_0 ;
  wire \rbr_d[7]_i_2_n_0 ;
  wire rclk_int;
  (* RTL_KEEP = "yes" *) wire [3:0]receive_state;
  wire resynch_clkdiv;
  wire resynch_clkdiv_d;
  wire resynch_clkdiv_d_i_2_n_0;
  wire resynch_clkdiv_d_i_3_n_0;
  wire resynch_clkdiv_frame_d;
  wire resynch_clkdiv_frame_d_i_1_n_0;
  wire resynch_clkdiv_frame_d_i_2_n_0;
  wire resynch_clkdiv_frame_d_i_3_n_0;
  wire resynch_clkdiv_startbit;
  wire resynch_clkdiv_startbit_d;
  wire resynch_clkdiv_startbit_d_i_2_n_0;
  wire resynch_clkdiv_startbit_d_i_3_n_0;
  wire [7:0]rsr;
  wire rx_fifo_full;
  wire rx_fifo_rd_en_d;
  wire rx_fifo_rst;
  wire rx_fifo_wr_en_i;
  wire rx_parity_com;
  wire rx_rst;
  wire rx_sin;
  wire s_axi_aclk;
  wire \scr_reg[5] ;
  wire sin_d1;
  wire sin_d10;
  wire sin_d2;
  wire sin_d3;
  wire sin_d4;
  wire sin_d5;
  wire sin_d6;
  wire sin_d7;
  wire sin_d8;
  wire sin_d9;

  FDRE Data_ready_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(character_received_flag),
        .Q(character_received),
        .R(rx_rst));
  LUT6 #(
    .INIT(64'hEEEEEEEEFFFEEEFE)) 
    \Dout[4]_i_1 
       (.I0(\dlm_reg[4] ),
        .I1(\mcr_reg[4] ),
        .I2(Rbr[4]),
        .I3(\GENERATING_FIFOS.fcr_reg[0] ),
        .I4(out[0]),
        .I5(\addr_d_reg[0]_1 ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'hEEEEEEEEFFFEEEFE)) 
    \Dout[5]_i_1 
       (.I0(\Lcr_reg[5] ),
        .I1(\scr_reg[5] ),
        .I2(Rbr[5]),
        .I3(\GENERATING_FIFOS.fcr_reg[0] ),
        .I4(out[1]),
        .I5(\addr_d_reg[0]_1 ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8F88)) 
    \Dout[7]_i_2 
       (.I0(\addr_d_reg[0] ),
        .I1(p_0_in5_in),
        .I2(\addr_d_reg[0]_0 ),
        .I3(\Lcr_reg[7] [6]),
        .I4(\lsr_reg[7] ),
        .I5(\Dout[7]_i_6_n_0 ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAAFEAE)) 
    \Dout[7]_i_6 
       (.I0(\GENERATING_FIFOS.fcr_reg[7] ),
        .I1(Rbr[7]),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(out[2]),
        .I4(\addr_d_reg[0]_1 ),
        .I5(\iir_reg[7] ),
        .O(\Dout[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF05003500)) 
    \FSM_sequential_receive_state[0]_i_1 
       (.I0(\FSM_sequential_receive_state[0]_i_2_n_0 ),
        .I1(\FSM_sequential_receive_state[0]_i_3_n_0 ),
        .I2(receive_state[2]),
        .I3(receive_state[3]),
        .I4(\FSM_sequential_receive_state[0]_i_4_n_0 ),
        .I5(\FSM_sequential_receive_state[0]_i_5_n_0 ),
        .O(next_state[0]));
  LUT6 #(
    .INIT(64'hF03C103CF13CF03C)) 
    \FSM_sequential_receive_state[0]_i_2 
       (.I0(\Lcr_reg[7] [3]),
        .I1(\FSM_sequential_receive_state[0]_i_6_n_0 ),
        .I2(receive_state[0]),
        .I3(receive_state[1]),
        .I4(\Lcr_reg[7] [0]),
        .I5(\Lcr_reg[7] [1]),
        .O(\FSM_sequential_receive_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h54)) 
    \FSM_sequential_receive_state[0]_i_3 
       (.I0(\Lcr_reg[7] [3]),
        .I1(sin_d2),
        .I2(\Lcr_reg[7] [2]),
        .O(\FSM_sequential_receive_state[0]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hE0)) 
    \FSM_sequential_receive_state[0]_i_4 
       (.I0(\Lcr_reg[7] [0]),
        .I1(\Lcr_reg[7] [1]),
        .I2(receive_state[0]),
        .O(\FSM_sequential_receive_state[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h40404505)) 
    \FSM_sequential_receive_state[0]_i_5 
       (.I0(receive_state[3]),
        .I1(sin_d2),
        .I2(receive_state[0]),
        .I3(receive_state[1]),
        .I4(receive_state[2]),
        .O(\FSM_sequential_receive_state[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_receive_state[0]_i_6 
       (.I0(\Lcr_reg[7] [2]),
        .I1(sin_d2),
        .O(\FSM_sequential_receive_state[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hD0D0D0DFC0CFC0C0)) 
    \FSM_sequential_receive_state[1]_i_1 
       (.I0(\FSM_sequential_receive_state[1]_i_2_n_0 ),
        .I1(\FSM_sequential_receive_state[1]_i_3_n_0 ),
        .I2(receive_state[3]),
        .I3(receive_state[1]),
        .I4(receive_state[0]),
        .I5(receive_state[2]),
        .O(next_state[1]));
  LUT6 #(
    .INIT(64'h5757575757575700)) 
    \FSM_sequential_receive_state[1]_i_2 
       (.I0(receive_state[0]),
        .I1(\Lcr_reg[7] [1]),
        .I2(\Lcr_reg[7] [0]),
        .I3(\Lcr_reg[7] [3]),
        .I4(\Lcr_reg[7] [2]),
        .I5(sin_d2),
        .O(\FSM_sequential_receive_state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000052)) 
    \FSM_sequential_receive_state[1]_i_3 
       (.I0(receive_state[0]),
        .I1(sin_d2),
        .I2(\Lcr_reg[7] [2]),
        .I3(receive_state[1]),
        .I4(receive_state[2]),
        .I5(\FSM_sequential_receive_state[1]_i_4_n_0 ),
        .O(\FSM_sequential_receive_state[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h000C080C0008000C)) 
    \FSM_sequential_receive_state[1]_i_4 
       (.I0(\FSM_sequential_receive_state[3]_i_6_n_0 ),
        .I1(receive_state[1]),
        .I2(receive_state[2]),
        .I3(receive_state[0]),
        .I4(\Lcr_reg[7] [0]),
        .I5(\Lcr_reg[7] [1]),
        .O(\FSM_sequential_receive_state[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000FF55A255AAAA)) 
    \FSM_sequential_receive_state[2]_i_1 
       (.I0(receive_state[1]),
        .I1(\Lcr_reg[7] [1]),
        .I2(\Lcr_reg[7] [0]),
        .I3(receive_state[0]),
        .I4(receive_state[3]),
        .I5(receive_state[2]),
        .O(next_state[2]));
  LUT4 #(
    .INIT(16'hBEFF)) 
    \FSM_sequential_receive_state[3]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(Q),
        .I2(mcr4_d),
        .I3(have_bi_in_fifo_n),
        .O(parity_error_d0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00545454)) 
    \FSM_sequential_receive_state[3]_i_2 
       (.I0(\FSM_sequential_receive_state[3]_i_3_n_0 ),
        .I1(\FSM_sequential_receive_state[3]_i_4_n_0 ),
        .I2(receive_state[1]),
        .I3(\FSM_sequential_receive_state[3]_i_5_n_0 ),
        .I4(\FSM_sequential_receive_state[3]_i_6_n_0 ),
        .I5(\FSM_sequential_receive_state[3]_i_7_n_0 ),
        .O(next_state[3]));
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_receive_state[3]_i_3 
       (.I0(receive_state[2]),
        .I1(receive_state[3]),
        .O(\FSM_sequential_receive_state[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \FSM_sequential_receive_state[3]_i_4 
       (.I0(receive_state[0]),
        .I1(sin_d2),
        .I2(\Lcr_reg[7] [2]),
        .O(\FSM_sequential_receive_state[3]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h2008)) 
    \FSM_sequential_receive_state[3]_i_5 
       (.I0(receive_state[1]),
        .I1(\Lcr_reg[7] [0]),
        .I2(\Lcr_reg[7] [1]),
        .I3(receive_state[0]),
        .O(\FSM_sequential_receive_state[3]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \FSM_sequential_receive_state[3]_i_6 
       (.I0(sin_d2),
        .I1(\Lcr_reg[7] [2]),
        .I2(\Lcr_reg[7] [3]),
        .O(\FSM_sequential_receive_state[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hDD005500000000F0)) 
    \FSM_sequential_receive_state[3]_i_7 
       (.I0(\FSM_sequential_receive_state[3]_i_6_n_0 ),
        .I1(\Lcr_reg[1] ),
        .I2(receive_state[1]),
        .I3(receive_state[2]),
        .I4(receive_state[0]),
        .I5(receive_state[3]),
        .O(\FSM_sequential_receive_state[3]_i_7_n_0 ));
  (* FSM_ENCODED_STATES = "data_bit3:0001,data_bit2:0000,data_bit1:0110,frame_error:0011,stop_bit1:1000,stop_bit2:0111,parity_bit:1001,start_bit:0100,idle:0101,data_bit6:1010,data_bit8:1100,data_bit5:1101,data_bit7:1011,data_bit4:0010" *) 
  (* KEEP = "yes" *) 
  FDSE \FSM_sequential_receive_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(next_state[0]),
        .Q(receive_state[0]),
        .S(parity_error_d0));
  (* FSM_ENCODED_STATES = "data_bit3:0001,data_bit2:0000,data_bit1:0110,frame_error:0011,stop_bit1:1000,stop_bit2:0111,parity_bit:1001,start_bit:0100,idle:0101,data_bit6:1010,data_bit8:1100,data_bit5:1101,data_bit7:1011,data_bit4:0010" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_receive_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(next_state[1]),
        .Q(receive_state[1]),
        .R(parity_error_d0));
  (* FSM_ENCODED_STATES = "data_bit3:0001,data_bit2:0000,data_bit1:0110,frame_error:0011,stop_bit1:1000,stop_bit2:0111,parity_bit:1001,start_bit:0100,idle:0101,data_bit6:1010,data_bit8:1100,data_bit5:1101,data_bit7:1011,data_bit4:0010" *) 
  (* KEEP = "yes" *) 
  FDSE \FSM_sequential_receive_state_reg[2] 
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(next_state[2]),
        .Q(receive_state[2]),
        .S(parity_error_d0));
  (* FSM_ENCODED_STATES = "data_bit3:0001,data_bit2:0000,data_bit1:0110,frame_error:0011,stop_bit1:1000,stop_bit2:0111,parity_bit:1001,start_bit:0100,idle:0101,data_bit6:1010,data_bit8:1100,data_bit5:1101,data_bit7:1011,data_bit4:0010" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_receive_state_reg[3] 
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(next_state[3]),
        .Q(receive_state[3]),
        .R(parity_error_d0));
  LUT4 #(
    .INIT(16'h2000)) 
    \INFERRED_GEN.data_reg[15][10]_srl16_i_1 
       (.I0(\GENERATING_FIFOS.fcr_reg[0] ),
        .I1(rx_fifo_full),
        .I2(character_received),
        .I3(have_bi_in_fifo_n),
        .O(rx_fifo_wr_en_i));
  LUT5 #(
    .INIT(32'hAAAAA8AA)) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_i_1 
       (.I0(baudoutN_int_i),
        .I1(clk1x_reg_0),
        .I2(clk1x_reg_1),
        .I3(clk1x_reg_2),
        .I4(clk1x_reg_3),
        .O(p_0_in));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_i_3 
       (.I0(clockDiv[9]),
        .I1(clockDiv[2]),
        .I2(clockDiv[10]),
        .I3(clockDiv[11]),
        .O(clk1x_reg_0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_i_4 
       (.I0(clockDiv[0]),
        .I1(clockDiv[6]),
        .I2(clockDiv[14]),
        .I3(clockDiv[1]),
        .O(clk1x_reg_1));
  LUT4 #(
    .INIT(16'h0001)) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_i_5 
       (.I0(clockDiv[8]),
        .I1(clockDiv[15]),
        .I2(clockDiv[12]),
        .I3(clockDiv[5]),
        .O(clk1x_reg_2));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_i_6 
       (.I0(clockDiv[4]),
        .I1(clockDiv[7]),
        .I2(clockDiv[13]),
        .I3(clockDiv[3]),
        .O(clk1x_reg_3));
  FDRE \Rbr_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[10]),
        .Q(\Dout_reg[6] [0]),
        .R(rx_rst));
  FDRE \Rbr_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[9]),
        .Q(\Dout_reg[6] [1]),
        .R(rx_rst));
  FDRE \Rbr_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[8]),
        .Q(\Dout_reg[6] [2]),
        .R(rx_rst));
  FDRE \Rbr_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[7]),
        .Q(\Dout_reg[6] [3]),
        .R(rx_rst));
  FDRE \Rbr_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[6]),
        .Q(Rbr[4]),
        .R(rx_rst));
  FDRE \Rbr_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[5]),
        .Q(Rbr[5]),
        .R(rx_rst));
  FDRE \Rbr_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[4]),
        .Q(\Dout_reg[6] [4]),
        .R(rx_rst));
  FDRE \Rbr_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(in[3]),
        .Q(Rbr[7]),
        .R(rx_rst));
  LUT4 #(
    .INIT(16'hAAA8)) 
    Rx_error_in_fifo_i_1
       (.I0(rx_fifo_wr_en_i),
        .I1(in[2]),
        .I2(in[0]),
        .I3(in[1]),
        .O(Rx_error_in_fifo0));
  LUT6 #(
    .INIT(64'h00000000EEEE22E2)) 
    break_interrupt_error_d_i_1
       (.I0(break_interrupt_error_d_reg_n_0),
        .I1(break_interrupt_error_d),
        .I2(break_interrupt_error_d_i_3_n_0),
        .I3(break_interrupt_error_d_i_4_n_0),
        .I4(break_interrupt_error_d_i_5_n_0),
        .I5(parity_error_d0),
        .O(break_interrupt_error_d_i_1_n_0));
  LUT6 #(
    .INIT(64'h00D0D0D0F0F0F0F0)) 
    break_interrupt_error_d_i_2
       (.I0(break_interrupt_error_d_i_6_n_0),
        .I1(sin_d2),
        .I2(clk1x),
        .I3(receive_state[1]),
        .I4(receive_state[2]),
        .I5(receive_state[3]),
        .O(break_interrupt_error_d));
  LUT6 #(
    .INIT(64'h00FCFCA8FCFCFCFC)) 
    break_interrupt_error_d_i_3
       (.I0(\Lcr_reg[7] [2]),
        .I1(sin_d2),
        .I2(break_interrupt_error_d_reg_n_0),
        .I3(receive_state[1]),
        .I4(receive_state[2]),
        .I5(receive_state[3]),
        .O(break_interrupt_error_d_i_3_n_0));
  LUT6 #(
    .INIT(64'hFCCCCC88CCCCCC88)) 
    break_interrupt_error_d_i_4
       (.I0(receive_state[2]),
        .I1(receive_state[0]),
        .I2(break_interrupt_error_d_i_7_n_0),
        .I3(receive_state[3]),
        .I4(receive_state[1]),
        .I5(\FSM_sequential_receive_state[3]_i_6_n_0 ),
        .O(break_interrupt_error_d_i_4_n_0));
  LUT5 #(
    .INIT(32'h80808000)) 
    break_interrupt_error_d_i_5
       (.I0(break_interrupt_error_d_i_8_n_0),
        .I1(receive_state[0]),
        .I2(receive_state[3]),
        .I3(sin_d2),
        .I4(break_interrupt_error_d_reg_n_0),
        .O(break_interrupt_error_d_i_5_n_0));
  LUT6 #(
    .INIT(64'h002000200020FFFF)) 
    break_interrupt_error_d_i_6
       (.I0(\Lcr_reg[7] [2]),
        .I1(receive_state[2]),
        .I2(receive_state[0]),
        .I3(receive_state[1]),
        .I4(break_interrupt_error_d_i_9_n_0),
        .I5(\Lcr_reg[7] [3]),
        .O(break_interrupt_error_d_i_6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h2)) 
    break_interrupt_error_d_i_7
       (.I0(\Lcr_reg[7] [0]),
        .I1(\Lcr_reg[7] [1]),
        .O(break_interrupt_error_d_i_7_n_0));
  LUT6 #(
    .INIT(64'h6666664277777777)) 
    break_interrupt_error_d_i_8
       (.I0(receive_state[1]),
        .I1(receive_state[2]),
        .I2(\Lcr_reg[7] [1]),
        .I3(\Lcr_reg[7] [0]),
        .I4(\Lcr_reg[7] [3]),
        .I5(\FSM_sequential_receive_state[0]_i_6_n_0 ),
        .O(break_interrupt_error_d_i_8_n_0));
  LUT6 #(
    .INIT(64'hF5FD0000F7FFDFFF)) 
    break_interrupt_error_d_i_9
       (.I0(\Lcr_reg[7] [2]),
        .I1(\Lcr_reg[7] [1]),
        .I2(\Lcr_reg[7] [0]),
        .I3(receive_state[1]),
        .I4(receive_state[0]),
        .I5(receive_state[2]),
        .O(break_interrupt_error_d_i_9_n_0));
  FDRE break_interrupt_error_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(break_interrupt_error_d_i_1_n_0),
        .Q(break_interrupt_error_d_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    break_interrupt_flag_i_1
       (.I0(p_0_in),
        .I1(break_interrupt_error_d_reg_n_0),
        .I2(break_interrupt_flag),
        .O(break_interrupt_flag_i_1_n_0));
  FDRE break_interrupt_flag_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(break_interrupt_flag_i_1_n_0),
        .Q(break_interrupt_flag),
        .R(framing_error_flag0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h2)) 
    break_interrupt_i_i_1
       (.I0(character_received_flag),
        .I1(break_interrupt_flag),
        .O(break_interrupt_i0));
  FDRE break_interrupt_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(break_interrupt_i0),
        .Q(in[2]),
        .R(rx_rst));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \character_counter[9]_i_1 
       (.I0(rx_fifo_wr_en_i),
        .I1(\INFERRED_GEN.cnt_i_reg[4] ),
        .I2(rx_fifo_rd_en_d),
        .I3(rx_fifo_rst),
        .O(SR));
  LUT5 #(
    .INIT(32'h55000002)) 
    character_received_d_i_1
       (.I0(receive_state[3]),
        .I1(receive_state[2]),
        .I2(\Lcr_reg[7] [2]),
        .I3(receive_state[1]),
        .I4(receive_state[0]),
        .O(character_received_com));
  FDRE character_received_d_reg
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(character_received_com),
        .Q(character_received_d),
        .R(parity_error_d0));
  LUT4 #(
    .INIT(16'hFFBE)) 
    character_received_flag_i_1
       (.I0(character_received_rclk),
        .I1(mcr4_d),
        .I2(Q),
        .I3(bus2ip_reset_int_core),
        .O(framing_error_flag0));
  LUT2 #(
    .INIT(4'h2)) 
    character_received_flag_i_2
       (.I0(character_received_d),
        .I1(p_0_in),
        .O(character_received_flag0));
  FDRE character_received_flag_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(character_received_flag0),
        .Q(character_received_flag),
        .R(framing_error_flag0));
  FDRE character_received_rclk_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(character_received_d),
        .Q(character_received_rclk),
        .R(rx_rst));
  FDRE clk1x_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clk1x),
        .Q(clk1x_d),
        .R(rx_rst));
  LUT3 #(
    .INIT(8'hF6)) 
    clk1x_i_1
       (.I0(mcr4_d),
        .I1(Q),
        .I2(bus2ip_reset_int_core),
        .O(rx_rst));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    clk1x_i_2
       (.I0(clk1x_i_3_n_0),
        .I1(\clkdiv_reg_n_0_[2] ),
        .I2(\clkdiv_reg_n_0_[3] ),
        .I3(\clkdiv_reg_n_0_[0] ),
        .I4(\clkdiv_reg_n_0_[1] ),
        .I5(p_0_in),
        .O(clk1x0));
  LUT6 #(
    .INIT(64'h0000000004FF0000)) 
    clk1x_i_3
       (.I0(clk1x_i_4_n_0),
        .I1(sin_d10),
        .I2(sin_d9),
        .I3(resynch_clkdiv_d_i_2_n_0),
        .I4(got_start_bit_d),
        .I5(p_0_in),
        .O(clk1x_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFFB)) 
    clk1x_i_4
       (.I0(receive_state[1]),
        .I1(receive_state[2]),
        .I2(receive_state[3]),
        .I3(receive_state[0]),
        .O(clk1x_i_4_n_0));
  FDRE clk1x_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clk1x0),
        .Q(clk1x),
        .R(rx_rst));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    clk2x_i_1__0
       (.I0(\clkdiv_reg_n_0_[0] ),
        .I1(\clkdiv_reg_n_0_[1] ),
        .I2(\clkdiv_reg_n_0_[2] ),
        .I3(\clkdiv_reg_n_0_[3] ),
        .I4(p_0_in),
        .O(clk2x0));
  FDRE clk2x_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clk2x0),
        .Q(clk2x),
        .R(rx_rst));
  LUT6 #(
    .INIT(64'h0888888800000000)) 
    clk_div_en_i_1
       (.I0(\clkdiv[3]_i_4_n_0 ),
        .I1(have_bi_in_fifo_n),
        .I2(resynch_clkdiv_startbit_d_i_3_n_0),
        .I3(clk_div_en_i_2_n_0),
        .I4(clk1x_d),
        .I5(clk_div_en_i_3_n_0),
        .O(clk_div_en_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    clk_div_en_i_2
       (.I0(receive_state[0]),
        .I1(receive_state[3]),
        .O(clk_div_en_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFF0010)) 
    clk_div_en_i_3
       (.I0(p_0_in),
        .I1(sin_d1),
        .I2(sin_d2),
        .I3(got_start_bit_d),
        .I4(clk_div_en_reg_n_0),
        .O(clk_div_en_i_3_n_0));
  FDRE clk_div_en_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clk_div_en_i_1_n_0),
        .Q(clk_div_en_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'hAAAAAAAB)) 
    \clkdiv[0]_i_1 
       (.I0(\clkdiv[3]_i_5_n_0 ),
        .I1(resynch_clkdiv_startbit_d),
        .I2(resynch_clkdiv_frame_d),
        .I3(resynch_clkdiv_d),
        .I4(\clkdiv_reg_n_0_[0] ),
        .O(\clkdiv[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAABAAABAAAA)) 
    \clkdiv[1]_i_1__0 
       (.I0(\clkdiv[3]_i_5_n_0 ),
        .I1(resynch_clkdiv_startbit_d),
        .I2(resynch_clkdiv_frame_d),
        .I3(resynch_clkdiv_d),
        .I4(\clkdiv_reg_n_0_[1] ),
        .I5(\clkdiv_reg_n_0_[0] ),
        .O(\clkdiv[1]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000006AFFFFFFFF)) 
    \clkdiv[2]_i_1__0 
       (.I0(\clkdiv_reg_n_0_[2] ),
        .I1(\clkdiv_reg_n_0_[0] ),
        .I2(\clkdiv_reg_n_0_[1] ),
        .I3(resynch_clkdiv_frame_d),
        .I4(resynch_clkdiv_startbit_d),
        .I5(\clkdiv[2]_i_2_n_0 ),
        .O(\clkdiv[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \clkdiv[2]_i_2 
       (.I0(resynch_clkdiv_d),
        .I1(\clkdiv[3]_i_5_n_0 ),
        .O(\clkdiv[2]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hBF)) 
    \clkdiv[3]_i_1__0 
       (.I0(clk1x_i_3_n_0),
        .I1(clk_div_en_reg_n_0),
        .I2(\clkdiv[3]_i_4_n_0 ),
        .O(\clkdiv[3]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'hFFFEFFFF)) 
    \clkdiv[3]_i_2__0 
       (.I0(resynch_clkdiv_startbit_d),
        .I1(resynch_clkdiv_frame_d),
        .I2(resynch_clkdiv_d),
        .I3(\clkdiv[3]_i_5_n_0 ),
        .I4(p_0_in),
        .O(\clkdiv[3]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000EFFE)) 
    \clkdiv[3]_i_3 
       (.I0(resynch_clkdiv_frame_d),
        .I1(resynch_clkdiv_startbit_d),
        .I2(\clkdiv_reg_n_0_[3] ),
        .I3(\clkdiv[3]_i_6_n_0 ),
        .I4(\clkdiv[3]_i_5_n_0 ),
        .I5(resynch_clkdiv_d),
        .O(\clkdiv[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h41)) 
    \clkdiv[3]_i_4 
       (.I0(bus2ip_reset_int_core),
        .I1(Q),
        .I2(mcr4_d),
        .O(\clkdiv[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    \clkdiv[3]_i_5 
       (.I0(\Lcr_reg[1] ),
        .I1(\Lcr_reg[7] [2]),
        .I2(clk2x),
        .I3(receive_state[0]),
        .I4(receive_state[1]),
        .I5(\FSM_sequential_receive_state[3]_i_3_n_0 ),
        .O(\clkdiv[3]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \clkdiv[3]_i_6 
       (.I0(\clkdiv_reg_n_0_[0] ),
        .I1(\clkdiv_reg_n_0_[1] ),
        .I2(\clkdiv_reg_n_0_[2] ),
        .O(\clkdiv[3]_i_6_n_0 ));
  FDRE \clkdiv_reg[0] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_2__0_n_0 ),
        .D(\clkdiv[0]_i_1_n_0 ),
        .Q(\clkdiv_reg_n_0_[0] ),
        .R(\clkdiv[3]_i_1__0_n_0 ));
  FDRE \clkdiv_reg[1] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_2__0_n_0 ),
        .D(\clkdiv[1]_i_1__0_n_0 ),
        .Q(\clkdiv_reg_n_0_[1] ),
        .R(\clkdiv[3]_i_1__0_n_0 ));
  FDRE \clkdiv_reg[2] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_2__0_n_0 ),
        .D(\clkdiv[2]_i_1__0_n_0 ),
        .Q(\clkdiv_reg_n_0_[2] ),
        .R(\clkdiv[3]_i_1__0_n_0 ));
  FDRE \clkdiv_reg[3] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_2__0_n_0 ),
        .D(\clkdiv[3]_i_3_n_0 ),
        .Q(\clkdiv_reg_n_0_[3] ),
        .R(\clkdiv[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h00000400)) 
    clock_1x_early_i_1
       (.I0(\clkdiv_reg_n_0_[0] ),
        .I1(\clkdiv_reg_n_0_[1] ),
        .I2(\clkdiv_reg_n_0_[3] ),
        .I3(\clkdiv_reg_n_0_[2] ),
        .I4(p_0_in),
        .O(clock_1x_early0));
  FDRE clock_1x_early_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clock_1x_early0),
        .Q(clock_1x_early),
        .R(rx_rst));
  LUT3 #(
    .INIT(8'h04)) 
    framing_error_d_i_1
       (.I0(sin_d2),
        .I1(receive_state[3]),
        .I2(framing_error_d_i_2_n_0),
        .O(framing_error_com));
  LUT6 #(
    .INIT(64'hFFFFFBFDFEF000FF)) 
    framing_error_d_i_2
       (.I0(\Lcr_reg[7] [0]),
        .I1(\Lcr_reg[7] [1]),
        .I2(\Lcr_reg[7] [3]),
        .I3(receive_state[0]),
        .I4(receive_state[2]),
        .I5(receive_state[1]),
        .O(framing_error_d_i_2_n_0));
  FDRE framing_error_d_reg
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(framing_error_com),
        .Q(framing_error_d),
        .R(parity_error_d0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    framing_error_flag_i_1
       (.I0(p_0_in),
        .I1(framing_error_d),
        .I2(framing_error_flag),
        .O(framing_error_flag_i_1_n_0));
  FDRE framing_error_flag_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(framing_error_flag_i_1_n_0),
        .Q(framing_error_flag),
        .R(framing_error_flag0));
  LUT2 #(
    .INIT(4'h8)) 
    framing_error_i_i_1
       (.I0(character_received_flag),
        .I1(framing_error_flag),
        .O(framing_error_i0));
  FDRE framing_error_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(framing_error_i0),
        .Q(in[1]),
        .R(rx_rst));
  LUT6 #(
    .INIT(64'h005FFF5FFF0FFDFF)) 
    got_start_bit_d_i_1
       (.I0(sin_d2),
        .I1(\Lcr_reg[7] [2]),
        .I2(receive_state[0]),
        .I3(receive_state[3]),
        .I4(receive_state[2]),
        .I5(receive_state[1]),
        .O(got_start_bit_com));
  FDRE got_start_bit_d_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(got_start_bit_com),
        .Q(got_start_bit_d),
        .R(rx_rst));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hF6FF)) 
    have_bi_in_fifo_n_i_i_1
       (.I0(mcr4_d),
        .I1(Q),
        .I2(bus2ip_reset_int_core),
        .I3(have_bi_in_fifo_n_i_i_2_n_0),
        .O(have_bi_in_fifo_n_i_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000540455555555)) 
    have_bi_in_fifo_n_i_i_2
       (.I0(sin_d2),
        .I1(character_received_flag),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(in[2]),
        .I4(break_interrupt_flag),
        .I5(have_bi_in_fifo_n),
        .O(have_bi_in_fifo_n_i_i_2_n_0));
  FDRE have_bi_in_fifo_n_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(have_bi_in_fifo_n_i_i_1_n_0),
        .Q(have_bi_in_fifo_n),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00008A80)) 
    load_rbr_d_i_1
       (.I0(\clkdiv[3]_i_4_n_0 ),
        .I1(load_rbr_com),
        .I2(clk2x),
        .I3(load_rbr_d),
        .I4(resynch_clkdiv_d),
        .O(load_rbr_d_i_1_n_0));
  LUT6 #(
    .INIT(64'h0024570000000000)) 
    load_rbr_d_i_2
       (.I0(receive_state[0]),
        .I1(\Lcr_reg[7] [0]),
        .I2(\Lcr_reg[7] [1]),
        .I3(receive_state[2]),
        .I4(receive_state[1]),
        .I5(receive_state[3]),
        .O(load_rbr_com));
  FDRE load_rbr_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(load_rbr_d_i_1_n_0),
        .Q(load_rbr_d),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAAEAAA)) 
    parity_error_d_i_1
       (.I0(parity_error_d_i_2_n_0),
        .I1(receive_state[0]),
        .I2(receive_state[3]),
        .I3(parity_error_d_i_3_n_0),
        .I4(parity_error_d_i_4_n_0),
        .I5(parity_error_d_i_5_n_0),
        .O(rx_parity_com));
  LUT2 #(
    .INIT(4'h1)) 
    parity_error_d_i_10
       (.I0(receive_state[2]),
        .I1(receive_state[1]),
        .O(parity_error_d_i_10_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00000040)) 
    parity_error_d_i_2
       (.I0(parity_error_d_i_6_n_0),
        .I1(receive_state[3]),
        .I2(receive_state[1]),
        .I3(receive_state[0]),
        .I4(receive_state[2]),
        .I5(parity_error_d_i_7_n_0),
        .O(parity_error_d_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    parity_error_d_i_3
       (.I0(receive_state[1]),
        .I1(receive_state[2]),
        .O(parity_error_d_i_3_n_0));
  LUT6 #(
    .INIT(64'hF7FF04000800FBFF)) 
    parity_error_d_i_4
       (.I0(\Lcr_reg[7] [4]),
        .I1(\Lcr_reg[7] [5]),
        .I2(\Lcr_reg[7] [0]),
        .I3(\Lcr_reg[7] [1]),
        .I4(parity_error_d),
        .I5(sin_d2),
        .O(parity_error_d_i_4_n_0));
  LUT6 #(
    .INIT(64'h0053000000000000)) 
    parity_error_d_i_5
       (.I0(parity_error_d_i_8_n_0),
        .I1(parity_error_d_i_9_n_0),
        .I2(receive_state[0]),
        .I3(receive_state[1]),
        .I4(receive_state[3]),
        .I5(receive_state[2]),
        .O(parity_error_d_i_5_n_0));
  LUT6 #(
    .INIT(64'hF7FF04000800FBFF)) 
    parity_error_d_i_6
       (.I0(\Lcr_reg[7] [4]),
        .I1(\Lcr_reg[7] [5]),
        .I2(\Lcr_reg[7] [1]),
        .I3(\Lcr_reg[7] [0]),
        .I4(parity_error_d),
        .I5(sin_d2),
        .O(parity_error_d_i_6_n_0));
  LUT6 #(
    .INIT(64'h0F66000F0F660066)) 
    parity_error_d_i_7
       (.I0(sin_d2),
        .I1(parity_error_d),
        .I2(\Lcr_reg[7] [4]),
        .I3(receive_state[3]),
        .I4(parity_error_d_i_10_n_0),
        .I5(receive_state[0]),
        .O(parity_error_d_i_7_n_0));
  LUT6 #(
    .INIT(64'hFFF700040008FFFB)) 
    parity_error_d_i_8
       (.I0(\Lcr_reg[7] [4]),
        .I1(\Lcr_reg[7] [5]),
        .I2(\Lcr_reg[7] [0]),
        .I3(\Lcr_reg[7] [1]),
        .I4(parity_error_d),
        .I5(sin_d2),
        .O(parity_error_d_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h748B)) 
    parity_error_d_i_9
       (.I0(\Lcr_reg[7] [4]),
        .I1(\Lcr_reg[7] [5]),
        .I2(parity_error_d),
        .I3(sin_d2),
        .O(parity_error_d_i_9_n_0));
  FDRE parity_error_d_reg
       (.C(s_axi_aclk),
        .CE(clk1x),
        .D(rx_parity_com),
        .Q(parity_error_d),
        .R(parity_error_d0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h80)) 
    parity_error_i_i_1
       (.I0(parity_error_latch),
        .I1(character_received_flag),
        .I2(\Lcr_reg[7] [3]),
        .O(parity_error_i0));
  FDRE parity_error_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(parity_error_i0),
        .Q(in[0]),
        .R(rx_rst));
  LUT4 #(
    .INIT(16'hBF80)) 
    parity_error_latch_i_1
       (.I0(parity_error_d),
        .I1(load_rbr_d),
        .I2(clk2x),
        .I3(parity_error_latch),
        .O(parity_error_latch_i_1_n_0));
  FDRE parity_error_latch_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(parity_error_latch_i_1_n_0),
        .Q(parity_error_latch),
        .R(framing_error_flag0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rbr_d[0]_i_1 
       (.I0(rsr[0]),
        .I1(rsr[2]),
        .I2(\Lcr_reg[7] [0]),
        .I3(rsr[1]),
        .I4(\Lcr_reg[7] [1]),
        .I5(rsr[3]),
        .O(\rbr_d[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rbr_d[1]_i_1 
       (.I0(rsr[1]),
        .I1(rsr[3]),
        .I2(\Lcr_reg[7] [0]),
        .I3(rsr[2]),
        .I4(\Lcr_reg[7] [1]),
        .I5(rsr[4]),
        .O(\rbr_d[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rbr_d[2]_i_1 
       (.I0(rsr[2]),
        .I1(rsr[4]),
        .I2(\Lcr_reg[7] [0]),
        .I3(rsr[3]),
        .I4(\Lcr_reg[7] [1]),
        .I5(rsr[5]),
        .O(\rbr_d[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rbr_d[3]_i_1 
       (.I0(rsr[3]),
        .I1(rsr[5]),
        .I2(\Lcr_reg[7] [0]),
        .I3(rsr[4]),
        .I4(\Lcr_reg[7] [1]),
        .I5(rsr[6]),
        .O(\rbr_d[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rbr_d[4]_i_1 
       (.I0(rsr[4]),
        .I1(rsr[6]),
        .I2(\Lcr_reg[7] [0]),
        .I3(rsr[5]),
        .I4(\Lcr_reg[7] [1]),
        .I5(rsr[7]),
        .O(\rbr_d[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \rbr_d[5]_i_1 
       (.I0(rsr[5]),
        .I1(rsr[7]),
        .I2(\Lcr_reg[7] [0]),
        .I3(\Lcr_reg[7] [1]),
        .I4(rsr[6]),
        .O(\rbr_d[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hA808)) 
    \rbr_d[6]_i_1 
       (.I0(\Lcr_reg[7] [1]),
        .I1(rsr[7]),
        .I2(\Lcr_reg[7] [0]),
        .I3(rsr[6]),
        .O(\rbr_d[6]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \rbr_d[7]_i_1 
       (.I0(clk1x),
        .I1(load_rbr_d),
        .O(rbr_d0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \rbr_d[7]_i_2 
       (.I0(rsr[7]),
        .I1(\Lcr_reg[7] [0]),
        .I2(\Lcr_reg[7] [1]),
        .O(\rbr_d[7]_i_2_n_0 ));
  FDRE \rbr_d_reg[0] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[0]_i_1_n_0 ),
        .Q(in[10]),
        .R(rx_rst));
  FDRE \rbr_d_reg[1] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[1]_i_1_n_0 ),
        .Q(in[9]),
        .R(rx_rst));
  FDRE \rbr_d_reg[2] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[2]_i_1_n_0 ),
        .Q(in[8]),
        .R(rx_rst));
  FDRE \rbr_d_reg[3] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[3]_i_1_n_0 ),
        .Q(in[7]),
        .R(rx_rst));
  FDRE \rbr_d_reg[4] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[4]_i_1_n_0 ),
        .Q(in[6]),
        .R(rx_rst));
  FDRE \rbr_d_reg[5] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[5]_i_1_n_0 ),
        .Q(in[5]),
        .R(rx_rst));
  FDRE \rbr_d_reg[6] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[6]_i_1_n_0 ),
        .Q(in[4]),
        .R(rx_rst));
  FDRE \rbr_d_reg[7] 
       (.C(s_axi_aclk),
        .CE(rbr_d0),
        .D(\rbr_d[7]_i_2_n_0 ),
        .Q(in[3]),
        .R(rx_rst));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h04)) 
    resynch_clkdiv_d_i_1
       (.I0(p_0_in),
        .I1(got_start_bit_d),
        .I2(resynch_clkdiv_d_i_2_n_0),
        .O(resynch_clkdiv));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    resynch_clkdiv_d_i_2
       (.I0(resynch_clkdiv_d_i_3_n_0),
        .I1(sin_d5),
        .I2(sin_d6),
        .I3(clock_1x_early),
        .I4(framing_error_d),
        .O(resynch_clkdiv_d_i_2_n_0));
  LUT5 #(
    .INIT(32'hF3FFFFEF)) 
    resynch_clkdiv_d_i_3
       (.I0(\Lcr_reg[7] [2]),
        .I1(receive_state[0]),
        .I2(receive_state[3]),
        .I3(receive_state[2]),
        .I4(receive_state[1]),
        .O(resynch_clkdiv_d_i_3_n_0));
  FDRE resynch_clkdiv_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(resynch_clkdiv),
        .Q(resynch_clkdiv_d),
        .R(rx_rst));
  LUT6 #(
    .INIT(64'hF2FFFFF202000002)) 
    resynch_clkdiv_frame_d_i_1
       (.I0(resynch_clkdiv_frame_d_i_2_n_0),
        .I1(resynch_clkdiv_frame_d_i_3_n_0),
        .I2(bus2ip_reset_int_core),
        .I3(Q),
        .I4(mcr4_d),
        .I5(resynch_clkdiv_frame_d),
        .O(resynch_clkdiv_frame_d_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    resynch_clkdiv_frame_d_i_2
       (.I0(p_0_in),
        .I1(got_start_bit_d),
        .I2(sin_d10),
        .I3(sin_d9),
        .O(resynch_clkdiv_frame_d_i_2_n_0));
  LUT6 #(
    .INIT(64'hF7F7FFF7FFFFFFFF)) 
    resynch_clkdiv_frame_d_i_3
       (.I0(receive_state[1]),
        .I1(receive_state[0]),
        .I2(receive_state[3]),
        .I3(\Lcr_reg[7] [2]),
        .I4(receive_state[2]),
        .I5(framing_error_d),
        .O(resynch_clkdiv_frame_d_i_3_n_0));
  FDRE resynch_clkdiv_frame_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(resynch_clkdiv_frame_d_i_1_n_0),
        .Q(resynch_clkdiv_frame_d),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0040000000000000)) 
    resynch_clkdiv_startbit_d_i_1
       (.I0(sin_d9),
        .I1(sin_d10),
        .I2(got_start_bit_d),
        .I3(p_0_in),
        .I4(resynch_clkdiv_startbit_d_i_2_n_0),
        .I5(resynch_clkdiv_startbit_d_i_3_n_0),
        .O(resynch_clkdiv_startbit));
  LUT2 #(
    .INIT(4'h1)) 
    resynch_clkdiv_startbit_d_i_2
       (.I0(receive_state[0]),
        .I1(receive_state[3]),
        .O(resynch_clkdiv_startbit_d_i_2_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    resynch_clkdiv_startbit_d_i_3
       (.I0(receive_state[2]),
        .I1(receive_state[1]),
        .O(resynch_clkdiv_startbit_d_i_3_n_0));
  FDRE resynch_clkdiv_startbit_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(resynch_clkdiv_startbit),
        .Q(resynch_clkdiv_startbit_d),
        .R(rx_rst));
  FDRE \rsr_reg[0] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[1]),
        .Q(rsr[0]),
        .R(rx_rst));
  FDRE \rsr_reg[1] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[2]),
        .Q(rsr[1]),
        .R(rx_rst));
  FDRE \rsr_reg[2] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[3]),
        .Q(rsr[2]),
        .R(rx_rst));
  FDRE \rsr_reg[3] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[4]),
        .Q(rsr[3]),
        .R(rx_rst));
  FDRE \rsr_reg[4] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[5]),
        .Q(rsr[4]),
        .R(rx_rst));
  FDRE \rsr_reg[5] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[6]),
        .Q(rsr[5]),
        .R(rx_rst));
  FDRE \rsr_reg[6] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(rsr[7]),
        .Q(rsr[6]),
        .R(rx_rst));
  FDRE \rsr_reg[7] 
       (.C(s_axi_aclk),
        .CE(clk1x_d),
        .D(sin_d2),
        .Q(rsr[7]),
        .R(rx_rst));
  FDRE sin_d10_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d9),
        .Q(sin_d10),
        .R(rx_rst));
  LUT1 #(
    .INIT(2'h1)) 
    sin_d1_i_1
       (.I0(p_0_in),
        .O(rclk_int));
  FDRE sin_d1_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(rx_sin),
        .Q(sin_d1),
        .R(rx_rst));
  FDRE sin_d2_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d1),
        .Q(sin_d2),
        .R(rx_rst));
  FDRE sin_d3_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d2),
        .Q(sin_d3),
        .R(rx_rst));
  FDRE sin_d4_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d3),
        .Q(sin_d4),
        .R(rx_rst));
  FDRE sin_d5_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d4),
        .Q(sin_d5),
        .R(rx_rst));
  FDRE sin_d6_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d5),
        .Q(sin_d6),
        .R(rx_rst));
  FDRE sin_d7_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d6),
        .Q(sin_d7),
        .R(rx_rst));
  FDRE sin_d8_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d7),
        .Q(sin_d8),
        .R(rx_rst));
  FDRE sin_d9_reg
       (.C(s_axi_aclk),
        .CE(rclk_int),
        .D(sin_d8),
        .Q(sin_d9),
        .R(rx_rst));
endmodule

(* ORIG_REF_NAME = "rx_fifo_block" *) 
module sensors96b_axi_uart16550_0_0_rx_fifo_block
   (rx_fifo_full,
    Rx_error_in_fifo,
    \lsr_reg[0] ,
    lsr2_rst_reg,
    \lsr_reg[0]_0 ,
    \lsr_reg[1] ,
    thre_iir_set_reg,
    \iir_reg[3] ,
    \iir_reg[0] ,
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ,
    out,
    D,
    \iir_reg[1] ,
    \iir_reg[0]_0 ,
    \iir_reg[2] ,
    rxrdyN_int_reg,
    lsr2_set,
    lsr4_set,
    lsr3_set,
    bus2ip_reset_int_core,
    s_axi_aclk,
    rx_fifo_rst,
    Rx_error_in_fifo0,
    Q,
    lsr_reg0,
    \GENERATING_FIFOS.fcr_reg[0] ,
    character_received,
    \lsr_reg[0]_1 ,
    rd_d_reg,
    chipSelect,
    wr_d,
    rx_fifo_rd_en_d,
    lsr2_rst,
    rx_fifo_wr_en_i,
    chipSelect_reg,
    \addr_d_reg[0] ,
    \lsr_reg[1]_0 ,
    p_0_in,
    \GENERATING_FIFOS.fcr_reg[7] ,
    \iir_reg[2]_0 ,
    bus2ip_reset_int_core_reg,
    p_2_in51_in,
    thre_iir_set,
    writing_thr,
    lsr5_d,
    \addr_d_reg[0]_0 ,
    rd_d_reg_0,
    iir,
    \iir_reg[2]_1 ,
    \ier_reg[2] ,
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ,
    rd_d_reg_1,
    dlab_reg,
    \dll_reg[6] ,
    \addr_d_reg[2] ,
    \lsr_reg[6] ,
    \Lcr_reg[6] ,
    \Lcr_reg[3] ,
    \addr_d_reg[2]_0 ,
    L,
    \msr_reg[2] ,
    \addr_d_reg[2]_1 ,
    \ier_reg[3] ,
    \addr_d_reg[1] ,
    \dll_reg[1] ,
    \Rbr_reg[6] ,
    \iir_reg[0]_1 ,
    \ier_reg[0] ,
    dlab_reg_0,
    p_0_in2_in,
    \addr_d_reg[1]_0 ,
    \scr_reg[6] ,
    \iir_reg[7] ,
    \ier_reg[3]_0 ,
    p_1_in43_in,
    p_0_in42_in,
    p_2_in44_in,
    \GENERATING_FIFOS.fcr_reg[3] ,
    \Lcr_reg[3]_0 ,
    in,
    rx_fifo_rd_en_d1,
    SR);
  output rx_fifo_full;
  output Rx_error_in_fifo;
  output [0:0]\lsr_reg[0] ;
  output lsr2_rst_reg;
  output \lsr_reg[0]_0 ;
  output \lsr_reg[1] ;
  output thre_iir_set_reg;
  output \iir_reg[3] ;
  output \iir_reg[0] ;
  output \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ;
  output [2:0]out;
  output [4:0]D;
  output \iir_reg[1] ;
  output \iir_reg[0]_0 ;
  output \iir_reg[2] ;
  output rxrdyN_int_reg;
  output lsr2_set;
  output lsr4_set;
  output lsr3_set;
  input bus2ip_reset_int_core;
  input s_axi_aclk;
  input rx_fifo_rst;
  input Rx_error_in_fifo0;
  input [1:0]Q;
  input lsr_reg0;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input character_received;
  input \lsr_reg[0]_1 ;
  input rd_d_reg;
  input chipSelect;
  input wr_d;
  input rx_fifo_rd_en_d;
  input lsr2_rst;
  input rx_fifo_wr_en_i;
  input chipSelect_reg;
  input \addr_d_reg[0] ;
  input \lsr_reg[1]_0 ;
  input p_0_in;
  input [4:0]\GENERATING_FIFOS.fcr_reg[7] ;
  input \iir_reg[2]_0 ;
  input bus2ip_reset_int_core_reg;
  input p_2_in51_in;
  input thre_iir_set;
  input writing_thr;
  input lsr5_d;
  input \addr_d_reg[0]_0 ;
  input rd_d_reg_0;
  input [3:0]iir;
  input \iir_reg[2]_1 ;
  input \ier_reg[2] ;
  input \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ;
  input rd_d_reg_1;
  input dlab_reg;
  input [0:0]\dll_reg[6] ;
  input \addr_d_reg[2] ;
  input \lsr_reg[6] ;
  input \Lcr_reg[6] ;
  input \Lcr_reg[3] ;
  input \addr_d_reg[2]_0 ;
  input [0:0]L;
  input \msr_reg[2] ;
  input \addr_d_reg[2]_1 ;
  input [3:0]\ier_reg[3] ;
  input \addr_d_reg[1] ;
  input \dll_reg[1] ;
  input [4:0]\Rbr_reg[6] ;
  input \iir_reg[0]_1 ;
  input \ier_reg[0] ;
  input dlab_reg_0;
  input p_0_in2_in;
  input \addr_d_reg[1]_0 ;
  input [0:0]\scr_reg[6] ;
  input \iir_reg[7] ;
  input \ier_reg[3]_0 ;
  input p_1_in43_in;
  input p_0_in42_in;
  input p_2_in44_in;
  input \GENERATING_FIFOS.fcr_reg[3] ;
  input [0:0]\Lcr_reg[3]_0 ;
  input [0:10]in;
  input rx_fifo_rd_en_d1;
  input [0:0]SR;

  wire [4:0]D;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire \GENERATING_FIFOS.fcr_reg[3] ;
  wire [4:0]\GENERATING_FIFOS.fcr_reg[7] ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ;
  wire [0:0]L;
  wire \Lcr_reg[3] ;
  wire [0:0]\Lcr_reg[3]_0 ;
  wire \Lcr_reg[6] ;
  wire [1:0]Q;
  wire [4:0]\Rbr_reg[6] ;
  wire Rx_error_in_fifo;
  wire Rx_error_in_fifo0;
  wire [0:0]SR;
  wire \addr_d_reg[0] ;
  wire \addr_d_reg[0]_0 ;
  wire \addr_d_reg[1] ;
  wire \addr_d_reg[1]_0 ;
  wire \addr_d_reg[2] ;
  wire \addr_d_reg[2]_0 ;
  wire \addr_d_reg[2]_1 ;
  wire bus2ip_reset_int_core;
  wire bus2ip_reset_int_core_reg;
  wire character_received;
  wire chipSelect;
  wire chipSelect_reg;
  wire dlab_reg;
  wire dlab_reg_0;
  wire \dll_reg[1] ;
  wire [0:0]\dll_reg[6] ;
  wire \ier_reg[0] ;
  wire \ier_reg[2] ;
  wire [3:0]\ier_reg[3] ;
  wire \ier_reg[3]_0 ;
  wire [3:0]iir;
  wire \iir_reg[0] ;
  wire \iir_reg[0]_0 ;
  wire \iir_reg[0]_1 ;
  wire \iir_reg[1] ;
  wire \iir_reg[2] ;
  wire \iir_reg[2]_0 ;
  wire \iir_reg[2]_1 ;
  wire \iir_reg[3] ;
  wire \iir_reg[7] ;
  wire [0:10]in;
  wire lsr2_rst;
  wire lsr2_rst_reg;
  wire lsr2_set;
  wire lsr3_set;
  wire lsr4_set;
  wire lsr5_d;
  wire lsr_reg0;
  wire [0:0]\lsr_reg[0] ;
  wire \lsr_reg[0]_0 ;
  wire \lsr_reg[0]_1 ;
  wire \lsr_reg[1] ;
  wire \lsr_reg[1]_0 ;
  wire \lsr_reg[6] ;
  wire \msr_reg[2] ;
  wire [2:0]out;
  wire p_0_in;
  wire p_0_in2_in;
  wire p_0_in42_in;
  wire p_1_in43_in;
  wire p_2_in44_in;
  wire p_2_in51_in;
  wire rd_d_reg;
  wire rd_d_reg_0;
  wire rd_d_reg_1;
  wire rx_fifo_full;
  wire rx_fifo_rd_en_d;
  wire rx_fifo_rd_en_d1;
  wire rx_fifo_rst;
  wire rx_fifo_wr_en_i;
  wire rxrdyN_int_reg;
  wire s_axi_aclk;
  wire [0:0]\scr_reg[6] ;
  wire srl_fifo_rbu_f_i1_n_3;
  wire thre_iir_set;
  wire thre_iir_set_reg;
  wire wr_d;
  wire writing_thr;

  sensors96b_axi_uart16550_0_0_rx_fifo_control rx_fifo_control_1
       (.\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg[0] ),
        .\GENERATING_FIFOS.fcr_reg[3] (\GENERATING_FIFOS.fcr_reg[3] ),
        .\INFERRED_GEN.cnt_i_reg[4] (srl_fifo_rbu_f_i1_n_3),
        .Q(\lsr_reg[0] ),
        .Rx_error_in_fifo(Rx_error_in_fifo),
        .Rx_error_in_fifo0(Rx_error_in_fifo0),
        .SR(SR),
        .\addr_d_reg[0] (\addr_d_reg[0]_0 ),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .bus2ip_reset_int_core_reg(bus2ip_reset_int_core_reg),
        .\ier_reg[2] (\ier_reg[2] ),
        .\ier_reg[2]_0 (\ier_reg[3] [2:0]),
        .\ier_reg[3] (\ier_reg[3]_0 ),
        .iir(iir),
        .\iir_reg[0] (\iir_reg[0] ),
        .\iir_reg[0]_0 (\iir_reg[0]_0 ),
        .\iir_reg[1] (\iir_reg[1] ),
        .\iir_reg[2] (\iir_reg[2] ),
        .\iir_reg[2]_0 (\iir_reg[2]_0 ),
        .\iir_reg[2]_1 (\iir_reg[2]_1 ),
        .\iir_reg[3] (\iir_reg[3] ),
        .lsr5_d(lsr5_d),
        .\lsr_reg[0] (\lsr_reg[0]_1 ),
        .\lsr_reg[1] (\lsr_reg[1]_0 ),
        .p_0_in(p_0_in),
        .p_0_in42_in(p_0_in42_in),
        .p_1_in43_in(p_1_in43_in),
        .p_2_in44_in(p_2_in44_in),
        .p_2_in51_in(p_2_in51_in),
        .rd_d_reg(rd_d_reg_0),
        .rd_d_reg_0(rd_d_reg_1),
        .rxrdyN_int_reg(rxrdyN_int_reg),
        .s_axi_aclk(s_axi_aclk),
        .thre_iir_set(thre_iir_set),
        .thre_iir_set_reg(thre_iir_set_reg),
        .writing_thr(writing_thr));
  sensors96b_axi_uart16550_0_0_srl_fifo_rbu_f__parameterized0 srl_fifo_rbu_f_i1
       (.D(D),
        .\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg[0] ),
        .\GENERATING_FIFOS.fcr_reg[7] (\GENERATING_FIFOS.fcr_reg[7] ),
        .\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg (\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ),
        .\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] (\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ),
        .L(L),
        .\Lcr_reg[3] (\Lcr_reg[3] ),
        .\Lcr_reg[3]_0 (\Lcr_reg[3]_0 ),
        .\Lcr_reg[6] (\Lcr_reg[6] ),
        .Q(Q),
        .\Rbr_reg[6] (\Rbr_reg[6] ),
        .Rx_fifo_trigger_reg(srl_fifo_rbu_f_i1_n_3),
        .\addr_d_reg[0] (\addr_d_reg[0] ),
        .\addr_d_reg[0]_0 (\addr_d_reg[0]_0 ),
        .\addr_d_reg[1] (\addr_d_reg[1] ),
        .\addr_d_reg[1]_0 (\addr_d_reg[1]_0 ),
        .\addr_d_reg[2] (\addr_d_reg[2] ),
        .\addr_d_reg[2]_0 (\addr_d_reg[2]_0 ),
        .\addr_d_reg[2]_1 (\addr_d_reg[2]_1 ),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .character_received(character_received),
        .chipSelect(chipSelect),
        .chipSelect_reg(chipSelect_reg),
        .dlab_reg(dlab_reg),
        .dlab_reg_0(dlab_reg_0),
        .\dll_reg[1] (\dll_reg[1] ),
        .\dll_reg[6] (\dll_reg[6] ),
        .\ier_reg[0] (\ier_reg[0] ),
        .\ier_reg[3] (\ier_reg[3] [3:1]),
        .iir(iir[3:1]),
        .\iir_reg[0] (\iir_reg[0]_1 ),
        .\iir_reg[7] (\iir_reg[7] ),
        .in(in),
        .lsr2_rst(lsr2_rst),
        .lsr2_rst_reg(lsr2_rst_reg),
        .lsr2_set(lsr2_set),
        .lsr3_set(lsr3_set),
        .lsr4_set(lsr4_set),
        .lsr_reg0(lsr_reg0),
        .\lsr_reg[0] (\lsr_reg[0] ),
        .\lsr_reg[0]_0 (\lsr_reg[0]_0 ),
        .\lsr_reg[0]_1 (\lsr_reg[0]_1 ),
        .\lsr_reg[1] (\lsr_reg[1] ),
        .\lsr_reg[1]_0 (\lsr_reg[1]_0 ),
        .\lsr_reg[6] (\lsr_reg[6] ),
        .\msr_reg[2] (\msr_reg[2] ),
        .out(out),
        .p_0_in2_in(p_0_in2_in),
        .rd_d_reg(rd_d_reg),
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_rd_en_d(rx_fifo_rd_en_d),
        .rx_fifo_rd_en_d1(rx_fifo_rd_en_d1),
        .rx_fifo_rst(rx_fifo_rst),
        .rx_fifo_wr_en_i(rx_fifo_wr_en_i),
        .s_axi_aclk(s_axi_aclk),
        .\scr_reg[6] (\scr_reg[6] ),
        .wr_d(wr_d));
endmodule

(* ORIG_REF_NAME = "rx_fifo_control" *) 
module sensors96b_axi_uart16550_0_0_rx_fifo_control
   (Rx_error_in_fifo,
    thre_iir_set_reg,
    \iir_reg[3] ,
    \iir_reg[0] ,
    \iir_reg[1] ,
    \iir_reg[0]_0 ,
    \iir_reg[2] ,
    rxrdyN_int_reg,
    bus2ip_reset_int_core,
    \INFERRED_GEN.cnt_i_reg[4] ,
    s_axi_aclk,
    Rx_error_in_fifo0,
    p_0_in,
    \iir_reg[2]_0 ,
    bus2ip_reset_int_core_reg,
    p_2_in51_in,
    thre_iir_set,
    writing_thr,
    lsr5_d,
    \addr_d_reg[0] ,
    rd_d_reg,
    iir,
    \iir_reg[2]_1 ,
    \ier_reg[2] ,
    rd_d_reg_0,
    \GENERATING_FIFOS.fcr_reg[0] ,
    \ier_reg[2]_0 ,
    \ier_reg[3] ,
    \lsr_reg[1] ,
    p_1_in43_in,
    p_0_in42_in,
    p_2_in44_in,
    \lsr_reg[0] ,
    \GENERATING_FIFOS.fcr_reg[3] ,
    Q,
    SR);
  output Rx_error_in_fifo;
  output thre_iir_set_reg;
  output \iir_reg[3] ;
  output \iir_reg[0] ;
  output \iir_reg[1] ;
  output \iir_reg[0]_0 ;
  output \iir_reg[2] ;
  output rxrdyN_int_reg;
  input bus2ip_reset_int_core;
  input \INFERRED_GEN.cnt_i_reg[4] ;
  input s_axi_aclk;
  input Rx_error_in_fifo0;
  input p_0_in;
  input \iir_reg[2]_0 ;
  input bus2ip_reset_int_core_reg;
  input p_2_in51_in;
  input thre_iir_set;
  input writing_thr;
  input lsr5_d;
  input \addr_d_reg[0] ;
  input rd_d_reg;
  input [3:0]iir;
  input \iir_reg[2]_1 ;
  input \ier_reg[2] ;
  input rd_d_reg_0;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input [2:0]\ier_reg[2]_0 ;
  input \ier_reg[3] ;
  input \lsr_reg[1] ;
  input p_1_in43_in;
  input p_0_in42_in;
  input p_2_in44_in;
  input \lsr_reg[0] ;
  input \GENERATING_FIFOS.fcr_reg[3] ;
  input [0:0]Q;
  input [0:0]SR;

  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire \GENERATING_FIFOS.fcr_reg[3] ;
  wire \INFERRED_GEN.cnt_i_reg[4] ;
  wire [0:0]Q;
  wire Rx_error_in_fifo;
  wire Rx_error_in_fifo0;
  wire [0:0]SR;
  wire \addr_d_reg[0] ;
  wire bus2ip_reset_int_core;
  wire bus2ip_reset_int_core_reg;
  wire character_counter0;
  wire \character_counter[9]_i_4_n_0 ;
  wire \character_counter_reg_n_0_[0] ;
  wire \character_counter_reg_n_0_[1] ;
  wire \character_counter_reg_n_0_[2] ;
  wire \character_counter_reg_n_0_[3] ;
  wire \character_counter_reg_n_0_[4] ;
  wire \character_counter_reg_n_0_[5] ;
  wire \character_counter_reg_n_0_[6] ;
  wire \character_counter_reg_n_0_[7] ;
  wire \ier_reg[2] ;
  wire [2:0]\ier_reg[2]_0 ;
  wire \ier_reg[3] ;
  wire [3:0]iir;
  wire \iir[0]_i_2_n_0 ;
  wire \iir[2]_i_3_n_0 ;
  wire \iir[2]_i_4_n_0 ;
  wire \iir[2]_i_7_n_0 ;
  wire \iir[3]_i_2_n_0 ;
  wire \iir_reg[0] ;
  wire \iir_reg[0]_0 ;
  wire \iir_reg[1] ;
  wire \iir_reg[2] ;
  wire \iir_reg[2]_0 ;
  wire \iir_reg[2]_1 ;
  wire \iir_reg[3] ;
  wire lsr5_d;
  wire \lsr_reg[0] ;
  wire \lsr_reg[1] ;
  wire p_0_in;
  wire p_0_in42_in;
  wire p_0_in_0;
  wire p_1_in;
  wire p_1_in43_in;
  wire p_2_in44_in;
  wire p_2_in51_in;
  wire [9:0]plusOp;
  wire rd_d_reg;
  wire rd_d_reg_0;
  wire rx_fifo_trigger;
  wire rxrdyN_int_reg;
  wire s_axi_aclk;
  wire thre_iir_set;
  wire thre_iir_set_i_4_n_0;
  wire thre_iir_set_reg;
  wire writing_thr;

  FDRE Rx_error_in_fifo_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Rx_error_in_fifo0),
        .Q(Rx_error_in_fifo),
        .R(bus2ip_reset_int_core));
  FDRE Rx_fifo_trigger_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\INFERRED_GEN.cnt_i_reg[4] ),
        .Q(rx_fifo_trigger),
        .R(bus2ip_reset_int_core));
  LUT1 #(
    .INIT(2'h1)) 
    \character_counter[0]_i_1 
       (.I0(\character_counter_reg_n_0_[0] ),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \character_counter[1]_i_1 
       (.I0(\character_counter_reg_n_0_[1] ),
        .I1(\character_counter_reg_n_0_[0] ),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \character_counter[2]_i_1 
       (.I0(\character_counter_reg_n_0_[2] ),
        .I1(\character_counter_reg_n_0_[1] ),
        .I2(\character_counter_reg_n_0_[0] ),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \character_counter[3]_i_1 
       (.I0(\character_counter_reg_n_0_[3] ),
        .I1(\character_counter_reg_n_0_[0] ),
        .I2(\character_counter_reg_n_0_[1] ),
        .I3(\character_counter_reg_n_0_[2] ),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \character_counter[4]_i_1 
       (.I0(\character_counter_reg_n_0_[4] ),
        .I1(\character_counter_reg_n_0_[2] ),
        .I2(\character_counter_reg_n_0_[1] ),
        .I3(\character_counter_reg_n_0_[0] ),
        .I4(\character_counter_reg_n_0_[3] ),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \character_counter[5]_i_1 
       (.I0(\character_counter_reg_n_0_[5] ),
        .I1(\character_counter_reg_n_0_[3] ),
        .I2(\character_counter_reg_n_0_[0] ),
        .I3(\character_counter_reg_n_0_[1] ),
        .I4(\character_counter_reg_n_0_[2] ),
        .I5(\character_counter_reg_n_0_[4] ),
        .O(plusOp[5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \character_counter[6]_i_1 
       (.I0(\character_counter_reg_n_0_[6] ),
        .I1(\character_counter[9]_i_4_n_0 ),
        .O(plusOp[6]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \character_counter[7]_i_1 
       (.I0(\character_counter_reg_n_0_[7] ),
        .I1(\character_counter[9]_i_4_n_0 ),
        .I2(\character_counter_reg_n_0_[6] ),
        .O(plusOp[7]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \character_counter[8]_i_1 
       (.I0(\character_counter_reg_n_0_[6] ),
        .I1(\character_counter[9]_i_4_n_0 ),
        .I2(\character_counter_reg_n_0_[7] ),
        .I3(p_0_in_0),
        .O(plusOp[8]));
  LUT3 #(
    .INIT(8'h15)) 
    \character_counter[9]_i_2 
       (.I0(p_0_in),
        .I1(p_0_in_0),
        .I2(p_1_in),
        .O(character_counter0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hA6AAAAAA)) 
    \character_counter[9]_i_3 
       (.I0(p_1_in),
        .I1(\character_counter_reg_n_0_[6] ),
        .I2(\character_counter[9]_i_4_n_0 ),
        .I3(\character_counter_reg_n_0_[7] ),
        .I4(p_0_in_0),
        .O(plusOp[9]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \character_counter[9]_i_4 
       (.I0(\character_counter_reg_n_0_[4] ),
        .I1(\character_counter_reg_n_0_[2] ),
        .I2(\character_counter_reg_n_0_[1] ),
        .I3(\character_counter_reg_n_0_[0] ),
        .I4(\character_counter_reg_n_0_[3] ),
        .I5(\character_counter_reg_n_0_[5] ),
        .O(\character_counter[9]_i_4_n_0 ));
  FDRE \character_counter_reg[0] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[0]),
        .Q(\character_counter_reg_n_0_[0] ),
        .R(SR));
  FDRE \character_counter_reg[1] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[1]),
        .Q(\character_counter_reg_n_0_[1] ),
        .R(SR));
  FDRE \character_counter_reg[2] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[2]),
        .Q(\character_counter_reg_n_0_[2] ),
        .R(SR));
  FDRE \character_counter_reg[3] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[3]),
        .Q(\character_counter_reg_n_0_[3] ),
        .R(SR));
  FDRE \character_counter_reg[4] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[4]),
        .Q(\character_counter_reg_n_0_[4] ),
        .R(SR));
  FDRE \character_counter_reg[5] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[5]),
        .Q(\character_counter_reg_n_0_[5] ),
        .R(SR));
  FDRE \character_counter_reg[6] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[6]),
        .Q(\character_counter_reg_n_0_[6] ),
        .R(SR));
  FDRE \character_counter_reg[7] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[7]),
        .Q(\character_counter_reg_n_0_[7] ),
        .R(SR));
  FDRE \character_counter_reg[8] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[8]),
        .Q(p_0_in_0),
        .R(SR));
  FDRE \character_counter_reg[9] 
       (.C(s_axi_aclk),
        .CE(character_counter0),
        .D(plusOp[9]),
        .Q(p_1_in),
        .R(SR));
  LUT4 #(
    .INIT(16'h0222)) 
    \iir[0]_i_1 
       (.I0(\iir[0]_i_2_n_0 ),
        .I1(\ier_reg[3] ),
        .I2(\ier_reg[2]_0 [1]),
        .I3(thre_iir_set),
        .O(\iir_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h000000000001FFFF)) 
    \iir[0]_i_2 
       (.I0(p_2_in44_in),
        .I1(p_0_in42_in),
        .I2(p_1_in43_in),
        .I3(\lsr_reg[1] ),
        .I4(\ier_reg[2]_0 [2]),
        .I5(\iir[2]_i_4_n_0 ),
        .O(\iir[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hBAAA)) 
    \iir[1]_i_1 
       (.I0(\ier_reg[2] ),
        .I1(\iir[2]_i_4_n_0 ),
        .I2(\ier_reg[2]_0 [1]),
        .I3(thre_iir_set),
        .O(\iir_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \iir[2]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(\iir[2]_i_3_n_0 ),
        .O(\iir_reg[0] ));
  LUT6 #(
    .INIT(64'hEEEEEEEEEEEEEEEA)) 
    \iir[2]_i_2 
       (.I0(\iir[2]_i_4_n_0 ),
        .I1(\ier_reg[2]_0 [2]),
        .I2(\lsr_reg[1] ),
        .I3(p_1_in43_in),
        .I4(p_0_in42_in),
        .I5(p_2_in44_in),
        .O(\iir_reg[2] ));
  LUT5 #(
    .INIT(32'h47447777)) 
    \iir[2]_i_3 
       (.I0(\iir_reg[2]_1 ),
        .I1(iir[1]),
        .I2(rd_d_reg),
        .I3(\addr_d_reg[0] ),
        .I4(\iir[2]_i_7_n_0 ),
        .O(\iir[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hD080FFFF)) 
    \iir[2]_i_4 
       (.I0(\GENERATING_FIFOS.fcr_reg[0] ),
        .I1(rx_fifo_trigger),
        .I2(\ier_reg[2]_0 [0]),
        .I3(\lsr_reg[0] ),
        .I4(\iir[3]_i_2_n_0 ),
        .O(\iir[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFBFFFFFBBBFB)) 
    \iir[2]_i_7 
       (.I0(iir[0]),
        .I1(iir[2]),
        .I2(rd_d_reg_0),
        .I3(\GENERATING_FIFOS.fcr_reg[0] ),
        .I4(rx_fifo_trigger),
        .I5(iir[3]),
        .O(\iir[2]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \iir[3]_i_1 
       (.I0(\ier_reg[2] ),
        .I1(\iir[3]_i_2_n_0 ),
        .I2(\iir[2]_i_3_n_0 ),
        .I3(bus2ip_reset_int_core),
        .O(\iir_reg[3] ));
  LUT5 #(
    .INIT(32'hF7FFFFFF)) 
    \iir[3]_i_2 
       (.I0(\ier_reg[2]_0 [0]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(Q),
        .I3(p_1_in),
        .I4(p_0_in_0),
        .O(\iir[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h4744474747474747)) 
    rxrdyN_int_i_1
       (.I0(\lsr_reg[0] ),
        .I1(\GENERATING_FIFOS.fcr_reg[3] ),
        .I2(rx_fifo_trigger),
        .I3(Q),
        .I4(p_1_in),
        .I5(p_0_in_0),
        .O(rxrdyN_int_reg));
  LUT6 #(
    .INIT(64'h00000000AAAA88A8)) 
    thre_iir_set_i_1
       (.I0(\iir_reg[2]_0 ),
        .I1(bus2ip_reset_int_core_reg),
        .I2(p_2_in51_in),
        .I3(thre_iir_set_i_4_n_0),
        .I4(thre_iir_set),
        .I5(writing_thr),
        .O(thre_iir_set_reg));
  LUT6 #(
    .INIT(64'hAAAA880800008808)) 
    thre_iir_set_i_4
       (.I0(lsr5_d),
        .I1(\iir[2]_i_7_n_0 ),
        .I2(\addr_d_reg[0] ),
        .I3(rd_d_reg),
        .I4(iir[1]),
        .I5(\iir_reg[2]_1 ),
        .O(thre_iir_set_i_4_n_0));
endmodule

(* ORIG_REF_NAME = "slave_attachment" *) 
module sensors96b_axi_uart16550_0_0_slave_attachment
   (chipSelect_reg,
    s_axi_rvalid,
    s_axi_bvalid,
    s_axi_rdata,
    \addr_d_reg[2] ,
    bus2ip_rdce_i,
    Wr,
    bus2ip_wrce_i,
    bus2ip_reset_int_core,
    s_axi_arvalid,
    s_axi_aclk,
    s_axi_aresetn,
    IP2Bus_RdAcknowledge_reg,
    IP2Bus_WrAcknowledge_reg,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_bready,
    s_axi_rready,
    s_axi_araddr,
    s_axi_awaddr,
    Q,
    wrReq_d1);
  output chipSelect_reg;
  output s_axi_rvalid;
  output s_axi_bvalid;
  output [7:0]s_axi_rdata;
  output [2:0]\addr_d_reg[2] ;
  output bus2ip_rdce_i;
  output Wr;
  output bus2ip_wrce_i;
  input bus2ip_reset_int_core;
  input s_axi_arvalid;
  input s_axi_aclk;
  input s_axi_aresetn;
  input IP2Bus_RdAcknowledge_reg;
  input IP2Bus_WrAcknowledge_reg;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input s_axi_bready;
  input s_axi_rready;
  input [2:0]s_axi_araddr;
  input [2:0]s_axi_awaddr;
  input [7:0]Q;
  input wrReq_d1;

  wire \FSM_onehot_state[0]_i_1_n_0 ;
  wire \FSM_onehot_state[1]_i_1_n_0 ;
  wire \FSM_onehot_state[2]_i_1_n_0 ;
  wire \FSM_onehot_state[3]_i_1_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[0] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_state_reg_n_0_[1] ;
  wire IP2Bus_RdAcknowledge_reg;
  wire IP2Bus_WrAcknowledge_reg;
  wire [7:0]Q;
  wire Wr;
  wire [2:0]\addr_d_reg[2] ;
  wire \bus2ip_addr_i[2]_i_1_n_0 ;
  wire \bus2ip_addr_i[3]_i_1_n_0 ;
  wire \bus2ip_addr_i[4]_i_1_n_0 ;
  wire \bus2ip_addr_i[4]_i_2_n_0 ;
  wire bus2ip_rdce_i;
  wire bus2ip_reset_int_core;
  wire bus2ip_rnw_i_reg_n_0;
  wire bus2ip_wrce_i;
  wire chipSelect_reg;
  wire s_axi_aclk;
  wire [2:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire [2:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  (* RTL_KEEP = "yes" *) wire s_axi_bresp_i;
  wire s_axi_bvalid;
  wire s_axi_bvalid_i_i_1_n_0;
  wire [7:0]s_axi_rdata;
  wire s_axi_rready;
  (* RTL_KEEP = "yes" *) wire s_axi_rresp_i;
  wire s_axi_rvalid;
  wire s_axi_rvalid_i_i_1_n_0;
  wire s_axi_wvalid;
  wire start2;
  wire start2_i_1_n_0;
  wire state1__2;
  wire wrReq_d1;

  LUT6 #(
    .INIT(64'hFFFF88F888F888F8)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(IP2Bus_WrAcknowledge_reg),
        .I1(s_axi_bresp_i),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(state1__2),
        .I4(s_axi_rresp_i),
        .I5(IP2Bus_RdAcknowledge_reg),
        .O(\FSM_onehot_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h888F8F8F88888888)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(state1__2),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(s_axi_arvalid),
        .I3(s_axi_wvalid),
        .I4(s_axi_awvalid),
        .I5(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\FSM_onehot_state[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \FSM_onehot_state[1]_i_2 
       (.I0(s_axi_bready),
        .I1(s_axi_bvalid),
        .I2(s_axi_rready),
        .I3(s_axi_rvalid),
        .O(state1__2));
  LUT6 #(
    .INIT(64'h0800FFFF08000800)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(s_axi_wvalid),
        .I1(s_axi_awvalid),
        .I2(s_axi_arvalid),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .I4(IP2Bus_WrAcknowledge_reg),
        .I5(s_axi_bresp_i),
        .O(\FSM_onehot_state[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(s_axi_arvalid),
        .I1(\FSM_onehot_state_reg_n_0_[1] ),
        .I2(IP2Bus_RdAcknowledge_reg),
        .I3(s_axi_rresp_i),
        .O(\FSM_onehot_state[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "sm_read:1000,sm_write:0100,sm_resp:0001,sm_idle:0010" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .R(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "sm_read:1000,sm_write:0100,sm_resp:0001,sm_idle:0010" *) 
  (* KEEP = "yes" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[1] ),
        .S(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "sm_read:1000,sm_write:0100,sm_resp:0001,sm_idle:0010" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[2]_i_1_n_0 ),
        .Q(s_axi_bresp_i),
        .R(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "sm_read:1000,sm_write:0100,sm_resp:0001,sm_idle:0010" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[3]_i_1_n_0 ),
        .Q(s_axi_rresp_i),
        .R(bus2ip_reset_int_core));
  sensors96b_axi_uart16550_0_0_address_decoder I_DECODER
       (.IP2Bus_RdAcknowledge_reg(IP2Bus_RdAcknowledge_reg),
        .IP2Bus_WrAcknowledge_reg(IP2Bus_WrAcknowledge_reg),
        .Q(start2),
        .Wr(Wr),
        .bus2ip_rdce_i(bus2ip_rdce_i),
        .bus2ip_rnw_i_reg(bus2ip_rnw_i_reg_n_0),
        .bus2ip_wrce_i(bus2ip_wrce_i),
        .chipSelect_reg(chipSelect_reg),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .wrReq_d1(wrReq_d1));
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[2]_i_1 
       (.I0(s_axi_araddr[0]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[0]),
        .O(\bus2ip_addr_i[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[3]_i_1 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[1]),
        .O(\bus2ip_addr_i[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hEA00)) 
    \bus2ip_addr_i[4]_i_1 
       (.I0(s_axi_arvalid),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .O(\bus2ip_addr_i[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[4]_i_2 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[2]),
        .O(\bus2ip_addr_i[4]_i_2_n_0 ));
  FDRE \bus2ip_addr_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[4]_i_1_n_0 ),
        .D(\bus2ip_addr_i[2]_i_1_n_0 ),
        .Q(\addr_d_reg[2] [0]),
        .R(bus2ip_reset_int_core));
  FDRE \bus2ip_addr_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[4]_i_1_n_0 ),
        .D(\bus2ip_addr_i[3]_i_1_n_0 ),
        .Q(\addr_d_reg[2] [1]),
        .R(bus2ip_reset_int_core));
  FDRE \bus2ip_addr_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[4]_i_1_n_0 ),
        .D(\bus2ip_addr_i[4]_i_2_n_0 ),
        .Q(\addr_d_reg[2] [2]),
        .R(bus2ip_reset_int_core));
  FDRE bus2ip_rnw_i_reg
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[4]_i_1_n_0 ),
        .D(s_axi_arvalid),
        .Q(bus2ip_rnw_i_reg_n_0),
        .R(bus2ip_reset_int_core));
  LUT4 #(
    .INIT(16'h8F88)) 
    s_axi_bvalid_i_i_1
       (.I0(IP2Bus_WrAcknowledge_reg),
        .I1(s_axi_bresp_i),
        .I2(s_axi_bready),
        .I3(s_axi_bvalid),
        .O(s_axi_bvalid_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_axi_bvalid_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_bvalid_i_i_1_n_0),
        .Q(s_axi_bvalid),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[0]),
        .Q(s_axi_rdata[0]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[1]),
        .Q(s_axi_rdata[1]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[2]),
        .Q(s_axi_rdata[2]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[3]),
        .Q(s_axi_rdata[3]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[4]),
        .Q(s_axi_rdata[4]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[5] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[5]),
        .Q(s_axi_rdata[5]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[6] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[6]),
        .Q(s_axi_rdata[6]),
        .R(bus2ip_reset_int_core));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[7] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(Q[7]),
        .Q(s_axi_rdata[7]),
        .R(bus2ip_reset_int_core));
  LUT4 #(
    .INIT(16'h8F88)) 
    s_axi_rvalid_i_i_1
       (.I0(IP2Bus_RdAcknowledge_reg),
        .I1(s_axi_rresp_i),
        .I2(s_axi_rready),
        .I3(s_axi_rvalid),
        .O(s_axi_rvalid_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_axi_rvalid_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_rvalid_i_i_1_n_0),
        .Q(s_axi_rvalid),
        .R(bus2ip_reset_int_core));
  LUT4 #(
    .INIT(16'hF800)) 
    start2_i_1
       (.I0(s_axi_awvalid),
        .I1(s_axi_wvalid),
        .I2(s_axi_arvalid),
        .I3(\FSM_onehot_state_reg_n_0_[1] ),
        .O(start2_i_1_n_0));
  FDRE start2_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(start2_i_1_n_0),
        .Q(start2),
        .R(bus2ip_reset_int_core));
endmodule

(* ORIG_REF_NAME = "srl_fifo_rbu_f" *) 
module sensors96b_axi_uart16550_0_0_srl_fifo_rbu_f
   (Q,
    txrdyN_int_reg,
    out,
    SS,
    s_axi_aclk,
    tx_fifo_rd_en_int,
    \GENERATING_FIFOS.fcr_reg[0] ,
    Tx_fifo_rd_en_reg,
    tx_fifo_wr_en_d,
    txrdyn,
    \GENERATING_FIFOS.fcr_reg[3] ,
    p_2_in51_in,
    \Thr_reg[7] );
  output [0:0]Q;
  output txrdyN_int_reg;
  output [7:0]out;
  input [0:0]SS;
  input s_axi_aclk;
  input tx_fifo_rd_en_int;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input Tx_fifo_rd_en_reg;
  input tx_fifo_wr_en_d;
  input txrdyn;
  input [0:0]\GENERATING_FIFOS.fcr_reg[3] ;
  input p_2_in51_in;
  input [7:0]\Thr_reg[7] ;

  wire CNTR_INCR_DECR_ADDN_F_I_n_2;
  wire CNTR_INCR_DECR_ADDN_F_I_n_3;
  wire CNTR_INCR_DECR_ADDN_F_I_n_4;
  wire CNTR_INCR_DECR_ADDN_F_I_n_5;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire [0:0]\GENERATING_FIFOS.fcr_reg[3] ;
  wire [0:0]Q;
  wire [0:0]SS;
  wire [7:0]\Thr_reg[7] ;
  wire Tx_fifo_rd_en_reg;
  wire fifo_full_p1;
  wire [7:0]out;
  wire p_2_in51_in;
  wire s_axi_aclk;
  wire tx_fifo_full;
  wire tx_fifo_rd_en_int;
  wire tx_fifo_wr_en_d;
  wire tx_fifo_wr_en_i;
  wire txrdyN_int_reg;
  wire txrdyn;

  sensors96b_axi_uart16550_0_0_cntr_incr_decr_addn_f CNTR_INCR_DECR_ADDN_F_I
       (.\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg[0] ),
        .Q({Q,CNTR_INCR_DECR_ADDN_F_I_n_2,CNTR_INCR_DECR_ADDN_F_I_n_3,CNTR_INCR_DECR_ADDN_F_I_n_4,CNTR_INCR_DECR_ADDN_F_I_n_5}),
        .SS(SS),
        .Tx_fifo_rd_en_reg(Tx_fifo_rd_en_reg),
        .fifo_full_p1(fifo_full_p1),
        .s_axi_aclk(s_axi_aclk),
        .tx_fifo_full(tx_fifo_full),
        .tx_fifo_rd_en_int(tx_fifo_rd_en_int),
        .tx_fifo_wr_en_d(tx_fifo_wr_en_d),
        .tx_fifo_wr_en_i(tx_fifo_wr_en_i));
  sensors96b_axi_uart16550_0_0_dynshreg_f DYNSHREG_F_I
       (.Q({CNTR_INCR_DECR_ADDN_F_I_n_2,CNTR_INCR_DECR_ADDN_F_I_n_3,CNTR_INCR_DECR_ADDN_F_I_n_4,CNTR_INCR_DECR_ADDN_F_I_n_5}),
        .\Thr_reg[7] (\Thr_reg[7] ),
        .out(out),
        .s_axi_aclk(s_axi_aclk),
        .tx_fifo_full(tx_fifo_full),
        .tx_fifo_wr_en_d(tx_fifo_wr_en_d),
        .tx_fifo_wr_en_i(tx_fifo_wr_en_i));
  FDRE FIFO_Full_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(fifo_full_p1),
        .Q(tx_fifo_full),
        .R(SS));
  LUT5 #(
    .INIT(32'h2000EFFF)) 
    txrdyN_int_i_1
       (.I0(tx_fifo_full),
        .I1(txrdyn),
        .I2(\GENERATING_FIFOS.fcr_reg[3] ),
        .I3(\GENERATING_FIFOS.fcr_reg[0] ),
        .I4(p_2_in51_in),
        .O(txrdyN_int_reg));
endmodule

(* ORIG_REF_NAME = "srl_fifo_rbu_f" *) 
module sensors96b_axi_uart16550_0_0_srl_fifo_rbu_f__parameterized0
   (rx_fifo_full,
    \lsr_reg[0] ,
    lsr2_rst_reg,
    Rx_fifo_trigger_reg,
    \lsr_reg[0]_0 ,
    \lsr_reg[1] ,
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ,
    D,
    lsr2_set,
    lsr4_set,
    lsr3_set,
    out,
    rx_fifo_rst,
    s_axi_aclk,
    Q,
    lsr_reg0,
    \GENERATING_FIFOS.fcr_reg[0] ,
    character_received,
    \lsr_reg[0]_1 ,
    rd_d_reg,
    chipSelect,
    wr_d,
    rx_fifo_rd_en_d,
    lsr2_rst,
    rx_fifo_wr_en_i,
    chipSelect_reg,
    \addr_d_reg[0] ,
    bus2ip_reset_int_core,
    \lsr_reg[1]_0 ,
    \GENERATING_FIFOS.fcr_reg[7] ,
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ,
    dlab_reg,
    \dll_reg[6] ,
    \addr_d_reg[2] ,
    \lsr_reg[6] ,
    \Lcr_reg[6] ,
    \Lcr_reg[3] ,
    iir,
    \addr_d_reg[2]_0 ,
    L,
    \msr_reg[2] ,
    \addr_d_reg[2]_1 ,
    \ier_reg[3] ,
    \addr_d_reg[1] ,
    \dll_reg[1] ,
    \Rbr_reg[6] ,
    \iir_reg[0] ,
    \ier_reg[0] ,
    dlab_reg_0,
    \addr_d_reg[0]_0 ,
    p_0_in2_in,
    \addr_d_reg[1]_0 ,
    \scr_reg[6] ,
    \iir_reg[7] ,
    \Lcr_reg[3]_0 ,
    in,
    rx_fifo_rd_en_d1);
  output rx_fifo_full;
  output [0:0]\lsr_reg[0] ;
  output lsr2_rst_reg;
  output Rx_fifo_trigger_reg;
  output \lsr_reg[0]_0 ;
  output \lsr_reg[1] ;
  output \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ;
  output [4:0]D;
  output lsr2_set;
  output lsr4_set;
  output lsr3_set;
  output [2:0]out;
  input rx_fifo_rst;
  input s_axi_aclk;
  input [1:0]Q;
  input lsr_reg0;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input character_received;
  input \lsr_reg[0]_1 ;
  input rd_d_reg;
  input chipSelect;
  input wr_d;
  input rx_fifo_rd_en_d;
  input lsr2_rst;
  input rx_fifo_wr_en_i;
  input chipSelect_reg;
  input \addr_d_reg[0] ;
  input bus2ip_reset_int_core;
  input \lsr_reg[1]_0 ;
  input [4:0]\GENERATING_FIFOS.fcr_reg[7] ;
  input \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ;
  input dlab_reg;
  input [0:0]\dll_reg[6] ;
  input \addr_d_reg[2] ;
  input \lsr_reg[6] ;
  input \Lcr_reg[6] ;
  input \Lcr_reg[3] ;
  input [2:0]iir;
  input \addr_d_reg[2]_0 ;
  input [0:0]L;
  input \msr_reg[2] ;
  input \addr_d_reg[2]_1 ;
  input [2:0]\ier_reg[3] ;
  input \addr_d_reg[1] ;
  input \dll_reg[1] ;
  input [4:0]\Rbr_reg[6] ;
  input \iir_reg[0] ;
  input \ier_reg[0] ;
  input dlab_reg_0;
  input \addr_d_reg[0]_0 ;
  input p_0_in2_in;
  input \addr_d_reg[1]_0 ;
  input [0:0]\scr_reg[6] ;
  input \iir_reg[7] ;
  input [0:0]\Lcr_reg[3]_0 ;
  input [0:10]in;
  input rx_fifo_rd_en_d1;

  wire [4:0]D;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire [4:0]\GENERATING_FIFOS.fcr_reg[7] ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ;
  wire [0:0]L;
  wire \Lcr_reg[3] ;
  wire [0:0]\Lcr_reg[3]_0 ;
  wire \Lcr_reg[6] ;
  wire [1:0]Q;
  wire [4:0]\Rbr_reg[6] ;
  wire Rx_fifo_trigger_reg;
  wire \addr_d_reg[0] ;
  wire \addr_d_reg[0]_0 ;
  wire \addr_d_reg[1] ;
  wire \addr_d_reg[1]_0 ;
  wire \addr_d_reg[2] ;
  wire \addr_d_reg[2]_0 ;
  wire \addr_d_reg[2]_1 ;
  wire bus2ip_reset_int_core;
  wire character_received;
  wire chipSelect;
  wire chipSelect_reg;
  wire dlab_reg;
  wire dlab_reg_0;
  wire \dll_reg[1] ;
  wire [0:0]\dll_reg[6] ;
  wire fifo_full_p1;
  wire \ier_reg[0] ;
  wire [2:0]\ier_reg[3] ;
  wire [2:0]iir;
  wire \iir_reg[0] ;
  wire \iir_reg[7] ;
  wire [0:10]in;
  wire lsr1_set;
  wire lsr2_rst;
  wire lsr2_rst_reg;
  wire lsr2_set;
  wire lsr3_set;
  wire lsr4_set;
  wire lsr_reg0;
  wire [0:0]\lsr_reg[0] ;
  wire \lsr_reg[0]_0 ;
  wire \lsr_reg[0]_1 ;
  wire \lsr_reg[1] ;
  wire \lsr_reg[1]_0 ;
  wire \lsr_reg[6] ;
  wire \msr_reg[2] ;
  wire [2:0]out;
  wire p_0_in2_in;
  wire rd_d_reg;
  wire [3:0]rx_fifo_count;
  wire [10:8]rx_fifo_data_out;
  wire rx_fifo_full;
  wire rx_fifo_rd_en_d;
  wire rx_fifo_rd_en_d1;
  wire rx_fifo_rst;
  wire rx_fifo_wr_en_i;
  wire s_axi_aclk;
  wire [0:0]\scr_reg[6] ;
  wire wr_d;

  sensors96b_axi_uart16550_0_0_cntr_incr_decr_addn_f_0 CNTR_INCR_DECR_ADDN_F_I
       (.\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg[0] ),
        .\GENERATING_FIFOS.fcr_reg[7] (\GENERATING_FIFOS.fcr_reg[7] [4:3]),
        .\Lcr_reg[3] (\Lcr_reg[3]_0 ),
        .Q(Q[0]),
        .Rx_fifo_trigger_reg(Rx_fifo_trigger_reg),
        .\addr_d_reg[0] (\addr_d_reg[0] ),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .character_received(character_received),
        .chipSelect(chipSelect),
        .chipSelect_reg(chipSelect_reg),
        .fifo_full_p1(fifo_full_p1),
        .in({in[0],in[1],in[2]}),
        .lsr2_rst(lsr2_rst),
        .lsr2_rst_reg(lsr2_rst_reg),
        .lsr2_set(lsr2_set),
        .lsr3_set(lsr3_set),
        .lsr4_set(lsr4_set),
        .lsr_reg0(lsr_reg0),
        .\lsr_reg[0] ({\lsr_reg[0] ,rx_fifo_count}),
        .\lsr_reg[0]_0 (\lsr_reg[0]_0 ),
        .\lsr_reg[0]_1 (\lsr_reg[0]_1 ),
        .out(rx_fifo_data_out),
        .rd_d_reg(rd_d_reg),
        .rx_fifo_rd_en_d(rx_fifo_rd_en_d),
        .rx_fifo_rd_en_d1(rx_fifo_rd_en_d1),
        .rx_fifo_rst(rx_fifo_rst),
        .rx_fifo_wr_en_i(rx_fifo_wr_en_i),
        .s_axi_aclk(s_axi_aclk),
        .wr_d(wr_d));
  sensors96b_axi_uart16550_0_0_dynshreg_f__parameterized0 DYNSHREG_F_I
       (.D(D),
        .\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg[0] ),
        .\GENERATING_FIFOS.fcr_reg[6] (\GENERATING_FIFOS.fcr_reg[7] [3:0]),
        .\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg (\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg ),
        .\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] (\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] ),
        .\INFERRED_GEN.cnt_i_reg[3] (rx_fifo_count),
        .L(L),
        .\Lcr_reg[3] (\Lcr_reg[3] ),
        .\Lcr_reg[6] (\Lcr_reg[6] ),
        .\Rbr_reg[6] (\Rbr_reg[6] ),
        .\addr_d_reg[0] (\addr_d_reg[0] ),
        .\addr_d_reg[0]_0 (\addr_d_reg[0]_0 ),
        .\addr_d_reg[1] (\addr_d_reg[1] ),
        .\addr_d_reg[1]_0 (\addr_d_reg[1]_0 ),
        .\addr_d_reg[2] (\addr_d_reg[2] ),
        .\addr_d_reg[2]_0 (\addr_d_reg[2]_0 ),
        .\addr_d_reg[2]_1 (\addr_d_reg[2]_1 ),
        .dlab_reg(dlab_reg),
        .dlab_reg_0(dlab_reg_0),
        .\dll_reg[1] (\dll_reg[1] ),
        .\dll_reg[6] (\dll_reg[6] ),
        .\ier_reg[0] (\ier_reg[0] ),
        .\ier_reg[3] (\ier_reg[3] ),
        .iir(iir),
        .\iir_reg[0] (\iir_reg[0] ),
        .\iir_reg[7] (\iir_reg[7] ),
        .in(in),
        .\lsr_reg[6] (\lsr_reg[6] ),
        .\msr_reg[2] (\msr_reg[2] ),
        .out({rx_fifo_data_out,out}),
        .p_0_in2_in(p_0_in2_in),
        .rd_d_reg(rd_d_reg),
        .rx_fifo_rd_en_d(rx_fifo_rd_en_d),
        .rx_fifo_wr_en_i(rx_fifo_wr_en_i),
        .s_axi_aclk(s_axi_aclk),
        .\scr_reg[6] (\scr_reg[6] ));
  FDRE FIFO_Full_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(fifo_full_p1),
        .Q(rx_fifo_full),
        .R(rx_fifo_rst));
  LUT6 #(
    .INIT(64'h000000000000FECE)) 
    \lsr[1]_i_1 
       (.I0(\lsr_reg[1]_0 ),
        .I1(lsr1_set),
        .I2(lsr_reg0),
        .I3(Q[1]),
        .I4(rd_d_reg),
        .I5(bus2ip_reset_int_core),
        .O(\lsr_reg[1] ));
  LUT4 #(
    .INIT(16'h8C80)) 
    \lsr[1]_i_2 
       (.I0(rx_fifo_full),
        .I1(character_received),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\lsr_reg[0]_1 ),
        .O(lsr1_set));
endmodule

(* ORIG_REF_NAME = "tx16550" *) 
module sensors96b_axi_uart16550_0_0_tx16550
   (out,
    tx_empty,
    tx_fifo_rd_en_int,
    sout,
    \FSM_sequential_transmit_state_reg[3]_0 ,
    \INFERRED_GEN.cnt_i_reg[2] ,
    rx_sin,
    bus2ip_reset_int_core,
    s_axi_aclk,
    p_0_in,
    Q,
    \mcr_reg[4] ,
    \lsr_reg[5] ,
    \tsr_int_reg[0] ,
    \tsr_int_reg[1] ,
    \tsr_int_reg[2] ,
    \tsr_int_reg[3] ,
    \tsr_int_reg[4] ,
    \tsr_int_reg[5] ,
    \tsr_int_reg[6] ,
    \Thr_reg[7] ,
    \GENERATING_FIFOS.fcr_reg[0] ,
    \tsr_int_reg[7] ,
    \INFERRED_GEN.cnt_i_reg[4] ,
    sin,
    freeze);
  output [0:0]out;
  output tx_empty;
  output tx_fifo_rd_en_int;
  output sout;
  output \FSM_sequential_transmit_state_reg[3]_0 ;
  output \INFERRED_GEN.cnt_i_reg[2] ;
  output rx_sin;
  input bus2ip_reset_int_core;
  input s_axi_aclk;
  input p_0_in;
  input [6:0]Q;
  input [0:0]\mcr_reg[4] ;
  input \lsr_reg[5] ;
  input \tsr_int_reg[0] ;
  input \tsr_int_reg[1] ;
  input \tsr_int_reg[2] ;
  input \tsr_int_reg[3] ;
  input \tsr_int_reg[4] ;
  input \tsr_int_reg[5] ;
  input \tsr_int_reg[6] ;
  input [0:0]\Thr_reg[7] ;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input [0:0]\tsr_int_reg[7] ;
  input [0:0]\INFERRED_GEN.cnt_i_reg[4] ;
  input sin;
  input freeze;

  wire \FSM_sequential_transmit_state[0]_i_3_n_0 ;
  wire \FSM_sequential_transmit_state[0]_i_4_n_0 ;
  wire \FSM_sequential_transmit_state[0]_i_5_n_0 ;
  wire \FSM_sequential_transmit_state[0]_i_6_n_0 ;
  wire \FSM_sequential_transmit_state[3]_i_3_n_0 ;
  wire \FSM_sequential_transmit_state[3]_i_5_n_0 ;
  wire \FSM_sequential_transmit_state_reg[3]_0 ;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire \INFERRED_GEN.cnt_i_reg[2] ;
  wire [0:0]\INFERRED_GEN.cnt_i_reg[4] ;
  wire [6:0]Q;
  wire Sout0;
  wire Sout_i_1_n_0;
  wire Sout_i_2_n_0;
  wire Sout_i_3_n_0;
  wire [0:0]\Thr_reg[7] ;
  wire Tx_empty0;
  wire bus2ip_reset_int_core;
  wire clk1x;
  wire clk1x_i_1__0_n_0;
  wire clk2x;
  wire clk2x0;
  wire [2:1]clkdiv;
  wire \clkdiv[0]_i_1__0_n_0 ;
  wire \clkdiv[3]_i_1_n_0 ;
  wire \clkdiv[3]_i_2_n_0 ;
  wire [3:0]clkdiv_reg__0;
  wire freeze;
  wire [6:0]in12;
  wire \lsr_reg[5] ;
  wire [0:0]\mcr_reg[4] ;
  wire [3:0]next_state;
  (* RTL_KEEP = "yes" *) wire [0:0]out;
  wire p_0_in;
  wire rx_sin;
  wire s_axi_aclk;
  wire sin;
  wire sout;
  (* RTL_KEEP = "yes" *) wire [2:0]transmit_state;
  wire transmitting_n;
  wire transmitting_n_com;
  wire \tsr[7]_i_2_n_0 ;
  wire [7:0]tsr_com;
  wire \tsr_int_reg[0] ;
  wire \tsr_int_reg[1] ;
  wire \tsr_int_reg[2] ;
  wire \tsr_int_reg[3] ;
  wire \tsr_int_reg[4] ;
  wire \tsr_int_reg[5] ;
  wire \tsr_int_reg[6] ;
  wire [0:0]\tsr_int_reg[7] ;
  wire \tsr_reg_n_0_[0] ;
  wire tx_empty;
  wire tx_fifo_rd_en_com;
  wire tx_fifo_rd_en_int;
  wire tx_parity;
  wire tx_parity_com;
  wire tx_parity_i_2_n_0;
  wire tx_parity_i_3_n_0;
  wire tx_sout;

  LUT5 #(
    .INIT(32'hFFFF4700)) 
    \FSM_sequential_transmit_state[0]_i_1 
       (.I0(\lsr_reg[5] ),
        .I1(transmit_state[2]),
        .I2(\FSM_sequential_transmit_state[0]_i_3_n_0 ),
        .I3(out),
        .I4(\FSM_sequential_transmit_state[0]_i_4_n_0 ),
        .O(next_state[0]));
  LUT6 #(
    .INIT(64'hFC08FC08FC080C08)) 
    \FSM_sequential_transmit_state[0]_i_3 
       (.I0(\FSM_sequential_transmit_state[0]_i_5_n_0 ),
        .I1(Q[3]),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(\lsr_reg[5] ),
        .I5(Q[2]),
        .O(\FSM_sequential_transmit_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00A3002000A30023)) 
    \FSM_sequential_transmit_state[0]_i_4 
       (.I0(\FSM_sequential_transmit_state[0]_i_6_n_0 ),
        .I1(transmit_state[0]),
        .I2(transmit_state[2]),
        .I3(out),
        .I4(transmit_state[1]),
        .I5(\lsr_reg[5] ),
        .O(\FSM_sequential_transmit_state[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_transmit_state[0]_i_5 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(\FSM_sequential_transmit_state[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h77757F77)) 
    \FSM_sequential_transmit_state[0]_i_6 
       (.I0(transmit_state[1]),
        .I1(transmit_state[0]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[3]),
        .O(\FSM_sequential_transmit_state[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0020777777770400)) 
    \FSM_sequential_transmit_state[1]_i_1 
       (.I0(transmit_state[2]),
        .I1(out),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(transmit_state[1]),
        .I5(transmit_state[0]),
        .O(next_state[1]));
  LUT6 #(
    .INIT(64'h0000880030FFCC00)) 
    \FSM_sequential_transmit_state[2]_i_1 
       (.I0(Q[2]),
        .I1(transmit_state[0]),
        .I2(\FSM_sequential_transmit_state_reg[3]_0 ),
        .I3(transmit_state[1]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(next_state[2]));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_transmit_state[3]_i_1 
       (.I0(clk1x),
        .I1(\FSM_sequential_transmit_state[3]_i_3_n_0 ),
        .O(Sout0));
  LUT6 #(
    .INIT(64'h0000D0D0FF3F0000)) 
    \FSM_sequential_transmit_state[3]_i_2 
       (.I0(\FSM_sequential_transmit_state_reg[3]_0 ),
        .I1(transmit_state[0]),
        .I2(transmit_state[1]),
        .I3(Q[2]),
        .I4(out),
        .I5(transmit_state[2]),
        .O(next_state[3]));
  LUT6 #(
    .INIT(64'h4000000000000000)) 
    \FSM_sequential_transmit_state[3]_i_3 
       (.I0(\FSM_sequential_transmit_state_reg[3]_0 ),
        .I1(Q[2]),
        .I2(clk2x),
        .I3(out),
        .I4(transmit_state[2]),
        .I5(\FSM_sequential_transmit_state[3]_i_5_n_0 ),
        .O(\FSM_sequential_transmit_state[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_transmit_state[3]_i_4 
       (.I0(Q[1]),
        .I1(Q[0]),
        .O(\FSM_sequential_transmit_state_reg[3]_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_transmit_state[3]_i_5 
       (.I0(transmit_state[1]),
        .I1(transmit_state[0]),
        .O(\FSM_sequential_transmit_state[3]_i_5_n_0 ));
  (* FSM_ENCODED_STATES = "data_bit3:0100,data_bit2:0011,data_bit1:0010,stop_bit2:1100,stop_bit1:1011,parity_bit:1010,start_bit:0001,idle:0000,data_bit6:0111,data_bit8:1001,data_bit5:0110,data_bit7:1000,data_bit4:0101" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_transmit_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(next_state[0]),
        .Q(transmit_state[0]),
        .R(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "data_bit3:0100,data_bit2:0011,data_bit1:0010,stop_bit2:1100,stop_bit1:1011,parity_bit:1010,start_bit:0001,idle:0000,data_bit6:0111,data_bit8:1001,data_bit5:0110,data_bit7:1000,data_bit4:0101" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_transmit_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(next_state[1]),
        .Q(transmit_state[1]),
        .R(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "data_bit3:0100,data_bit2:0011,data_bit1:0010,stop_bit2:1100,stop_bit1:1011,parity_bit:1010,start_bit:0001,idle:0000,data_bit6:0111,data_bit8:1001,data_bit5:0110,data_bit7:1000,data_bit4:0101" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_transmit_state_reg[2] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(next_state[2]),
        .Q(transmit_state[2]),
        .R(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "data_bit3:0100,data_bit2:0011,data_bit1:0010,stop_bit2:1100,stop_bit1:1011,parity_bit:1010,start_bit:0001,idle:0000,data_bit6:0111,data_bit8:1001,data_bit5:0110,data_bit7:1000,data_bit4:0101" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_transmit_state_reg[3] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(next_state[3]),
        .Q(out),
        .R(bus2ip_reset_int_core));
  LUT3 #(
    .INIT(8'h08)) 
    \INFERRED_GEN.cnt_i[4]_i_2 
       (.I0(tx_fifo_rd_en_int),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(\INFERRED_GEN.cnt_i_reg[4] ),
        .O(\INFERRED_GEN.cnt_i_reg[2] ));
  LUT2 #(
    .INIT(4'h1)) 
    Sout_i_1
       (.I0(Q[6]),
        .I1(Sout_i_2_n_0),
        .O(Sout_i_1_n_0));
  LUT6 #(
    .INIT(64'hE002EE02E3FEEFFE)) 
    Sout_i_2
       (.I0(transmit_state[0]),
        .I1(transmit_state[1]),
        .I2(transmit_state[2]),
        .I3(out),
        .I4(Sout_i_3_n_0),
        .I5(\tsr_reg_n_0_[0] ),
        .O(Sout_i_2_n_0));
  LUT4 #(
    .INIT(16'hDDFC)) 
    Sout_i_3
       (.I0(Q[4]),
        .I1(transmit_state[0]),
        .I2(tx_parity),
        .I3(Q[5]),
        .O(Sout_i_3_n_0));
  FDSE Sout_reg
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(Sout_i_1_n_0),
        .Q(tx_sout),
        .S(bus2ip_reset_int_core));
  LUT2 #(
    .INIT(4'h8)) 
    Tx_empty_i_1
       (.I0(clk1x),
        .I1(transmitting_n),
        .O(Tx_empty0));
  FDSE Tx_empty_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Tx_empty0),
        .Q(tx_empty),
        .S(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'h00000008)) 
    Tx_fifo_rd_en_i_1
       (.I0(clk1x),
        .I1(transmit_state[0]),
        .I2(transmit_state[1]),
        .I3(out),
        .I4(transmit_state[2]),
        .O(tx_fifo_rd_en_com));
  FDRE Tx_fifo_rd_en_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(tx_fifo_rd_en_com),
        .Q(tx_fifo_rd_en_int),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h00004000)) 
    clk1x_i_1__0
       (.I0(clkdiv_reg__0[3]),
        .I1(clkdiv_reg__0[0]),
        .I2(clkdiv_reg__0[2]),
        .I3(clkdiv_reg__0[1]),
        .I4(p_0_in),
        .O(clk1x_i_1__0_n_0));
  FDRE clk1x_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clk1x_i_1__0_n_0),
        .Q(clk1x),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    clk2x_i_1
       (.I0(clkdiv_reg__0[3]),
        .I1(clkdiv_reg__0[0]),
        .I2(clkdiv_reg__0[2]),
        .I3(clkdiv_reg__0[1]),
        .I4(p_0_in),
        .O(clk2x0));
  FDRE clk2x_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(clk2x0),
        .Q(clk2x),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \clkdiv[0]_i_1__0 
       (.I0(clkdiv_reg__0[0]),
        .I1(\FSM_sequential_transmit_state[3]_i_3_n_0 ),
        .O(\clkdiv[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \clkdiv[1]_i_1 
       (.I0(clkdiv_reg__0[1]),
        .I1(\FSM_sequential_transmit_state[3]_i_3_n_0 ),
        .I2(clkdiv_reg__0[0]),
        .O(clkdiv[1]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hA6AA)) 
    \clkdiv[2]_i_1 
       (.I0(clkdiv_reg__0[2]),
        .I1(clkdiv_reg__0[0]),
        .I2(\FSM_sequential_transmit_state[3]_i_3_n_0 ),
        .I3(clkdiv_reg__0[1]),
        .O(clkdiv[2]));
  LUT2 #(
    .INIT(4'hB)) 
    \clkdiv[3]_i_1 
       (.I0(\FSM_sequential_transmit_state[3]_i_3_n_0 ),
        .I1(p_0_in),
        .O(\clkdiv[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h56666666)) 
    \clkdiv[3]_i_2 
       (.I0(clkdiv_reg__0[3]),
        .I1(\FSM_sequential_transmit_state[3]_i_3_n_0 ),
        .I2(clkdiv_reg__0[0]),
        .I3(clkdiv_reg__0[2]),
        .I4(clkdiv_reg__0[1]),
        .O(\clkdiv[3]_i_2_n_0 ));
  FDRE \clkdiv_reg[0] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_1_n_0 ),
        .D(\clkdiv[0]_i_1__0_n_0 ),
        .Q(clkdiv_reg__0[0]),
        .R(bus2ip_reset_int_core));
  FDRE \clkdiv_reg[1] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_1_n_0 ),
        .D(clkdiv[1]),
        .Q(clkdiv_reg__0[1]),
        .R(bus2ip_reset_int_core));
  FDRE \clkdiv_reg[2] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_1_n_0 ),
        .D(clkdiv[2]),
        .Q(clkdiv_reg__0[2]),
        .R(bus2ip_reset_int_core));
  FDRE \clkdiv_reg[3] 
       (.C(s_axi_aclk),
        .CE(\clkdiv[3]_i_1_n_0 ),
        .D(\clkdiv[3]_i_2_n_0 ),
        .Q(clkdiv_reg__0[3]),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hFFAC)) 
    sin_d1_i_2
       (.I0(tx_sout),
        .I1(sin),
        .I2(\mcr_reg[4] ),
        .I3(freeze),
        .O(rx_sin));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h54)) 
    sout_INST_0
       (.I0(Q[6]),
        .I1(tx_sout),
        .I2(\mcr_reg[4] ),
        .O(sout));
  LUT6 #(
    .INIT(64'h1010000088801111)) 
    transmitting_n_i_1
       (.I0(transmit_state[0]),
        .I1(transmit_state[1]),
        .I2(\lsr_reg[5] ),
        .I3(Q[2]),
        .I4(out),
        .I5(transmit_state[2]),
        .O(transmitting_n_com));
  FDRE transmitting_n_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(transmitting_n_com),
        .Q(transmitting_n),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[0]_i_1 
       (.I0(in12[0]),
        .I1(\tsr_int_reg[0] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[0]));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[1]_i_1 
       (.I0(in12[1]),
        .I1(\tsr_int_reg[1] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[1]));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[2]_i_1 
       (.I0(in12[2]),
        .I1(\tsr_int_reg[2] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[2]));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[3]_i_1 
       (.I0(in12[3]),
        .I1(\tsr_int_reg[3] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[3]));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[4]_i_1 
       (.I0(in12[4]),
        .I1(\tsr_int_reg[4] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[4]));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[5]_i_1 
       (.I0(in12[5]),
        .I1(\tsr_int_reg[5] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[5]));
  LUT6 #(
    .INIT(64'hCCCFFAFAAAAAACAF)) 
    \tsr[6]_i_1 
       (.I0(in12[6]),
        .I1(\tsr_int_reg[6] ),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .I4(transmit_state[2]),
        .I5(out),
        .O(tsr_com[6]));
  LUT5 #(
    .INIT(32'h5555DFD5)) 
    \tsr[7]_i_1 
       (.I0(\tsr[7]_i_2_n_0 ),
        .I1(\Thr_reg[7] ),
        .I2(\GENERATING_FIFOS.fcr_reg[0] ),
        .I3(\tsr_int_reg[7] ),
        .I4(out),
        .O(tsr_com[7]));
  LUT4 #(
    .INIT(16'hE004)) 
    \tsr[7]_i_2 
       (.I0(transmit_state[1]),
        .I1(transmit_state[0]),
        .I2(transmit_state[2]),
        .I3(out),
        .O(\tsr[7]_i_2_n_0 ));
  FDSE \tsr_reg[0] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[0]),
        .Q(\tsr_reg_n_0_[0] ),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[1] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[1]),
        .Q(in12[0]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[2] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[2]),
        .Q(in12[1]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[3] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[3]),
        .Q(in12[2]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[4] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[4]),
        .Q(in12[3]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[5] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[5]),
        .Q(in12[4]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[6] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[6]),
        .Q(in12[5]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_reg[7] 
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tsr_com[7]),
        .Q(in12[6]),
        .S(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'h111F1F11)) 
    tx_parity_i_1
       (.I0(tx_parity_i_2_n_0),
        .I1(Q[4]),
        .I2(tx_parity_i_3_n_0),
        .I3(\tsr_reg_n_0_[0] ),
        .I4(tx_parity),
        .O(tx_parity_com));
  LUT4 #(
    .INIT(16'hFEFF)) 
    tx_parity_i_2
       (.I0(transmit_state[2]),
        .I1(out),
        .I2(transmit_state[1]),
        .I3(transmit_state[0]),
        .O(tx_parity_i_2_n_0));
  LUT3 #(
    .INIT(8'hA9)) 
    tx_parity_i_3
       (.I0(out),
        .I1(transmit_state[2]),
        .I2(transmit_state[1]),
        .O(tx_parity_i_3_n_0));
  FDRE tx_parity_reg
       (.C(s_axi_aclk),
        .CE(Sout0),
        .D(tx_parity_com),
        .Q(tx_parity),
        .R(bus2ip_reset_int_core));
endmodule

(* ORIG_REF_NAME = "tx_fifo_block" *) 
module sensors96b_axi_uart16550_0_0_tx_fifo_block
   (Q,
    txrdyN_int_reg,
    out,
    SS,
    s_axi_aclk,
    tx_fifo_rd_en_int,
    \GENERATING_FIFOS.fcr_reg[0] ,
    Tx_fifo_rd_en_reg,
    tx_fifo_wr_en_d,
    txrdyn,
    \GENERATING_FIFOS.fcr_reg[3] ,
    p_2_in51_in,
    \Thr_reg[7] );
  output [0:0]Q;
  output txrdyN_int_reg;
  output [7:0]out;
  input [0:0]SS;
  input s_axi_aclk;
  input tx_fifo_rd_en_int;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input Tx_fifo_rd_en_reg;
  input tx_fifo_wr_en_d;
  input txrdyn;
  input [0:0]\GENERATING_FIFOS.fcr_reg[3] ;
  input p_2_in51_in;
  input [7:0]\Thr_reg[7] ;

  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire [0:0]\GENERATING_FIFOS.fcr_reg[3] ;
  wire [0:0]Q;
  wire [0:0]SS;
  wire [7:0]\Thr_reg[7] ;
  wire Tx_fifo_rd_en_reg;
  wire [7:0]out;
  wire p_2_in51_in;
  wire s_axi_aclk;
  wire tx_fifo_rd_en_int;
  wire tx_fifo_wr_en_d;
  wire txrdyN_int_reg;
  wire txrdyn;

  sensors96b_axi_uart16550_0_0_srl_fifo_rbu_f srl_fifo_rbu_f_i1
       (.\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg[0] ),
        .\GENERATING_FIFOS.fcr_reg[3] (\GENERATING_FIFOS.fcr_reg[3] ),
        .Q(Q),
        .SS(SS),
        .\Thr_reg[7] (\Thr_reg[7] ),
        .Tx_fifo_rd_en_reg(Tx_fifo_rd_en_reg),
        .out(out),
        .p_2_in51_in(p_2_in51_in),
        .s_axi_aclk(s_axi_aclk),
        .tx_fifo_rd_en_int(tx_fifo_rd_en_int),
        .tx_fifo_wr_en_d(tx_fifo_wr_en_d),
        .txrdyN_int_reg(txrdyN_int_reg),
        .txrdyn(txrdyn));
endmodule

(* ORIG_REF_NAME = "uart16550" *) 
module sensors96b_axi_uart16550_0_0_uart16550
   (baudoutn,
    ip2intc_irpt,
    ddis,
    txrdyn,
    rxrdyn,
    sout,
    Q,
    rtsn,
    dtrn,
    out1n,
    out2n,
    s_axi_aclk,
    bus2ip_reset_int_core,
    Rd,
    Wr,
    ctsn,
    dsrn,
    rin,
    dcdn,
    ce_out_i,
    s_axi_wdata,
    \bus2ip_addr_i_reg[4] ,
    freeze,
    sin);
  output baudoutn;
  output ip2intc_irpt;
  output ddis;
  output txrdyn;
  output rxrdyn;
  output sout;
  output [7:0]Q;
  output rtsn;
  output dtrn;
  output out1n;
  output out2n;
  input s_axi_aclk;
  input bus2ip_reset_int_core;
  input Rd;
  input Wr;
  input ctsn;
  input dsrn;
  input rin;
  input dcdn;
  input ce_out_i;
  input [7:0]s_axi_wdata;
  input [2:0]\bus2ip_addr_i_reg[4] ;
  input freeze;
  input sin;

  wire D2;
  wire Ddis_i_1_n_0;
  wire \Dout[0]_i_2_n_0 ;
  wire \Dout[0]_i_3_n_0 ;
  wire \Dout[0]_i_4_n_0 ;
  wire \Dout[0]_i_5_n_0 ;
  wire \Dout[0]_i_6_n_0 ;
  wire \Dout[1]_i_2_n_0 ;
  wire \Dout[1]_i_4_n_0 ;
  wire \Dout[1]_i_5_n_0 ;
  wire \Dout[2]_i_2_n_0 ;
  wire \Dout[2]_i_4_n_0 ;
  wire \Dout[2]_i_5_n_0 ;
  wire \Dout[2]_i_6_n_0 ;
  wire \Dout[2]_i_7_n_0 ;
  wire \Dout[2]_i_8_n_0 ;
  wire \Dout[2]_i_9_n_0 ;
  wire \Dout[3]_i_2_n_0 ;
  wire \Dout[3]_i_4_n_0 ;
  wire \Dout[3]_i_5_n_0 ;
  wire \Dout[3]_i_6_n_0 ;
  wire \Dout[4]_i_2_n_0 ;
  wire \Dout[4]_i_3_n_0 ;
  wire \Dout[4]_i_4_n_0 ;
  wire \Dout[4]_i_5_n_0 ;
  wire \Dout[5]_i_2_n_0 ;
  wire \Dout[5]_i_3_n_0 ;
  wire \Dout[5]_i_4_n_0 ;
  wire \Dout[5]_i_5_n_0 ;
  wire \Dout[6]_i_2_n_0 ;
  wire \Dout[6]_i_3_n_0 ;
  wire \Dout[6]_i_5_n_0 ;
  wire \Dout[7]_i_3_n_0 ;
  wire \Dout[7]_i_4_n_0 ;
  wire \Dout[7]_i_5_n_0 ;
  wire \Dout[7]_i_7_n_0 ;
  wire \Dout[7]_i_8_n_0 ;
  wire \GENERATING_FIFOS.fcr[0]_i_1_n_0 ;
  wire \GENERATING_FIFOS.fcr[2]_i_1_n_0 ;
  wire \GENERATING_FIFOS.fcr[2]_i_2_n_0 ;
  wire \GENERATING_FIFOS.fcr[7]_i_1_n_0 ;
  wire \GENERATING_FIFOS.fcr_0_prev_i_1_n_0 ;
  wire \GENERATING_FIFOS.fcr_reg_n_0_[0] ;
  wire \GENERATING_FIFOS.fcr_reg_n_0_[1] ;
  wire \GENERATING_FIFOS.fcr_reg_n_0_[3] ;
  wire \GENERATING_FIFOS.fcr_reg_n_0_[6] ;
  wire \GENERATING_FIFOS.fcr_reg_n_0_[7] ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt[0]_i_1_n_0 ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt[1]_i_1_n_0 ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt[2]_i_1_n_0 ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2_n_0 ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_3_n_0 ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_2_n_0 ;
  wire \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_3_n_0 ;
  wire [3:0]\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_13 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_14 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_15 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_16 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_17 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_18 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_19 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_20 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_21 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_3 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_4 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_5 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_6 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_7 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_8 ;
  wire \GENERATING_FIFOS.rx_fifo_block_1_n_9 ;
  wire \GENERATING_FIFOS.rx_fifo_rst_i_1_n_0 ;
  wire \GENERATING_FIFOS.tx_fifo_block_1_n_1 ;
  wire \GENERATING_FIFOS.tx_fifo_wr_en_d_i_1_n_0 ;
  wire Intr0;
  wire [0:3]L;
  wire Lcr0;
  wire \Lcr_reg_n_0_[0] ;
  wire \Lcr_reg_n_0_[1] ;
  wire \Lcr_reg_n_0_[2] ;
  wire \Lcr_reg_n_0_[4] ;
  wire \Lcr_reg_n_0_[5] ;
  wire \Lcr_reg_n_0_[6] ;
  wire \Lcr_reg_n_0_[7] ;
  wire [7:0]Q;
  wire [6:0]Rbr;
  wire Rd;
  wire Rx_error_in_fifo;
  wire [7:0]Thr;
  wire Thr0;
  wire Wr;
  wire [15:0]baudCounter;
  wire baudCounter1;
  wire \baudCounter[0]_i_1_n_0 ;
  wire \baudCounter[10]_i_1_n_0 ;
  wire \baudCounter[11]_i_1_n_0 ;
  wire \baudCounter[11]_i_2_n_0 ;
  wire \baudCounter[12]_i_1_n_0 ;
  wire \baudCounter[12]_i_2_n_0 ;
  wire \baudCounter[13]_i_1_n_0 ;
  wire \baudCounter[13]_i_2_n_0 ;
  wire \baudCounter[14]_i_1_n_0 ;
  wire \baudCounter[15]_i_1_n_0 ;
  wire \baudCounter[15]_i_2_n_0 ;
  wire \baudCounter[15]_i_3_n_0 ;
  wire \baudCounter[1]_i_1_n_0 ;
  wire \baudCounter[2]_i_1_n_0 ;
  wire \baudCounter[3]_i_1_n_0 ;
  wire \baudCounter[4]_i_1_n_0 ;
  wire \baudCounter[5]_i_1_n_0 ;
  wire \baudCounter[6]_i_1_n_0 ;
  wire \baudCounter[6]_i_2_n_0 ;
  wire \baudCounter[7]_i_1_n_0 ;
  wire \baudCounter[7]_i_2_n_0 ;
  wire \baudCounter[8]_i_1_n_0 ;
  wire \baudCounter[8]_i_2_n_0 ;
  wire \baudCounter[8]_i_3_n_0 ;
  wire \baudCounter[9]_i_1_n_0 ;
  wire baud_counter_loaded;
  wire baudoutN_int_i;
  wire baudoutN_int_i_i_1_n_0;
  wire baudoutN_int_i_i_2_n_0;
  wire baudoutN_int_i_i_3_n_0;
  wire baudoutN_int_i_i_4_n_0;
  wire baudoutn;
  wire [2:0]\bus2ip_addr_i_reg[4] ;
  wire bus2ip_reset_int_core;
  wire ce_out_i;
  wire character_received;
  wire chipSelect;
  wire [15:0]clockDiv;
  wire ctsN_d;
  wire ctsn;
  wire \d_d_reg_n_0_[0] ;
  wire \d_d_reg_n_0_[1] ;
  wire \d_d_reg_n_0_[2] ;
  wire \d_d_reg_n_0_[3] ;
  wire \d_d_reg_n_0_[5] ;
  wire dcdN_d;
  wire dcdn;
  wire ddis;
  wire divisor_latch_loaded;
  wire divisor_latch_loaded_i_1_n_0;
  wire dlab_i_1_n_0;
  wire dll0;
  wire dlm0;
  wire dsrN_d;
  wire dsrn;
  wire dtrn;
  wire fcr_0_prev;
  wire freeze;
  wire [3:0]ier;
  wire ier1;
  wire ier1_d;
  wire [3:0]iir;
  wire \iir[0]_i_3_n_0 ;
  wire \iir[1]_i_2_n_0 ;
  wire \iir[2]_i_5_n_0 ;
  wire \iir[2]_i_6_n_0 ;
  wire \iir[2]_i_8_n_0 ;
  wire \iir_reg_n_0_[7] ;
  wire ip2intc_irpt;
  wire load_baudlower;
  wire load_baudupper;
  wire lsr2_rst;
  wire lsr2_set;
  wire lsr3_set;
  wire lsr4_set;
  wire lsr5_d;
  wire \lsr[2]_i_2_n_0 ;
  wire \lsr[2]_i_3_n_0 ;
  wire \lsr[3]_i_1_n_0 ;
  wire \lsr[4]_i_1_n_0 ;
  wire \lsr[7]_i_1_n_0 ;
  wire \lsr[7]_i_2_n_0 ;
  wire lsr_reg0;
  wire lsr_reg019_out;
  wire \lsr_reg_n_0_[0] ;
  wire \lsr_reg_n_0_[1] ;
  wire \lsr_reg_n_0_[6] ;
  wire \lsr_reg_n_0_[7] ;
  wire mcr0;
  wire mcr4_d;
  wire \mcr_reg_n_0_[0] ;
  wire \mcr_reg_n_0_[2] ;
  wire \mcr_reg_n_0_[3] ;
  wire \modem_prev_val[0]_i_1_n_0 ;
  wire \modem_prev_val[1]_i_1_n_0 ;
  wire \modem_prev_val[2]_i_1_n_0 ;
  wire \modem_prev_val[3]_i_1_n_0 ;
  wire \modem_prev_val_reg_n_0_[0] ;
  wire \modem_prev_val_reg_n_0_[1] ;
  wire msr1;
  wire \msr[0]_i_2_n_0 ;
  wire \msr[1]_i_1_n_0 ;
  wire \msr[2]_i_1_n_0 ;
  wire \msr[3]_i_1_n_0 ;
  wire \msr[4]_i_1_n_0 ;
  wire \msr[5]_i_1_n_0 ;
  wire \msr[6]_i_1_n_0 ;
  wire \msr[7]_i_1_n_0 ;
  wire msr_reg0;
  wire \msr_reg_n_0_[0] ;
  wire \msr_reg_n_0_[4] ;
  wire out1n;
  wire out2n;
  wire p_0_in;
  wire p_0_in0_in;
  wire p_0_in2_in;
  wire p_0_in37_in;
  wire p_0_in38_in;
  wire p_0_in39_in;
  wire p_0_in42_in;
  wire p_0_in4_in;
  wire p_0_in5_in;
  wire p_0_in8_in;
  wire p_0_in_0;
  wire p_14_out;
  wire p_1_in3_in;
  wire p_1_in43_in;
  wire p_1_in6_in;
  wire p_1_out;
  wire [6:5]p_2_in;
  wire p_2_in44_in;
  wire p_2_in51_in;
  wire p_3_in;
  wire p_5_in36_in;
  wire p_5_out;
  wire p_92_in;
  wire rd_d;
  wire riN_d;
  wire rin;
  wire rtsn;
  wire rx16550_1_n_13;
  wire rx16550_1_n_14;
  wire rx16550_1_n_15;
  wire rx16550_1_n_16;
  wire rx16550_1_n_20;
  wire rx16550_1_n_21;
  wire rx16550_1_n_22;
  wire rx_error_in_fifo_cnt_dn;
  wire rx_error_in_fifo_cnt_up;
  wire \rx_fifo_control_1/Rx_error_in_fifo0 ;
  wire \rx_fifo_control_1/character_counter_rst ;
  wire [10:0]rx_fifo_data_in;
  wire [7:4]rx_fifo_data_out;
  wire rx_fifo_empty;
  wire rx_fifo_full;
  wire rx_fifo_rd_en;
  wire rx_fifo_rd_en_d;
  wire rx_fifo_rd_en_d1;
  wire rx_fifo_rst;
  wire rx_fifo_wr_en_i;
  wire rx_sin;
  wire rxrdyN_int_i_2_n_0;
  wire rxrdyn;
  wire s_axi_aclk;
  wire [7:0]s_axi_wdata;
  wire [7:0]scr;
  wire scr0;
  wire sin;
  wire sout;
  wire thre_iir_set;
  wire thre_iir_set_i_2_n_0;
  wire thre_iir_set_i_3_n_0;
  wire [7:7]tsr_int;
  wire tx16550_1_n_0;
  wire tx16550_1_n_4;
  wire tx16550_1_n_5;
  wire tx_empty;
  wire [7:0]tx_fifo_data_out;
  wire tx_fifo_empty;
  wire tx_fifo_rd_en_int;
  wire tx_fifo_rst;
  wire tx_fifo_wr_en_d;
  wire txrdyn;
  wire wr_d;
  wire writing_thr;
  wire xuart_tx_load_sm_1_n_0;
  wire xuart_tx_load_sm_1_n_1;
  wire xuart_tx_load_sm_1_n_10;
  wire xuart_tx_load_sm_1_n_2;
  wire xuart_tx_load_sm_1_n_4;
  wire xuart_tx_load_sm_1_n_5;
  wire xuart_tx_load_sm_1_n_6;
  wire xuart_tx_load_sm_1_n_7;
  wire xuart_tx_load_sm_1_n_8;
  wire xuart_tx_load_sm_1_n_9;
  wire \NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_CLKDIV_UNCONNECTED ;
  wire \NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_T_OUT_UNCONNECTED ;
  wire [7:1]\NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_D_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h7)) 
    Ddis_i_1
       (.I0(chipSelect),
        .I1(rd_d),
        .O(Ddis_i_1_n_0));
  FDRE Ddis_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Ddis_i_1_n_0),
        .Q(ddis),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF00CA)) 
    \Dout[0]_i_2 
       (.I0(iir[0]),
        .I1(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .I2(L[0]),
        .I3(\Dout[3]_i_4_n_0 ),
        .I4(\Dout[0]_i_4_n_0 ),
        .I5(\Dout[0]_i_5_n_0 ),
        .O(\Dout[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \Dout[0]_i_3 
       (.I0(ier[0]),
        .I1(L[3]),
        .I2(L[0]),
        .I3(L[2]),
        .I4(L[1]),
        .O(\Dout[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \Dout[0]_i_4 
       (.I0(\Dout[6]_i_2_n_0 ),
        .I1(clockDiv[0]),
        .I2(\mcr_reg_n_0_[0] ),
        .I3(\Dout[2]_i_9_n_0 ),
        .I4(\Lcr_reg_n_0_[0] ),
        .I5(\Dout[7]_i_4_n_0 ),
        .O(\Dout[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFC8000800)) 
    \Dout[0]_i_5 
       (.I0(\lsr_reg_n_0_[0] ),
        .I1(L[3]),
        .I2(L[2]),
        .I3(L[1]),
        .I4(scr[0]),
        .I5(\Dout[0]_i_6_n_0 ),
        .O(\Dout[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h20200C0020200000)) 
    \Dout[0]_i_6 
       (.I0(\msr_reg_n_0_[0] ),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[0]),
        .I4(L[2]),
        .I5(clockDiv[8]),
        .O(\Dout[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hEFEEFFFFEFEEEFEE)) 
    \Dout[1]_i_2 
       (.I0(\Dout[1]_i_4_n_0 ),
        .I1(\Dout[1]_i_5_n_0 ),
        .I2(\Dout[6]_i_2_n_0 ),
        .I3(clockDiv[1]),
        .I4(\lsr[2]_i_3_n_0 ),
        .I5(\lsr_reg_n_0_[1] ),
        .O(\Dout[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF44F444F444F4)) 
    \Dout[1]_i_4 
       (.I0(\Dout[2]_i_9_n_0 ),
        .I1(p_0_in_0),
        .I2(clockDiv[9]),
        .I3(\Dout[4]_i_4_n_0 ),
        .I4(p_0_in37_in),
        .I5(\Dout[7]_i_3_n_0 ),
        .O(\Dout[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h8C008000)) 
    \Dout[1]_i_5 
       (.I0(scr[1]),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[2]),
        .I4(\Lcr_reg_n_0_[1] ),
        .O(\Dout[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFEEEFFFFFEEEFEEE)) 
    \Dout[2]_i_2 
       (.I0(\Dout[2]_i_6_n_0 ),
        .I1(\Dout[2]_i_7_n_0 ),
        .I2(\Dout[7]_i_3_n_0 ),
        .I3(p_0_in38_in),
        .I4(\Dout[4]_i_4_n_0 ),
        .I5(clockDiv[10]),
        .O(\Dout[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    \Dout[2]_i_4 
       (.I0(L[1]),
        .I1(L[2]),
        .I2(L[0]),
        .I3(L[3]),
        .O(\Dout[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'hFDFF)) 
    \Dout[2]_i_5 
       (.I0(L[2]),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[0]),
        .O(\Dout[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \Dout[2]_i_6 
       (.I0(\Dout[6]_i_2_n_0 ),
        .I1(clockDiv[2]),
        .I2(\mcr_reg_n_0_[2] ),
        .I3(\Dout[2]_i_9_n_0 ),
        .I4(p_0_in42_in),
        .I5(\lsr[2]_i_3_n_0 ),
        .O(\Dout[2]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'h8C008000)) 
    \Dout[2]_i_7 
       (.I0(scr[2]),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[2]),
        .I4(\Lcr_reg_n_0_[2] ),
        .O(\Dout[2]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'hFFFB)) 
    \Dout[2]_i_8 
       (.I0(L[0]),
        .I1(L[2]),
        .I2(L[3]),
        .I3(L[1]),
        .O(\Dout[2]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \Dout[2]_i_9 
       (.I0(L[3]),
        .I1(L[1]),
        .I2(L[2]),
        .O(\Dout[2]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hEFEEFFFFEFEEEFEE)) 
    \Dout[3]_i_2 
       (.I0(\Dout[3]_i_5_n_0 ),
        .I1(\Dout[3]_i_6_n_0 ),
        .I2(\Dout[7]_i_4_n_0 ),
        .I3(p_5_in36_in),
        .I4(\Dout[6]_i_2_n_0 ),
        .I5(clockDiv[3]),
        .O(\Dout[3]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hEF)) 
    \Dout[3]_i_4 
       (.I0(L[1]),
        .I1(L[3]),
        .I2(L[2]),
        .O(\Dout[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hF0A0C00000A0C000)) 
    \Dout[3]_i_5 
       (.I0(p_1_in43_in),
        .I1(p_0_in39_in),
        .I2(L[1]),
        .I3(L[2]),
        .I4(L[3]),
        .I5(scr[3]),
        .O(\Dout[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h00000F8000000080)) 
    \Dout[3]_i_6 
       (.I0(L[0]),
        .I1(clockDiv[11]),
        .I2(L[3]),
        .I3(L[1]),
        .I4(L[2]),
        .I5(\mcr_reg_n_0_[3] ),
        .O(\Dout[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h22F2FFFF22F222F2)) 
    \Dout[4]_i_2 
       (.I0(clockDiv[12]),
        .I1(\Dout[4]_i_4_n_0 ),
        .I2(\Lcr_reg_n_0_[4] ),
        .I3(\Dout[7]_i_4_n_0 ),
        .I4(\lsr[2]_i_3_n_0 ),
        .I5(p_2_in44_in),
        .O(\Dout[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFC0200020)) 
    \Dout[4]_i_3 
       (.I0(p_0_in8_in),
        .I1(L[2]),
        .I2(L[1]),
        .I3(L[3]),
        .I4(scr[4]),
        .I5(\Dout[4]_i_5_n_0 ),
        .O(\Dout[4]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'hFFDF)) 
    \Dout[4]_i_4 
       (.I0(L[3]),
        .I1(L[1]),
        .I2(L[0]),
        .I3(L[2]),
        .O(\Dout[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000A00C0000A000)) 
    \Dout[4]_i_5 
       (.I0(\msr_reg_n_0_[4] ),
        .I1(L[0]),
        .I2(L[2]),
        .I3(L[1]),
        .I4(L[3]),
        .I5(clockDiv[4]),
        .O(\Dout[4]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFEAAAAAAAEAAAAA)) 
    \Dout[5]_i_2 
       (.I0(\Dout[5]_i_5_n_0 ),
        .I1(\Lcr_reg_n_0_[5] ),
        .I2(L[2]),
        .I3(L[1]),
        .I4(L[3]),
        .I5(p_2_in51_in),
        .O(\Dout[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT5 #(
    .INIT(32'hB0008000)) 
    \Dout[5]_i_3 
       (.I0(scr[5]),
        .I1(L[3]),
        .I2(L[2]),
        .I3(L[1]),
        .I4(p_0_in0_in),
        .O(\Dout[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \Dout[5]_i_4 
       (.I0(L[3]),
        .I1(L[1]),
        .I2(L[2]),
        .I3(L[0]),
        .O(\Dout[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000E0000000200)) 
    \Dout[5]_i_5 
       (.I0(clockDiv[5]),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[0]),
        .I4(L[2]),
        .I5(clockDiv[13]),
        .O(\Dout[5]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    \Dout[6]_i_2 
       (.I0(L[0]),
        .I1(L[2]),
        .I2(L[1]),
        .I3(L[3]),
        .O(\Dout[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h08080C0008080000)) 
    \Dout[6]_i_3 
       (.I0(\Lcr_reg_n_0_[6] ),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[0]),
        .I4(L[2]),
        .I5(clockDiv[14]),
        .O(\Dout[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \Dout[6]_i_5 
       (.I0(L[2]),
        .I1(L[1]),
        .I2(L[3]),
        .O(\Dout[6]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \Dout[7]_i_1 
       (.I0(rd_d),
        .I1(chipSelect),
        .O(p_92_in));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \Dout[7]_i_3 
       (.I0(L[3]),
        .I1(L[2]),
        .I2(L[1]),
        .O(\Dout[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \Dout[7]_i_4 
       (.I0(L[3]),
        .I1(L[1]),
        .I2(L[2]),
        .O(\Dout[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00008C8000008080)) 
    \Dout[7]_i_5 
       (.I0(\lsr_reg_n_0_[7] ),
        .I1(L[3]),
        .I2(L[1]),
        .I3(L[0]),
        .I4(L[2]),
        .I5(clockDiv[15]),
        .O(\Dout[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \Dout[7]_i_7 
       (.I0(\Dout[2]_i_5_n_0 ),
        .I1(\GENERATING_FIFOS.fcr_reg_n_0_[7] ),
        .I2(clockDiv[7]),
        .I3(\Dout[6]_i_2_n_0 ),
        .I4(scr[7]),
        .I5(\Dout[6]_i_5_n_0 ),
        .O(\Dout[7]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'h00000200)) 
    \Dout[7]_i_8 
       (.I0(\iir_reg_n_0_[7] ),
        .I1(L[1]),
        .I2(L[3]),
        .I3(L[2]),
        .I4(L[0]),
        .O(\Dout[7]_i_8_n_0 ));
  FDRE \Dout_reg[0] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_17 ),
        .Q(Q[0]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[1] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_16 ),
        .Q(Q[1]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[2] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_15 ),
        .Q(Q[2]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[3] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_14 ),
        .Q(Q[3]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[4] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(rx16550_1_n_22),
        .Q(Q[4]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[5] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(rx16550_1_n_21),
        .Q(Q[5]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[6] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_13 ),
        .Q(Q[6]),
        .R(bus2ip_reset_int_core));
  FDRE \Dout_reg[7] 
       (.C(s_axi_aclk),
        .CE(p_92_in),
        .D(rx16550_1_n_20),
        .Q(Q[7]),
        .R(bus2ip_reset_int_core));
  LUT6 #(
    .INIT(64'hFFFFFFBF00000080)) 
    \GENERATING_FIFOS.fcr[0]_i_1 
       (.I0(\d_d_reg_n_0_[0] ),
        .I1(\GENERATING_FIFOS.fcr[2]_i_2_n_0 ),
        .I2(L[2]),
        .I3(L[3]),
        .I4(L[1]),
        .I5(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .O(\GENERATING_FIFOS.fcr[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFBFFFFFFFFF)) 
    \GENERATING_FIFOS.fcr[2]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(\GENERATING_FIFOS.fcr[2]_i_2_n_0 ),
        .I2(L[2]),
        .I3(L[3]),
        .I4(L[1]),
        .I5(fcr_0_prev),
        .O(\GENERATING_FIFOS.fcr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \GENERATING_FIFOS.fcr[2]_i_2 
       (.I0(chipSelect),
        .I1(wr_d),
        .O(\GENERATING_FIFOS.fcr[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0200000000000000)) 
    \GENERATING_FIFOS.fcr[7]_i_1 
       (.I0(fcr_0_prev),
        .I1(L[1]),
        .I2(L[3]),
        .I3(L[2]),
        .I4(chipSelect),
        .I5(wr_d),
        .O(\GENERATING_FIFOS.fcr[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEF00000020)) 
    \GENERATING_FIFOS.fcr_0_prev_i_1 
       (.I0(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .I1(\GENERATING_FIFOS.fcr[2]_i_2_n_0 ),
        .I2(L[2]),
        .I3(L[3]),
        .I4(L[1]),
        .I5(fcr_0_prev),
        .O(\GENERATING_FIFOS.fcr_0_prev_i_1_n_0 ));
  FDRE \GENERATING_FIFOS.fcr_0_prev_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.fcr_0_prev_i_1_n_0 ),
        .Q(fcr_0_prev),
        .R(bus2ip_reset_int_core));
  FDRE \GENERATING_FIFOS.fcr_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.fcr[0]_i_1_n_0 ),
        .Q(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .R(bus2ip_reset_int_core));
  FDRE \GENERATING_FIFOS.fcr_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\d_d_reg_n_0_[1] ),
        .Q(\GENERATING_FIFOS.fcr_reg_n_0_[1] ),
        .R(\GENERATING_FIFOS.fcr[2]_i_1_n_0 ));
  FDRE \GENERATING_FIFOS.fcr_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\d_d_reg_n_0_[2] ),
        .Q(p_0_in4_in),
        .R(\GENERATING_FIFOS.fcr[2]_i_1_n_0 ));
  FDRE \GENERATING_FIFOS.fcr_reg[3] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.fcr[7]_i_1_n_0 ),
        .D(\d_d_reg_n_0_[3] ),
        .Q(\GENERATING_FIFOS.fcr_reg_n_0_[3] ),
        .R(bus2ip_reset_int_core));
  FDRE \GENERATING_FIFOS.fcr_reg[6] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.fcr[7]_i_1_n_0 ),
        .D(p_2_in[5]),
        .Q(\GENERATING_FIFOS.fcr_reg_n_0_[6] ),
        .R(bus2ip_reset_int_core));
  FDRE \GENERATING_FIFOS.fcr_reg[7] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.fcr[7]_i_1_n_0 ),
        .D(p_2_in[6]),
        .Q(\GENERATING_FIFOS.fcr_reg_n_0_[7] ),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt[0]_i_1 
       (.I0(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'hE9696969)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt[1]_i_1 
       (.I0(rx_error_in_fifo_cnt_up),
        .I1(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .I2(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .I3(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .I4(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'hFE817E81)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt[2]_i_1 
       (.I0(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .I1(rx_error_in_fifo_cnt_up),
        .I2(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .I3(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .I4(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(rx_fifo_rst),
        .O(p_1_out));
  LUT6 #(
    .INIT(64'hFFFFFFFE2AAAAAAA)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2 
       (.I0(rx_error_in_fifo_cnt_up),
        .I1(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .I2(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .I3(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .I4(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .I5(rx_error_in_fifo_cnt_dn),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'hFFFE8001)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_3 
       (.I0(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .I1(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .I2(rx_error_in_fifo_cnt_up),
        .I3(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .I4(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT5 #(
    .INIT(32'h00800000)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_2 
       (.I0(rd_d),
        .I1(chipSelect),
        .I2(L[3]),
        .I3(L[2]),
        .I4(L[1]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'hFEFF)) 
    \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_3 
       (.I0(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .I1(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .I2(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .I3(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .O(\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_3_n_0 ));
  FDRE \GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_9 ),
        .Q(rx_error_in_fifo_cnt_dn),
        .R(bus2ip_reset_int_core));
  FDRE \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[0] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2_n_0 ),
        .D(\GENERATING_FIFOS.rx_error_in_fifo_cnt[0]_i_1_n_0 ),
        .Q(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .R(p_1_out));
  FDRE \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[1] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2_n_0 ),
        .D(\GENERATING_FIFOS.rx_error_in_fifo_cnt[1]_i_1_n_0 ),
        .Q(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .R(p_1_out));
  FDRE \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[2] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2_n_0 ),
        .D(\GENERATING_FIFOS.rx_error_in_fifo_cnt[2]_i_1_n_0 ),
        .Q(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .R(p_1_out));
  FDRE \GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] 
       (.C(s_axi_aclk),
        .CE(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_2_n_0 ),
        .D(\GENERATING_FIFOS.rx_error_in_fifo_cnt[3]_i_3_n_0 ),
        .Q(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .R(p_1_out));
  FDRE \GENERATING_FIFOS.rx_error_in_fifo_cnt_up_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Rx_error_in_fifo),
        .Q(rx_error_in_fifo_cnt_up),
        .R(bus2ip_reset_int_core));
  sensors96b_axi_uart16550_0_0_rx_fifo_block \GENERATING_FIFOS.rx_fifo_block_1 
       (.D({\GENERATING_FIFOS.rx_fifo_block_1_n_13 ,\GENERATING_FIFOS.rx_fifo_block_1_n_14 ,\GENERATING_FIFOS.rx_fifo_block_1_n_15 ,\GENERATING_FIFOS.rx_fifo_block_1_n_16 ,\GENERATING_FIFOS.rx_fifo_block_1_n_17 }),
        .\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .\GENERATING_FIFOS.fcr_reg[3] (rxrdyN_int_i_2_n_0),
        .\GENERATING_FIFOS.fcr_reg[7] ({\GENERATING_FIFOS.fcr_reg_n_0_[7] ,\GENERATING_FIFOS.fcr_reg_n_0_[6] ,\GENERATING_FIFOS.fcr_reg_n_0_[3] ,p_0_in4_in,\GENERATING_FIFOS.fcr_reg_n_0_[1] }),
        .\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_reg (\GENERATING_FIFOS.rx_fifo_block_1_n_9 ),
        .\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg[3] (\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_3_n_0 ),
        .L(L[0]),
        .\Lcr_reg[3] (\Dout[3]_i_2_n_0 ),
        .\Lcr_reg[3]_0 (p_5_in36_in),
        .\Lcr_reg[6] (\Dout[6]_i_3_n_0 ),
        .Q({\d_d_reg_n_0_[1] ,\d_d_reg_n_0_[0] }),
        .\Rbr_reg[6] ({Rbr[6],Rbr[3:0]}),
        .Rx_error_in_fifo(Rx_error_in_fifo),
        .Rx_error_in_fifo0(\rx_fifo_control_1/Rx_error_in_fifo0 ),
        .SR(\rx_fifo_control_1/character_counter_rst ),
        .\addr_d_reg[0] (\Dout[5]_i_4_n_0 ),
        .\addr_d_reg[0]_0 (\Dout[7]_i_3_n_0 ),
        .\addr_d_reg[1] (\Dout[2]_i_5_n_0 ),
        .\addr_d_reg[1]_0 (\Dout[6]_i_5_n_0 ),
        .\addr_d_reg[2] (\lsr[2]_i_3_n_0 ),
        .\addr_d_reg[2]_0 (\Dout[3]_i_4_n_0 ),
        .\addr_d_reg[2]_1 (\Dout[2]_i_4_n_0 ),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .bus2ip_reset_int_core_reg(thre_iir_set_i_3_n_0),
        .character_received(character_received),
        .chipSelect(chipSelect),
        .chipSelect_reg(Ddis_i_1_n_0),
        .dlab_reg(\Dout[6]_i_2_n_0 ),
        .dlab_reg_0(\Dout[2]_i_8_n_0 ),
        .\dll_reg[1] (\Dout[1]_i_2_n_0 ),
        .\dll_reg[6] (clockDiv[6]),
        .\ier_reg[0] (\Dout[0]_i_3_n_0 ),
        .\ier_reg[2] (\iir[1]_i_2_n_0 ),
        .\ier_reg[3] (ier),
        .\ier_reg[3]_0 (\iir[0]_i_3_n_0 ),
        .iir(iir),
        .\iir_reg[0] (\GENERATING_FIFOS.rx_fifo_block_1_n_8 ),
        .\iir_reg[0]_0 (\GENERATING_FIFOS.rx_fifo_block_1_n_19 ),
        .\iir_reg[0]_1 (\Dout[0]_i_2_n_0 ),
        .\iir_reg[1] (\GENERATING_FIFOS.rx_fifo_block_1_n_18 ),
        .\iir_reg[2] (\GENERATING_FIFOS.rx_fifo_block_1_n_20 ),
        .\iir_reg[2]_0 (thre_iir_set_i_2_n_0),
        .\iir_reg[2]_1 (\iir[2]_i_5_n_0 ),
        .\iir_reg[3] (\GENERATING_FIFOS.rx_fifo_block_1_n_7 ),
        .\iir_reg[7] (\Dout[7]_i_8_n_0 ),
        .in({rx_fifo_data_in[10],rx_fifo_data_in[9],rx_fifo_data_in[8],rx_fifo_data_in[7],rx_fifo_data_in[6],rx_fifo_data_in[5],rx_fifo_data_in[4],rx_fifo_data_in[3],rx_fifo_data_in[2],rx_fifo_data_in[1],rx_fifo_data_in[0]}),
        .lsr2_rst(lsr2_rst),
        .lsr2_rst_reg(\GENERATING_FIFOS.rx_fifo_block_1_n_3 ),
        .lsr2_set(lsr2_set),
        .lsr3_set(lsr3_set),
        .lsr4_set(lsr4_set),
        .lsr5_d(lsr5_d),
        .lsr_reg0(lsr_reg0),
        .\lsr_reg[0] (rx_fifo_empty),
        .\lsr_reg[0]_0 (\GENERATING_FIFOS.rx_fifo_block_1_n_4 ),
        .\lsr_reg[0]_1 (\lsr_reg_n_0_[0] ),
        .\lsr_reg[1] (\GENERATING_FIFOS.rx_fifo_block_1_n_5 ),
        .\lsr_reg[1]_0 (\lsr_reg_n_0_[1] ),
        .\lsr_reg[6] (\lsr_reg_n_0_[6] ),
        .\msr_reg[2] (\Dout[2]_i_2_n_0 ),
        .out({rx_fifo_data_out[7],rx_fifo_data_out[5:4]}),
        .p_0_in(p_0_in),
        .p_0_in2_in(p_0_in2_in),
        .p_0_in42_in(p_0_in42_in),
        .p_1_in43_in(p_1_in43_in),
        .p_2_in44_in(p_2_in44_in),
        .p_2_in51_in(p_2_in51_in),
        .rd_d_reg(\GENERATING_FIFOS.rx_error_in_fifo_cnt_dn_i_2_n_0 ),
        .rd_d_reg_0(\iir[2]_i_6_n_0 ),
        .rd_d_reg_1(\iir[2]_i_8_n_0 ),
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_rd_en_d(rx_fifo_rd_en_d),
        .rx_fifo_rd_en_d1(rx_fifo_rd_en_d1),
        .rx_fifo_rst(rx_fifo_rst),
        .rx_fifo_wr_en_i(rx_fifo_wr_en_i),
        .rxrdyN_int_reg(\GENERATING_FIFOS.rx_fifo_block_1_n_21 ),
        .s_axi_aclk(s_axi_aclk),
        .\scr_reg[6] (scr[6]),
        .thre_iir_set(thre_iir_set),
        .thre_iir_set_reg(\GENERATING_FIFOS.rx_fifo_block_1_n_6 ),
        .wr_d(wr_d),
        .writing_thr(writing_thr));
  FDRE \GENERATING_FIFOS.rx_fifo_rd_en_d1_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rx_fifo_rd_en_d),
        .Q(rx_fifo_rd_en_d1),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'h2000)) 
    \GENERATING_FIFOS.rx_fifo_rd_en_d_i_1 
       (.I0(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .I1(\Dout[5]_i_4_n_0 ),
        .I2(chipSelect),
        .I3(rd_d),
        .O(rx_fifo_rd_en));
  FDRE \GENERATING_FIFOS.rx_fifo_rd_en_d_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rx_fifo_rd_en),
        .Q(rx_fifo_rd_en_d),
        .R(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'hFFFFAEEA)) 
    \GENERATING_FIFOS.rx_fifo_rst_i_1 
       (.I0(\GENERATING_FIFOS.fcr_reg_n_0_[1] ),
        .I1(p_14_out),
        .I2(fcr_0_prev),
        .I3(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .I4(bus2ip_reset_int_core),
        .O(\GENERATING_FIFOS.rx_fifo_rst_i_1_n_0 ));
  FDRE \GENERATING_FIFOS.rx_fifo_rst_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_rst_i_1_n_0 ),
        .Q(rx_fifo_rst),
        .R(1'b0));
  sensors96b_axi_uart16550_0_0_tx_fifo_block \GENERATING_FIFOS.tx_fifo_block_1 
       (.\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .\GENERATING_FIFOS.fcr_reg[3] (\GENERATING_FIFOS.fcr_reg_n_0_[3] ),
        .Q(tx_fifo_empty),
        .SS(tx_fifo_rst),
        .\Thr_reg[7] (Thr),
        .Tx_fifo_rd_en_reg(tx16550_1_n_5),
        .out(tx_fifo_data_out),
        .p_2_in51_in(p_2_in51_in),
        .s_axi_aclk(s_axi_aclk),
        .tx_fifo_rd_en_int(tx_fifo_rd_en_int),
        .tx_fifo_wr_en_d(tx_fifo_wr_en_d),
        .txrdyN_int_reg(\GENERATING_FIFOS.tx_fifo_block_1_n_1 ),
        .txrdyn(txrdyn));
  LUT5 #(
    .INIT(32'hFFFFAEEA)) 
    \GENERATING_FIFOS.tx_fifo_rst_i_1 
       (.I0(p_0_in4_in),
        .I1(p_14_out),
        .I2(fcr_0_prev),
        .I3(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .I4(bus2ip_reset_int_core),
        .O(p_5_out));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT5 #(
    .INIT(32'h00000080)) 
    \GENERATING_FIFOS.tx_fifo_rst_i_2 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[2]),
        .I3(L[3]),
        .I4(L[1]),
        .O(p_14_out));
  FDRE \GENERATING_FIFOS.tx_fifo_rst_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_5_out),
        .Q(tx_fifo_rst),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \GENERATING_FIFOS.tx_fifo_wr_en_d_i_1 
       (.I0(L[3]),
        .I1(L[1]),
        .I2(L[2]),
        .I3(L[0]),
        .I4(\GENERATING_FIFOS.fcr[2]_i_2_n_0 ),
        .I5(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .O(\GENERATING_FIFOS.tx_fifo_wr_en_d_i_1_n_0 ));
  FDRE \GENERATING_FIFOS.tx_fifo_wr_en_d_reg 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.tx_fifo_wr_en_d_i_1_n_0 ),
        .Q(tx_fifo_wr_en_d),
        .R(bus2ip_reset_int_core));
  LUT2 #(
    .INIT(4'h1)) 
    Intr_i_1
       (.I0(iir[0]),
        .I1(freeze),
        .O(Intr0));
  FDRE Intr_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Intr0),
        .Q(ip2intc_irpt),
        .R(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'h00800000)) 
    \Lcr[7]_i_1 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[2]),
        .I3(L[1]),
        .I4(L[3]),
        .O(Lcr0));
  FDSE \Lcr_reg[0] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(\d_d_reg_n_0_[0] ),
        .Q(\Lcr_reg_n_0_[0] ),
        .S(bus2ip_reset_int_core));
  FDSE \Lcr_reg[1] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(\d_d_reg_n_0_[1] ),
        .Q(\Lcr_reg_n_0_[1] ),
        .S(bus2ip_reset_int_core));
  FDRE \Lcr_reg[2] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(\d_d_reg_n_0_[2] ),
        .Q(\Lcr_reg_n_0_[2] ),
        .R(bus2ip_reset_int_core));
  FDRE \Lcr_reg[3] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(\d_d_reg_n_0_[3] ),
        .Q(p_5_in36_in),
        .R(bus2ip_reset_int_core));
  FDRE \Lcr_reg[4] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(p_3_in),
        .Q(\Lcr_reg_n_0_[4] ),
        .R(bus2ip_reset_int_core));
  FDRE \Lcr_reg[5] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(\d_d_reg_n_0_[5] ),
        .Q(\Lcr_reg_n_0_[5] ),
        .R(bus2ip_reset_int_core));
  FDRE \Lcr_reg[6] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(p_2_in[5]),
        .Q(\Lcr_reg_n_0_[6] ),
        .R(bus2ip_reset_int_core));
  FDRE \Lcr_reg[7] 
       (.C(s_axi_aclk),
        .CE(Lcr0),
        .D(p_2_in[6]),
        .Q(\Lcr_reg_n_0_[7] ),
        .R(bus2ip_reset_int_core));
  (* XILINX_LEGACY_PRIM = "ODDRE1" *) 
  (* XILINX_TRANSFORM_PINMAP = "C:CLK SR:RST Q:OQ D1:D[0] D2:D[4]" *) 
  (* box_type = "PRIMITIVE" *) 
  OSERDESE3 #(
    .INIT(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .ODDR_MODE("TRUE"),
    .OSERDES_T_BYPASS("TRUE"),
    .SIM_DEVICE("ULTRASCALE_PLUS")) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF 
       (.CLK(s_axi_aclk),
        .CLKDIV(\NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_CLKDIV_UNCONNECTED ),
        .D({\NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_D_UNCONNECTED [7:5],D2,\NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_D_UNCONNECTED [3:1],p_0_in}),
        .OQ(baudoutn),
        .RST(bus2ip_reset_int_core),
        .T(1'b0),
        .T_OUT(\NLW_NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_T_OUT_UNCONNECTED ));
  LUT5 #(
    .INIT(32'hFFFF0004)) 
    \NO_EXTERNAL_XIN.OSERDESE3_ODDR_GEN.BAUD_FF_i_2 
       (.I0(rx16550_1_n_16),
        .I1(rx16550_1_n_15),
        .I2(rx16550_1_n_14),
        .I3(rx16550_1_n_13),
        .I4(baudoutN_int_i),
        .O(D2));
  FDSE \Thr_reg[0] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(\d_d_reg_n_0_[0] ),
        .Q(Thr[0]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[1] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(\d_d_reg_n_0_[1] ),
        .Q(Thr[1]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[2] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(\d_d_reg_n_0_[2] ),
        .Q(Thr[2]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[3] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(\d_d_reg_n_0_[3] ),
        .Q(Thr[3]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[4] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(p_3_in),
        .Q(Thr[4]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[5] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(\d_d_reg_n_0_[5] ),
        .Q(Thr[5]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[6] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(p_2_in[5]),
        .Q(Thr[6]),
        .S(bus2ip_reset_int_core));
  FDSE \Thr_reg[7] 
       (.C(s_axi_aclk),
        .CE(Thr0),
        .D(p_2_in[6]),
        .Q(Thr[7]),
        .S(bus2ip_reset_int_core));
  FDRE \addr_d_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bus2ip_addr_i_reg[4] [0]),
        .Q(L[3]),
        .R(bus2ip_reset_int_core));
  FDRE \addr_d_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bus2ip_addr_i_reg[4] [1]),
        .Q(L[2]),
        .R(bus2ip_reset_int_core));
  FDRE \addr_d_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\bus2ip_addr_i_reg[4] [2]),
        .Q(L[1]),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'h8B)) 
    \baudCounter[0]_i_1 
       (.I0(clockDiv[0]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[0]),
        .O(\baudCounter[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'hB8BB8B88)) 
    \baudCounter[10]_i_1 
       (.I0(clockDiv[10]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[9]),
        .I3(\baudCounter[11]_i_2_n_0 ),
        .I4(baudCounter[10]),
        .O(\baudCounter[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8B8B88BB8B8)) 
    \baudCounter[11]_i_1 
       (.I0(clockDiv[11]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[11]),
        .I3(baudCounter[9]),
        .I4(\baudCounter[11]_i_2_n_0 ),
        .I5(baudCounter[10]),
        .O(\baudCounter[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \baudCounter[11]_i_2 
       (.I0(baudCounter[8]),
        .I1(baudCounter[2]),
        .I2(baudCounter[1]),
        .I3(baudCounter[0]),
        .I4(baudoutN_int_i_i_2_n_0),
        .O(\baudCounter[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8B8B8B8B88B)) 
    \baudCounter[12]_i_1 
       (.I0(clockDiv[12]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[12]),
        .I3(\baudCounter[12]_i_2_n_0 ),
        .I4(baudCounter[11]),
        .I5(baudCounter[10]),
        .O(\baudCounter[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \baudCounter[12]_i_2 
       (.I0(baudCounter[9]),
        .I1(\baudCounter[11]_i_2_n_0 ),
        .O(\baudCounter[12]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8BB8)) 
    \baudCounter[13]_i_1 
       (.I0(clockDiv[13]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[13]),
        .I3(\baudCounter[13]_i_2_n_0 ),
        .O(\baudCounter[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \baudCounter[13]_i_2 
       (.I0(\baudCounter[11]_i_2_n_0 ),
        .I1(baudCounter[9]),
        .I2(baudCounter[12]),
        .I3(baudCounter[11]),
        .I4(baudCounter[10]),
        .O(\baudCounter[13]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8BB8)) 
    \baudCounter[14]_i_1 
       (.I0(clockDiv[14]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[14]),
        .I3(\baudCounter[15]_i_3_n_0 ),
        .O(\baudCounter[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB88BB8B8)) 
    \baudCounter[15]_i_1 
       (.I0(clockDiv[15]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[15]),
        .I3(baudCounter[14]),
        .I4(\baudCounter[15]_i_3_n_0 ),
        .O(\baudCounter[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \baudCounter[15]_i_2 
       (.I0(bus2ip_reset_int_core),
        .I1(baudoutN_int_i_i_1_n_0),
        .I2(divisor_latch_loaded),
        .O(\baudCounter[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \baudCounter[15]_i_3 
       (.I0(baudCounter[10]),
        .I1(baudCounter[11]),
        .I2(baudCounter[12]),
        .I3(baudCounter[9]),
        .I4(\baudCounter[11]_i_2_n_0 ),
        .I5(baudCounter[13]),
        .O(\baudCounter[15]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'hB88B)) 
    \baudCounter[1]_i_1 
       (.I0(clockDiv[1]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[0]),
        .I3(baudCounter[1]),
        .O(\baudCounter[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'hBBB8888B)) 
    \baudCounter[2]_i_1 
       (.I0(clockDiv[2]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[0]),
        .I3(baudCounter[1]),
        .I4(baudCounter[2]),
        .O(\baudCounter[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBBBBBBB88888888B)) 
    \baudCounter[3]_i_1 
       (.I0(clockDiv[3]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[2]),
        .I3(baudCounter[1]),
        .I4(baudCounter[0]),
        .I5(baudCounter[3]),
        .O(\baudCounter[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hB88B)) 
    \baudCounter[4]_i_1 
       (.I0(clockDiv[4]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(\baudCounter[6]_i_2_n_0 ),
        .I3(baudCounter[4]),
        .O(\baudCounter[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8B88B)) 
    \baudCounter[5]_i_1 
       (.I0(clockDiv[5]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[5]),
        .I3(\baudCounter[6]_i_2_n_0 ),
        .I4(baudCounter[4]),
        .O(\baudCounter[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hB8B8B8B8B8B8B88B)) 
    \baudCounter[6]_i_1 
       (.I0(clockDiv[6]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[6]),
        .I3(\baudCounter[6]_i_2_n_0 ),
        .I4(baudCounter[5]),
        .I5(baudCounter[4]),
        .O(\baudCounter[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \baudCounter[6]_i_2 
       (.I0(baudCounter[3]),
        .I1(baudCounter[0]),
        .I2(baudCounter[1]),
        .I3(baudCounter[2]),
        .O(\baudCounter[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB88BB8B8)) 
    \baudCounter[7]_i_1 
       (.I0(clockDiv[7]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[7]),
        .I3(baudCounter[6]),
        .I4(\baudCounter[7]_i_2_n_0 ),
        .O(\baudCounter[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \baudCounter[7]_i_2 
       (.I0(baudCounter[4]),
        .I1(baudCounter[5]),
        .I2(baudCounter[2]),
        .I3(baudCounter[1]),
        .I4(baudCounter[0]),
        .I5(baudCounter[3]),
        .O(\baudCounter[7]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hB88B)) 
    \baudCounter[8]_i_1 
       (.I0(clockDiv[8]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(\baudCounter[8]_i_2_n_0 ),
        .I3(baudCounter[8]),
        .O(\baudCounter[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \baudCounter[8]_i_2 
       (.I0(baudCounter[3]),
        .I1(baudCounter[6]),
        .I2(baudCounter[7]),
        .I3(baudCounter[5]),
        .I4(baudCounter[4]),
        .I5(\baudCounter[8]_i_3_n_0 ),
        .O(\baudCounter[8]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \baudCounter[8]_i_3 
       (.I0(baudCounter[2]),
        .I1(baudCounter[1]),
        .I2(baudCounter[0]),
        .O(\baudCounter[8]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8BB8)) 
    \baudCounter[9]_i_1 
       (.I0(clockDiv[9]),
        .I1(\baudCounter[15]_i_2_n_0 ),
        .I2(baudCounter[9]),
        .I3(\baudCounter[11]_i_2_n_0 ),
        .O(\baudCounter[9]_i_1_n_0 ));
  FDRE \baudCounter_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[0]_i_1_n_0 ),
        .Q(baudCounter[0]),
        .R(1'b0));
  FDRE \baudCounter_reg[10] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[10]_i_1_n_0 ),
        .Q(baudCounter[10]),
        .R(1'b0));
  FDRE \baudCounter_reg[11] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[11]_i_1_n_0 ),
        .Q(baudCounter[11]),
        .R(1'b0));
  FDRE \baudCounter_reg[12] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[12]_i_1_n_0 ),
        .Q(baudCounter[12]),
        .R(1'b0));
  FDRE \baudCounter_reg[13] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[13]_i_1_n_0 ),
        .Q(baudCounter[13]),
        .R(1'b0));
  FDRE \baudCounter_reg[14] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[14]_i_1_n_0 ),
        .Q(baudCounter[14]),
        .R(1'b0));
  FDRE \baudCounter_reg[15] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[15]_i_1_n_0 ),
        .Q(baudCounter[15]),
        .R(1'b0));
  FDRE \baudCounter_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[1]_i_1_n_0 ),
        .Q(baudCounter[1]),
        .R(1'b0));
  FDRE \baudCounter_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[2]_i_1_n_0 ),
        .Q(baudCounter[2]),
        .R(1'b0));
  FDRE \baudCounter_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[3]_i_1_n_0 ),
        .Q(baudCounter[3]),
        .R(1'b0));
  FDRE \baudCounter_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[4]_i_1_n_0 ),
        .Q(baudCounter[4]),
        .R(1'b0));
  FDRE \baudCounter_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[5]_i_1_n_0 ),
        .Q(baudCounter[5]),
        .R(1'b0));
  FDRE \baudCounter_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[6]_i_1_n_0 ),
        .Q(baudCounter[6]),
        .R(1'b0));
  FDRE \baudCounter_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[7]_i_1_n_0 ),
        .Q(baudCounter[7]),
        .R(1'b0));
  FDRE \baudCounter_reg[8] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[8]_i_1_n_0 ),
        .Q(baudCounter[8]),
        .R(1'b0));
  FDRE \baudCounter_reg[9] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\baudCounter[9]_i_1_n_0 ),
        .Q(baudCounter[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'hB)) 
    baud_counter_loaded_i_1
       (.I0(divisor_latch_loaded),
        .I1(baudoutN_int_i_i_1_n_0),
        .O(baudCounter1));
  FDRE baud_counter_loaded_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(baudCounter1),
        .Q(baud_counter_loaded),
        .R(bus2ip_reset_int_core));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEF)) 
    baudoutN_int_i_i_1
       (.I0(baudoutN_int_i_i_2_n_0),
        .I1(baudCounter[15]),
        .I2(baudCounter[0]),
        .I3(baudCounter[2]),
        .I4(baudoutN_int_i_i_3_n_0),
        .I5(baudoutN_int_i_i_4_n_0),
        .O(baudoutN_int_i_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    baudoutN_int_i_i_2
       (.I0(baudCounter[4]),
        .I1(baudCounter[5]),
        .I2(baudCounter[7]),
        .I3(baudCounter[6]),
        .I4(baudCounter[3]),
        .O(baudoutN_int_i_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    baudoutN_int_i_i_3
       (.I0(baudCounter[13]),
        .I1(baudCounter[14]),
        .I2(baudCounter[1]),
        .I3(baudCounter[8]),
        .O(baudoutN_int_i_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    baudoutN_int_i_i_4
       (.I0(baudCounter[10]),
        .I1(baudCounter[11]),
        .I2(baudCounter[12]),
        .I3(baudCounter[9]),
        .O(baudoutN_int_i_i_4_n_0));
  FDRE baudoutN_int_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(baudoutN_int_i_i_1_n_0),
        .Q(baudoutN_int_i),
        .R(1'b0));
  FDRE chipSelect_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ce_out_i),
        .Q(chipSelect),
        .R(bus2ip_reset_int_core));
  FDRE ctsN_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ctsn),
        .Q(ctsN_d),
        .R(1'b0));
  FDRE \d_d_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[0]),
        .Q(\d_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \d_d_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[1]),
        .Q(\d_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \d_d_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[2]),
        .Q(\d_d_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \d_d_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[3]),
        .Q(\d_d_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \d_d_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[4]),
        .Q(p_3_in),
        .R(1'b0));
  FDRE \d_d_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[5]),
        .Q(\d_d_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \d_d_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[6]),
        .Q(p_2_in[5]),
        .R(1'b0));
  FDRE \d_d_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[7]),
        .Q(p_2_in[6]),
        .R(1'b0));
  FDRE dcdN_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dcdn),
        .Q(dcdN_d),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00005554)) 
    divisor_latch_loaded_i_1
       (.I0(bus2ip_reset_int_core),
        .I1(load_baudupper),
        .I2(load_baudlower),
        .I3(divisor_latch_loaded),
        .I4(baud_counter_loaded),
        .O(divisor_latch_loaded_i_1_n_0));
  FDRE divisor_latch_loaded_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(divisor_latch_loaded_i_1_n_0),
        .Q(divisor_latch_loaded),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFBFFFFF00800000)) 
    dlab_i_1
       (.I0(L[0]),
        .I1(\GENERATING_FIFOS.fcr[2]_i_2_n_0 ),
        .I2(L[2]),
        .I3(L[1]),
        .I4(L[3]),
        .I5(\Lcr_reg_n_0_[7] ),
        .O(dlab_i_1_n_0));
  FDRE dlab_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dlab_i_1_n_0),
        .Q(L[0]),
        .R(bus2ip_reset_int_core));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \dll[7]_i_1 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[3]),
        .I3(L[1]),
        .I4(L[2]),
        .I5(L[0]),
        .O(dll0));
  FDSE \dll_reg[0] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(\d_d_reg_n_0_[0] ),
        .Q(clockDiv[0]),
        .S(bus2ip_reset_int_core));
  FDSE \dll_reg[1] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(\d_d_reg_n_0_[1] ),
        .Q(clockDiv[1]),
        .S(bus2ip_reset_int_core));
  FDRE \dll_reg[2] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(\d_d_reg_n_0_[2] ),
        .Q(clockDiv[2]),
        .R(bus2ip_reset_int_core));
  FDSE \dll_reg[3] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(\d_d_reg_n_0_[3] ),
        .Q(clockDiv[3]),
        .S(bus2ip_reset_int_core));
  FDRE \dll_reg[4] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(p_3_in),
        .Q(clockDiv[4]),
        .R(bus2ip_reset_int_core));
  FDRE \dll_reg[5] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(\d_d_reg_n_0_[5] ),
        .Q(clockDiv[5]),
        .R(bus2ip_reset_int_core));
  FDRE \dll_reg[6] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(p_2_in[5]),
        .Q(clockDiv[6]),
        .R(bus2ip_reset_int_core));
  FDSE \dll_reg[7] 
       (.C(s_axi_aclk),
        .CE(dll0),
        .D(p_2_in[6]),
        .Q(clockDiv[7]),
        .S(bus2ip_reset_int_core));
  LUT6 #(
    .INIT(64'h0000080000000000)) 
    \dlm[7]_i_1 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[2]),
        .I3(L[0]),
        .I4(L[1]),
        .I5(L[3]),
        .O(dlm0));
  FDRE \dlm_reg[0] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(\d_d_reg_n_0_[0] ),
        .Q(clockDiv[8]),
        .R(bus2ip_reset_int_core));
  FDSE \dlm_reg[1] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(\d_d_reg_n_0_[1] ),
        .Q(clockDiv[9]),
        .S(bus2ip_reset_int_core));
  FDRE \dlm_reg[2] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(\d_d_reg_n_0_[2] ),
        .Q(clockDiv[10]),
        .R(bus2ip_reset_int_core));
  FDRE \dlm_reg[3] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(\d_d_reg_n_0_[3] ),
        .Q(clockDiv[11]),
        .R(bus2ip_reset_int_core));
  FDRE \dlm_reg[4] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(p_3_in),
        .Q(clockDiv[12]),
        .R(bus2ip_reset_int_core));
  FDRE \dlm_reg[5] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(\d_d_reg_n_0_[5] ),
        .Q(clockDiv[13]),
        .R(bus2ip_reset_int_core));
  FDRE \dlm_reg[6] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(p_2_in[5]),
        .Q(clockDiv[14]),
        .R(bus2ip_reset_int_core));
  FDRE \dlm_reg[7] 
       (.C(s_axi_aclk),
        .CE(dlm0),
        .D(p_2_in[6]),
        .Q(clockDiv[15]),
        .R(bus2ip_reset_int_core));
  FDRE dsrN_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dsrn),
        .Q(dsrN_d),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'hB)) 
    dtrn_INST_0
       (.I0(p_0_in8_in),
        .I1(\mcr_reg_n_0_[0] ),
        .O(dtrn));
  FDRE ier1_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ier[1]),
        .Q(ier1_d),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000080)) 
    \ier[3]_i_1 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[3]),
        .I3(L[0]),
        .I4(L[2]),
        .I5(L[1]),
        .O(ier1));
  FDRE \ier_reg[0] 
       (.C(s_axi_aclk),
        .CE(ier1),
        .D(\d_d_reg_n_0_[0] ),
        .Q(ier[0]),
        .R(bus2ip_reset_int_core));
  FDRE \ier_reg[1] 
       (.C(s_axi_aclk),
        .CE(ier1),
        .D(\d_d_reg_n_0_[1] ),
        .Q(ier[1]),
        .R(bus2ip_reset_int_core));
  FDRE \ier_reg[2] 
       (.C(s_axi_aclk),
        .CE(ier1),
        .D(\d_d_reg_n_0_[2] ),
        .Q(ier[2]),
        .R(bus2ip_reset_int_core));
  FDRE \ier_reg[3] 
       (.C(s_axi_aclk),
        .CE(ier1),
        .D(\d_d_reg_n_0_[3] ),
        .Q(ier[3]),
        .R(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    \iir[0]_i_3 
       (.I0(ier[3]),
        .I1(\msr_reg_n_0_[0] ),
        .I2(p_0_in39_in),
        .I3(p_0_in37_in),
        .I4(p_0_in38_in),
        .O(\iir[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    \iir[1]_i_2 
       (.I0(ier[2]),
        .I1(\lsr_reg_n_0_[1] ),
        .I2(p_1_in43_in),
        .I3(p_0_in42_in),
        .I4(p_2_in44_in),
        .O(\iir[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFDFFFFFFFFFFFF)) 
    \iir[2]_i_5 
       (.I0(iir[2]),
        .I1(iir[3]),
        .I2(iir[0]),
        .I3(\lsr[2]_i_3_n_0 ),
        .I4(chipSelect),
        .I5(rd_d),
        .O(\iir[2]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'hFFFFFFF7)) 
    \iir[2]_i_6 
       (.I0(rd_d),
        .I1(chipSelect),
        .I2(iir[3]),
        .I3(iir[0]),
        .I4(iir[2]),
        .O(\iir[2]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFF7)) 
    \iir[2]_i_8 
       (.I0(rd_d),
        .I1(chipSelect),
        .I2(L[0]),
        .I3(L[2]),
        .I4(L[1]),
        .I5(L[3]),
        .O(\iir[2]_i_8_n_0 ));
  FDSE \iir_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_19 ),
        .Q(iir[0]),
        .S(\GENERATING_FIFOS.rx_fifo_block_1_n_8 ));
  FDRE \iir_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_18 ),
        .Q(iir[1]),
        .R(\GENERATING_FIFOS.rx_fifo_block_1_n_8 ));
  FDRE \iir_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_20 ),
        .Q(iir[2]),
        .R(\GENERATING_FIFOS.rx_fifo_block_1_n_8 ));
  FDRE \iir_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_7 ),
        .Q(iir[3]),
        .R(1'b0));
  FDRE \iir_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .Q(\iir_reg_n_0_[7] ),
        .R(1'b0));
  FDRE load_baudlower_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dll0),
        .Q(load_baudlower),
        .R(1'b0));
  FDRE load_baudupper_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dlm0),
        .Q(load_baudupper),
        .R(1'b0));
  FDRE lsr2_rst_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_3 ),
        .Q(lsr2_rst),
        .R(bus2ip_reset_int_core));
  FDRE lsr5_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_2_in51_in),
        .Q(lsr5_d),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h00800000)) 
    \lsr[1]_i_3 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[3]),
        .I3(L[2]),
        .I4(L[1]),
        .O(lsr_reg0));
  LUT5 #(
    .INIT(32'hFFFFAAEA)) 
    \lsr[2]_i_1 
       (.I0(lsr2_rst),
        .I1(rd_d),
        .I2(chipSelect),
        .I3(\lsr[2]_i_3_n_0 ),
        .I4(bus2ip_reset_int_core),
        .O(lsr_reg019_out));
  LUT6 #(
    .INIT(64'hFFFFEFFFFFFF2000)) 
    \lsr[2]_i_2 
       (.I0(\d_d_reg_n_0_[2] ),
        .I1(\lsr[2]_i_3_n_0 ),
        .I2(chipSelect),
        .I3(wr_d),
        .I4(lsr2_set),
        .I5(p_0_in42_in),
        .O(\lsr[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hDF)) 
    \lsr[2]_i_3 
       (.I0(L[1]),
        .I1(L[2]),
        .I2(L[3]),
        .O(\lsr[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFFFFFF2000)) 
    \lsr[3]_i_1 
       (.I0(\d_d_reg_n_0_[3] ),
        .I1(\lsr[2]_i_3_n_0 ),
        .I2(chipSelect),
        .I3(wr_d),
        .I4(lsr3_set),
        .I5(p_1_in43_in),
        .O(\lsr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEFFFFFFF2000)) 
    \lsr[4]_i_1 
       (.I0(p_3_in),
        .I1(\lsr[2]_i_3_n_0 ),
        .I2(chipSelect),
        .I3(wr_d),
        .I4(lsr4_set),
        .I5(p_2_in44_in),
        .O(\lsr[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h11110111)) 
    \lsr[7]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(\lsr[7]_i_2_n_0 ),
        .I2(rd_d),
        .I3(chipSelect),
        .I4(\lsr[2]_i_3_n_0 ),
        .O(\lsr[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT5 #(
    .INIT(32'h0001FFFF)) 
    \lsr[7]_i_2 
       (.I0(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [1]),
        .I1(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [2]),
        .I2(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [3]),
        .I3(\GENERATING_FIFOS.rx_error_in_fifo_cnt_reg__0 [0]),
        .I4(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .O(\lsr[7]_i_2_n_0 ));
  FDRE \lsr_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_4 ),
        .Q(\lsr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \lsr_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_5 ),
        .Q(\lsr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \lsr_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\lsr[2]_i_2_n_0 ),
        .Q(p_0_in42_in),
        .R(lsr_reg019_out));
  FDRE \lsr_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\lsr[3]_i_1_n_0 ),
        .Q(p_1_in43_in),
        .R(lsr_reg019_out));
  FDRE \lsr_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\lsr[4]_i_1_n_0 ),
        .Q(p_2_in44_in),
        .R(lsr_reg019_out));
  FDRE \lsr_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(xuart_tx_load_sm_1_n_10),
        .Q(p_2_in51_in),
        .R(1'b0));
  FDRE \lsr_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(xuart_tx_load_sm_1_n_0),
        .Q(\lsr_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \lsr_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\lsr[7]_i_1_n_0 ),
        .Q(\lsr_reg_n_0_[7] ),
        .R(1'b0));
  FDRE mcr4_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(p_0_in8_in),
        .Q(mcr4_d),
        .R(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'h00000800)) 
    \mcr[4]_i_1 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[2]),
        .I3(L[1]),
        .I4(L[3]),
        .O(mcr0));
  FDRE \mcr_reg[0] 
       (.C(s_axi_aclk),
        .CE(mcr0),
        .D(\d_d_reg_n_0_[0] ),
        .Q(\mcr_reg_n_0_[0] ),
        .R(bus2ip_reset_int_core));
  FDRE \mcr_reg[1] 
       (.C(s_axi_aclk),
        .CE(mcr0),
        .D(\d_d_reg_n_0_[1] ),
        .Q(p_0_in_0),
        .R(bus2ip_reset_int_core));
  FDRE \mcr_reg[2] 
       (.C(s_axi_aclk),
        .CE(mcr0),
        .D(\d_d_reg_n_0_[2] ),
        .Q(\mcr_reg_n_0_[2] ),
        .R(bus2ip_reset_int_core));
  FDRE \mcr_reg[3] 
       (.C(s_axi_aclk),
        .CE(mcr0),
        .D(\d_d_reg_n_0_[3] ),
        .Q(\mcr_reg_n_0_[3] ),
        .R(bus2ip_reset_int_core));
  FDRE \mcr_reg[4] 
       (.C(s_axi_aclk),
        .CE(mcr0),
        .D(p_3_in),
        .Q(p_0_in8_in),
        .R(bus2ip_reset_int_core));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \modem_prev_val[0]_i_1 
       (.I0(ctsN_d),
        .I1(bus2ip_reset_int_core),
        .I2(\msr_reg_n_0_[4] ),
        .O(\modem_prev_val[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \modem_prev_val[1]_i_1 
       (.I0(dsrN_d),
        .I1(bus2ip_reset_int_core),
        .I2(p_0_in0_in),
        .O(\modem_prev_val[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \modem_prev_val[2]_i_1 
       (.I0(riN_d),
        .I1(bus2ip_reset_int_core),
        .I2(p_0_in2_in),
        .O(\modem_prev_val[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \modem_prev_val[3]_i_1 
       (.I0(dcdN_d),
        .I1(bus2ip_reset_int_core),
        .I2(p_0_in5_in),
        .O(\modem_prev_val[3]_i_1_n_0 ));
  FDRE \modem_prev_val_reg[0] 
       (.C(s_axi_aclk),
        .CE(msr_reg0),
        .D(\modem_prev_val[0]_i_1_n_0 ),
        .Q(\modem_prev_val_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \modem_prev_val_reg[1] 
       (.C(s_axi_aclk),
        .CE(msr_reg0),
        .D(\modem_prev_val[1]_i_1_n_0 ),
        .Q(\modem_prev_val_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \modem_prev_val_reg[2] 
       (.C(s_axi_aclk),
        .CE(msr_reg0),
        .D(\modem_prev_val[2]_i_1_n_0 ),
        .Q(p_1_in3_in),
        .R(1'b0));
  FDRE \modem_prev_val_reg[3] 
       (.C(s_axi_aclk),
        .CE(msr_reg0),
        .D(\modem_prev_val[3]_i_1_n_0 ),
        .Q(p_1_in6_in),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAEAAAAAAAAAAAAA)) 
    \msr[0]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(chipSelect),
        .I2(rd_d),
        .I3(L[3]),
        .I4(L[2]),
        .I5(L[1]),
        .O(msr_reg0));
  LUT5 #(
    .INIT(32'hB8BFBFB8)) 
    \msr[0]_i_2 
       (.I0(\d_d_reg_n_0_[0] ),
        .I1(msr1),
        .I2(\msr_reg_n_0_[0] ),
        .I3(\msr_reg_n_0_[4] ),
        .I4(\modem_prev_val_reg_n_0_[0] ),
        .O(\msr[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    \msr[0]_i_3 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[1]),
        .I3(L[2]),
        .I4(L[3]),
        .O(msr1));
  LUT5 #(
    .INIT(32'hB8BFBFB8)) 
    \msr[1]_i_1 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(msr1),
        .I2(p_0_in37_in),
        .I3(p_0_in0_in),
        .I4(\modem_prev_val_reg_n_0_[1] ),
        .O(\msr[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BFBFB8)) 
    \msr[2]_i_1 
       (.I0(\d_d_reg_n_0_[2] ),
        .I1(msr1),
        .I2(p_0_in38_in),
        .I3(p_0_in2_in),
        .I4(p_1_in3_in),
        .O(\msr[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BFBFB8)) 
    \msr[3]_i_1 
       (.I0(\d_d_reg_n_0_[3] ),
        .I1(msr1),
        .I2(p_0_in39_in),
        .I3(p_0_in5_in),
        .I4(p_1_in6_in),
        .O(\msr[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h45404040EFEAEFEF)) 
    \msr[4]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(p_3_in),
        .I2(msr1),
        .I3(p_0_in_0),
        .I4(p_0_in8_in),
        .I5(ctsN_d),
        .O(\msr[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h45404040EFEAEFEF)) 
    \msr[5]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(\d_d_reg_n_0_[5] ),
        .I2(msr1),
        .I3(\mcr_reg_n_0_[0] ),
        .I4(p_0_in8_in),
        .I5(dsrN_d),
        .O(\msr[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h45404040EFEAEFEF)) 
    \msr[6]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(\d_d_reg_n_0_[5] ),
        .I2(msr1),
        .I3(\mcr_reg_n_0_[2] ),
        .I4(p_0_in8_in),
        .I5(riN_d),
        .O(\msr[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h45404040EFEAEFEF)) 
    \msr[7]_i_1 
       (.I0(bus2ip_reset_int_core),
        .I1(\d_d_reg_n_0_[5] ),
        .I2(msr1),
        .I3(\mcr_reg_n_0_[3] ),
        .I4(p_0_in8_in),
        .I5(dcdN_d),
        .O(\msr[7]_i_1_n_0 ));
  FDRE \msr_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[0]_i_2_n_0 ),
        .Q(\msr_reg_n_0_[0] ),
        .R(msr_reg0));
  FDRE \msr_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[1]_i_1_n_0 ),
        .Q(p_0_in37_in),
        .R(msr_reg0));
  FDRE \msr_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[2]_i_1_n_0 ),
        .Q(p_0_in38_in),
        .R(msr_reg0));
  FDRE \msr_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[3]_i_1_n_0 ),
        .Q(p_0_in39_in),
        .R(msr_reg0));
  FDRE \msr_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[4]_i_1_n_0 ),
        .Q(\msr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \msr_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[5]_i_1_n_0 ),
        .Q(p_0_in0_in),
        .R(1'b0));
  FDRE \msr_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[6]_i_1_n_0 ),
        .Q(p_0_in2_in),
        .R(1'b0));
  FDRE \msr_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\msr[7]_i_1_n_0 ),
        .Q(p_0_in5_in),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'hB)) 
    out1n_INST_0
       (.I0(p_0_in8_in),
        .I1(\mcr_reg_n_0_[2] ),
        .O(out1n));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'hB)) 
    out2n_INST_0
       (.I0(p_0_in8_in),
        .I1(\mcr_reg_n_0_[3] ),
        .O(out2n));
  FDRE rd_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Rd),
        .Q(rd_d),
        .R(1'b0));
  FDRE riN_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(rin),
        .Q(riN_d),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'hB)) 
    rtsn_INST_0
       (.I0(p_0_in8_in),
        .I1(p_0_in_0),
        .O(rtsn));
  sensors96b_axi_uart16550_0_0_rx16550 rx16550_1
       (.D({rx16550_1_n_20,rx16550_1_n_21,rx16550_1_n_22}),
        .\Dout_reg[6] ({Rbr[6],Rbr[3:0]}),
        .\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .\GENERATING_FIFOS.fcr_reg[7] (\Dout[7]_i_7_n_0 ),
        .\INFERRED_GEN.cnt_i_reg[4] (rx_fifo_empty),
        .\Lcr_reg[1] (tx16550_1_n_4),
        .\Lcr_reg[5] (\Dout[5]_i_2_n_0 ),
        .\Lcr_reg[7] ({\Lcr_reg_n_0_[7] ,\Lcr_reg_n_0_[5] ,\Lcr_reg_n_0_[4] ,p_5_in36_in,\Lcr_reg_n_0_[2] ,\Lcr_reg_n_0_[1] ,\Lcr_reg_n_0_[0] }),
        .Q(p_0_in8_in),
        .Rx_error_in_fifo0(\rx_fifo_control_1/Rx_error_in_fifo0 ),
        .SR(\rx_fifo_control_1/character_counter_rst ),
        .\addr_d_reg[0] (\Dout[7]_i_3_n_0 ),
        .\addr_d_reg[0]_0 (\Dout[7]_i_4_n_0 ),
        .\addr_d_reg[0]_1 (\Dout[5]_i_4_n_0 ),
        .baudoutN_int_i(baudoutN_int_i),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .character_received(character_received),
        .clk1x_reg_0(rx16550_1_n_13),
        .clk1x_reg_1(rx16550_1_n_14),
        .clk1x_reg_2(rx16550_1_n_15),
        .clk1x_reg_3(rx16550_1_n_16),
        .clockDiv(clockDiv),
        .\dlm_reg[4] (\Dout[4]_i_2_n_0 ),
        .\iir_reg[7] (\Dout[7]_i_8_n_0 ),
        .in({rx_fifo_data_in[10],rx_fifo_data_in[9],rx_fifo_data_in[8],rx_fifo_data_in[7],rx_fifo_data_in[6],rx_fifo_data_in[5],rx_fifo_data_in[4],rx_fifo_data_in[3],rx_fifo_data_in[2],rx_fifo_data_in[1],rx_fifo_data_in[0]}),
        .\lsr_reg[7] (\Dout[7]_i_5_n_0 ),
        .mcr4_d(mcr4_d),
        .\mcr_reg[4] (\Dout[4]_i_3_n_0 ),
        .out({rx_fifo_data_out[7],rx_fifo_data_out[5:4]}),
        .p_0_in(p_0_in),
        .p_0_in5_in(p_0_in5_in),
        .rx_fifo_full(rx_fifo_full),
        .rx_fifo_rd_en_d(rx_fifo_rd_en_d),
        .rx_fifo_rst(rx_fifo_rst),
        .rx_fifo_wr_en_i(rx_fifo_wr_en_i),
        .rx_sin(rx_sin),
        .s_axi_aclk(s_axi_aclk),
        .\scr_reg[5] (\Dout[5]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h7F)) 
    rxrdyN_int_i_2
       (.I0(\GENERATING_FIFOS.fcr_reg_n_0_[3] ),
        .I1(\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .I2(rxrdyn),
        .O(rxrdyN_int_i_2_n_0));
  FDSE rxrdyN_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_21 ),
        .Q(rxrdyn),
        .S(bus2ip_reset_int_core));
  LUT5 #(
    .INIT(32'h80000000)) 
    \scr[7]_i_1 
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[3]),
        .I3(L[1]),
        .I4(L[2]),
        .O(scr0));
  FDRE \scr_reg[0] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(\d_d_reg_n_0_[0] ),
        .Q(scr[0]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[1] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(\d_d_reg_n_0_[1] ),
        .Q(scr[1]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[2] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(\d_d_reg_n_0_[2] ),
        .Q(scr[2]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[3] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(\d_d_reg_n_0_[3] ),
        .Q(scr[3]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[4] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(p_3_in),
        .Q(scr[4]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[5] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(\d_d_reg_n_0_[5] ),
        .Q(scr[5]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[6] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(p_2_in[5]),
        .Q(scr[6]),
        .R(bus2ip_reset_int_core));
  FDRE \scr_reg[7] 
       (.C(s_axi_aclk),
        .CE(scr0),
        .D(p_2_in[6]),
        .Q(scr[7]),
        .R(bus2ip_reset_int_core));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    thre_iir_set_i_2
       (.I0(iir[2]),
        .I1(iir[0]),
        .I2(iir[3]),
        .I3(Ddis_i_1_n_0),
        .I4(\Dout[2]_i_8_n_0 ),
        .I5(iir[1]),
        .O(thre_iir_set_i_2_n_0));
  LUT4 #(
    .INIT(16'hBAAA)) 
    thre_iir_set_i_3
       (.I0(bus2ip_reset_int_core),
        .I1(ier1_d),
        .I2(p_2_in51_in),
        .I3(ier[1]),
        .O(thre_iir_set_i_3_n_0));
  FDRE thre_iir_set_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.rx_fifo_block_1_n_6 ),
        .Q(thre_iir_set),
        .R(1'b0));
  sensors96b_axi_uart16550_0_0_tx16550 tx16550_1
       (.\FSM_sequential_transmit_state_reg[3]_0 (tx16550_1_n_4),
        .\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .\INFERRED_GEN.cnt_i_reg[2] (tx16550_1_n_5),
        .\INFERRED_GEN.cnt_i_reg[4] (tx_fifo_empty),
        .Q({\Lcr_reg_n_0_[6] ,\Lcr_reg_n_0_[5] ,\Lcr_reg_n_0_[4] ,p_5_in36_in,\Lcr_reg_n_0_[2] ,\Lcr_reg_n_0_[1] ,\Lcr_reg_n_0_[0] }),
        .\Thr_reg[7] (tx_fifo_data_out[7]),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .freeze(freeze),
        .\lsr_reg[5] (xuart_tx_load_sm_1_n_1),
        .\mcr_reg[4] (p_0_in8_in),
        .out(tx16550_1_n_0),
        .p_0_in(p_0_in),
        .rx_sin(rx_sin),
        .s_axi_aclk(s_axi_aclk),
        .sin(sin),
        .sout(sout),
        .\tsr_int_reg[0] (xuart_tx_load_sm_1_n_9),
        .\tsr_int_reg[1] (xuart_tx_load_sm_1_n_8),
        .\tsr_int_reg[2] (xuart_tx_load_sm_1_n_7),
        .\tsr_int_reg[3] (xuart_tx_load_sm_1_n_6),
        .\tsr_int_reg[4] (xuart_tx_load_sm_1_n_5),
        .\tsr_int_reg[5] (xuart_tx_load_sm_1_n_4),
        .\tsr_int_reg[6] (xuart_tx_load_sm_1_n_2),
        .\tsr_int_reg[7] (tsr_int),
        .tx_empty(tx_empty),
        .tx_fifo_rd_en_int(tx_fifo_rd_en_int));
  FDRE txrdyN_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\GENERATING_FIFOS.tx_fifo_block_1_n_1 ),
        .Q(txrdyn),
        .R(bus2ip_reset_int_core));
  FDRE wr_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Wr),
        .Q(wr_d),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    writing_thr_i_1
       (.I0(wr_d),
        .I1(chipSelect),
        .I2(L[0]),
        .I3(L[2]),
        .I4(L[1]),
        .I5(L[3]),
        .O(Thr0));
  FDRE writing_thr_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Thr0),
        .Q(writing_thr),
        .R(bus2ip_reset_int_core));
  sensors96b_axi_uart16550_0_0_xuart_tx_load_sm xuart_tx_load_sm_1
       (.\FSM_sequential_transmit_state_reg[0] (xuart_tx_load_sm_1_n_1),
        .\FSM_sequential_transmit_state_reg[3] (tx16550_1_n_0),
        .\GENERATING_FIFOS.fcr_reg[0] (\GENERATING_FIFOS.fcr_reg_n_0_[0] ),
        .\INFERRED_GEN.cnt_i_reg[4] (tx_fifo_empty),
        .Q(p_2_in[5]),
        .\Thr_reg[7] (Thr),
        .\addr_d_reg[2] (\lsr[2]_i_3_n_0 ),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .chipSelect(chipSelect),
        .freeze(freeze),
        .\lsr_reg[5] (xuart_tx_load_sm_1_n_10),
        .\lsr_reg[6] (xuart_tx_load_sm_1_n_0),
        .\lsr_reg[6]_0 (\lsr_reg_n_0_[6] ),
        .out(tx_fifo_data_out[6:0]),
        .p_2_in51_in(p_2_in51_in),
        .s_axi_aclk(s_axi_aclk),
        .\tsr_reg[0] (xuart_tx_load_sm_1_n_9),
        .\tsr_reg[1] (xuart_tx_load_sm_1_n_8),
        .\tsr_reg[2] (xuart_tx_load_sm_1_n_7),
        .\tsr_reg[3] (xuart_tx_load_sm_1_n_6),
        .\tsr_reg[4] (xuart_tx_load_sm_1_n_5),
        .\tsr_reg[5] (xuart_tx_load_sm_1_n_4),
        .\tsr_reg[6] (xuart_tx_load_sm_1_n_2),
        .\tsr_reg[7] (tsr_int),
        .tx_empty(tx_empty),
        .tx_fifo_rd_en_int(tx_fifo_rd_en_int),
        .wr_d(wr_d),
        .writing_thr(writing_thr));
endmodule

(* ORIG_REF_NAME = "xuart" *) 
module sensors96b_axi_uart16550_0_0_xuart
   (baudoutn,
    ip2intc_irpt,
    ddis,
    txrdyn,
    rxrdyn,
    wrReq_d1,
    s_axi_wready,
    s_axi_arready,
    sout,
    Q,
    rtsn,
    dtrn,
    out1n,
    out2n,
    s_axi_aclk,
    bus2ip_reset_int_core,
    Wr,
    ctsn,
    dsrn,
    rin,
    dcdn,
    bus2ip_wrce_i,
    bus2ip_rdce_i,
    ce_out_i,
    s_axi_wdata,
    \bus2ip_addr_i_reg[4] ,
    freeze,
    sin);
  output baudoutn;
  output ip2intc_irpt;
  output ddis;
  output txrdyn;
  output rxrdyn;
  output wrReq_d1;
  output s_axi_wready;
  output s_axi_arready;
  output sout;
  output [7:0]Q;
  output rtsn;
  output dtrn;
  output out1n;
  output out2n;
  input s_axi_aclk;
  input bus2ip_reset_int_core;
  input Wr;
  input ctsn;
  input dsrn;
  input rin;
  input dcdn;
  input bus2ip_wrce_i;
  input bus2ip_rdce_i;
  input ce_out_i;
  input [7:0]s_axi_wdata;
  input [2:0]\bus2ip_addr_i_reg[4] ;
  input freeze;
  input sin;

  wire [7:0]Q;
  wire Rd;
  wire Wr;
  wire baudoutn;
  wire [2:0]\bus2ip_addr_i_reg[4] ;
  wire bus2ip_rdce_i;
  wire bus2ip_reset_int_core;
  wire bus2ip_wrce_i;
  wire ce_out_i;
  wire ctsn;
  wire dcdn;
  wire ddis;
  wire dsrn;
  wire dtrn;
  wire freeze;
  wire ip2intc_irpt;
  wire out1n;
  wire out2n;
  wire rin;
  wire rtsn;
  wire rxrdyn;
  wire s_axi_aclk;
  wire s_axi_arready;
  wire [7:0]s_axi_wdata;
  wire s_axi_wready;
  wire sin;
  wire sout;
  wire txrdyn;
  wire wrReq_d1;

  sensors96b_axi_uart16550_0_0_ipic_if IPIC_IF_I_1
       (.Rd(Rd),
        .bus2ip_rdce_i(bus2ip_rdce_i),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .bus2ip_wrce_i(bus2ip_wrce_i),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_arready(s_axi_arready),
        .s_axi_wready(s_axi_wready),
        .wrReq_d1(wrReq_d1));
  sensors96b_axi_uart16550_0_0_uart16550 UART16550_I_1
       (.Q(Q),
        .Rd(Rd),
        .Wr(Wr),
        .baudoutn(baudoutn),
        .\bus2ip_addr_i_reg[4] (\bus2ip_addr_i_reg[4] ),
        .bus2ip_reset_int_core(bus2ip_reset_int_core),
        .ce_out_i(ce_out_i),
        .ctsn(ctsn),
        .dcdn(dcdn),
        .ddis(ddis),
        .dsrn(dsrn),
        .dtrn(dtrn),
        .freeze(freeze),
        .ip2intc_irpt(ip2intc_irpt),
        .out1n(out1n),
        .out2n(out2n),
        .rin(rin),
        .rtsn(rtsn),
        .rxrdyn(rxrdyn),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_wdata(s_axi_wdata),
        .sin(sin),
        .sout(sout),
        .txrdyn(txrdyn));
endmodule

(* ORIG_REF_NAME = "xuart_tx_load_sm" *) 
module sensors96b_axi_uart16550_0_0_xuart_tx_load_sm
   (\lsr_reg[6] ,
    \FSM_sequential_transmit_state_reg[0] ,
    \tsr_reg[6] ,
    \tsr_reg[7] ,
    \tsr_reg[5] ,
    \tsr_reg[4] ,
    \tsr_reg[3] ,
    \tsr_reg[2] ,
    \tsr_reg[1] ,
    \tsr_reg[0] ,
    \lsr_reg[5] ,
    bus2ip_reset_int_core,
    s_axi_aclk,
    Q,
    \addr_d_reg[2] ,
    chipSelect,
    wr_d,
    \lsr_reg[6]_0 ,
    \GENERATING_FIFOS.fcr_reg[0] ,
    tx_fifo_rd_en_int,
    p_2_in51_in,
    freeze,
    tx_empty,
    writing_thr,
    out,
    \FSM_sequential_transmit_state_reg[3] ,
    \INFERRED_GEN.cnt_i_reg[4] ,
    \Thr_reg[7] );
  output \lsr_reg[6] ;
  output \FSM_sequential_transmit_state_reg[0] ;
  output \tsr_reg[6] ;
  output [0:0]\tsr_reg[7] ;
  output \tsr_reg[5] ;
  output \tsr_reg[4] ;
  output \tsr_reg[3] ;
  output \tsr_reg[2] ;
  output \tsr_reg[1] ;
  output \tsr_reg[0] ;
  output \lsr_reg[5] ;
  input bus2ip_reset_int_core;
  input s_axi_aclk;
  input [0:0]Q;
  input \addr_d_reg[2] ;
  input chipSelect;
  input wr_d;
  input \lsr_reg[6]_0 ;
  input \GENERATING_FIFOS.fcr_reg[0] ;
  input tx_fifo_rd_en_int;
  input p_2_in51_in;
  input freeze;
  input tx_empty;
  input writing_thr;
  input [6:0]out;
  input [0:0]\FSM_sequential_transmit_state_reg[3] ;
  input [0:0]\INFERRED_GEN.cnt_i_reg[4] ;
  input [7:0]\Thr_reg[7] ;

  wire \FSM_sequential_transmit_state_reg[0] ;
  wire [0:0]\FSM_sequential_transmit_state_reg[3] ;
  wire \GENERATING_FIFOS.fcr_reg[0] ;
  wire [0:0]\INFERRED_GEN.cnt_i_reg[4] ;
  wire [0:0]Q;
  wire [7:0]\Thr_reg[7] ;
  wire Thre;
  wire Tsre;
  wire \addr_d_reg[2] ;
  wire bus2ip_reset_int_core;
  wire chipSelect;
  (* RTL_KEEP = "yes" *) wire [1:0]current_state;
  wire freeze;
  wire \lsr[6]_i_2_n_0 ;
  wire lsr_reg027_out;
  wire \lsr_reg[5] ;
  wire \lsr_reg[6] ;
  wire \lsr_reg[6]_0 ;
  wire [1:0]next_state;
  wire [6:0]out;
  wire p_2_in51_in;
  wire s_axi_aclk;
  wire thre_com;
  wire tsr_com;
  wire [6:0]tsr_int;
  wire \tsr_reg[0] ;
  wire \tsr_reg[1] ;
  wire \tsr_reg[2] ;
  wire \tsr_reg[3] ;
  wire \tsr_reg[4] ;
  wire \tsr_reg[5] ;
  wire \tsr_reg[6] ;
  wire [0:0]\tsr_reg[7] ;
  wire tsre_com;
  wire tx_empty;
  wire tx_fifo_rd_en_int;
  wire wr_d;
  wire writing_thr;

  LUT3 #(
    .INIT(8'hB8)) 
    \FSM_sequential_current_state[0]_i_1 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .I2(writing_thr),
        .O(next_state[0]));
  LUT3 #(
    .INIT(8'h72)) 
    \FSM_sequential_current_state[1]_i_1 
       (.I0(current_state[1]),
        .I1(tx_fifo_rd_en_int),
        .I2(current_state[0]),
        .O(next_state[1]));
  (* FSM_ENCODED_STATES = "full_empty:10,empty_empty:00,full_full:11,empty_full:01" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_current_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(next_state[0]),
        .Q(current_state[0]),
        .R(bus2ip_reset_int_core));
  (* FSM_ENCODED_STATES = "full_empty:10,empty_empty:00,full_full:11,empty_full:01" *) 
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_current_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(next_state[1]),
        .Q(current_state[1]),
        .R(bus2ip_reset_int_core));
  LUT4 #(
    .INIT(16'hEEFC)) 
    \FSM_sequential_transmit_state[0]_i_2 
       (.I0(p_2_in51_in),
        .I1(freeze),
        .I2(Tsre),
        .I3(\GENERATING_FIFOS.fcr_reg[0] ),
        .O(\FSM_sequential_transmit_state_reg[0] ));
  LUT3 #(
    .INIT(8'h1D)) 
    Thre_i_1
       (.I0(writing_thr),
        .I1(current_state[0]),
        .I2(current_state[1]),
        .O(thre_com));
  FDSE Thre_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(thre_com),
        .Q(Thre),
        .S(bus2ip_reset_int_core));
  LUT3 #(
    .INIT(8'hC5)) 
    Tsre_i_1
       (.I0(current_state[0]),
        .I1(tx_fifo_rd_en_int),
        .I2(current_state[1]),
        .O(tsre_com));
  FDSE Tsre_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(tsre_com),
        .Q(Tsre),
        .S(bus2ip_reset_int_core));
  LUT3 #(
    .INIT(8'hE2)) 
    \lsr[5]_i_1 
       (.I0(Thre),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(\INFERRED_GEN.cnt_i_reg[4] ),
        .O(\lsr_reg[5] ));
  LUT6 #(
    .INIT(64'h7222000000000000)) 
    \lsr[6]_i_1 
       (.I0(\GENERATING_FIFOS.fcr_reg[0] ),
        .I1(tx_fifo_rd_en_int),
        .I2(Thre),
        .I3(Tsre),
        .I4(\lsr[6]_i_2_n_0 ),
        .I5(p_2_in51_in),
        .O(\lsr_reg[6] ));
  LUT6 #(
    .INIT(64'hFFFFEFFFFFFF2000)) 
    \lsr[6]_i_2 
       (.I0(Q),
        .I1(\addr_d_reg[2] ),
        .I2(chipSelect),
        .I3(wr_d),
        .I4(lsr_reg027_out),
        .I5(\lsr_reg[6]_0 ),
        .O(\lsr[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0008888)) 
    \lsr[6]_i_3 
       (.I0(Tsre),
        .I1(Thre),
        .I2(tx_empty),
        .I3(p_2_in51_in),
        .I4(\GENERATING_FIFOS.fcr_reg[0] ),
        .I5(bus2ip_reset_int_core),
        .O(lsr_reg027_out));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[0]_i_2 
       (.I0(tsr_int[0]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[0]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[0] ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[1]_i_2 
       (.I0(tsr_int[1]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[1]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[1] ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[2]_i_2 
       (.I0(tsr_int[2]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[2]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[2] ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[3]_i_2 
       (.I0(tsr_int[3]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[3]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[3] ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[4]_i_2 
       (.I0(tsr_int[4]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[4]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[4] ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[5]_i_2 
       (.I0(tsr_int[5]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[5]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[5] ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \tsr[6]_i_2 
       (.I0(tsr_int[6]),
        .I1(\GENERATING_FIFOS.fcr_reg[0] ),
        .I2(out[6]),
        .I3(\FSM_sequential_transmit_state_reg[3] ),
        .O(\tsr_reg[6] ));
  LUT3 #(
    .INIT(8'h54)) 
    \tsr_int[7]_i_1 
       (.I0(current_state[1]),
        .I1(current_state[0]),
        .I2(writing_thr),
        .O(tsr_com));
  FDSE \tsr_int_reg[0] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [0]),
        .Q(tsr_int[0]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[1] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [1]),
        .Q(tsr_int[1]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[2] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [2]),
        .Q(tsr_int[2]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[3] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [3]),
        .Q(tsr_int[3]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[4] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [4]),
        .Q(tsr_int[4]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[5] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [5]),
        .Q(tsr_int[5]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[6] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [6]),
        .Q(tsr_int[6]),
        .S(bus2ip_reset_int_core));
  FDSE \tsr_int_reg[7] 
       (.C(s_axi_aclk),
        .CE(tsr_com),
        .D(\Thr_reg[7] [7]),
        .Q(\tsr_reg[7] ),
        .S(bus2ip_reset_int_core));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
