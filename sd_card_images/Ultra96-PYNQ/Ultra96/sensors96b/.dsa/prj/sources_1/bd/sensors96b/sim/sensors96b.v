//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Thu Jun  6 17:06:39 2019
//Host        : joe-ubu-vm running 64-bit Ubuntu 18.04.2 LTS
//Command     : generate_target sensors96b.bd
//Design      : sensors96b
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module s00_couplers_imp_1EEP9YN
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [39:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [39:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [39:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [15:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [39:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [15:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [15:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output [15:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [39:0]auto_pc_to_s00_couplers_ARADDR;
  wire auto_pc_to_s00_couplers_ARREADY;
  wire auto_pc_to_s00_couplers_ARVALID;
  wire [39:0]auto_pc_to_s00_couplers_AWADDR;
  wire auto_pc_to_s00_couplers_AWREADY;
  wire auto_pc_to_s00_couplers_AWVALID;
  wire auto_pc_to_s00_couplers_BREADY;
  wire [1:0]auto_pc_to_s00_couplers_BRESP;
  wire auto_pc_to_s00_couplers_BVALID;
  wire [31:0]auto_pc_to_s00_couplers_RDATA;
  wire auto_pc_to_s00_couplers_RREADY;
  wire [1:0]auto_pc_to_s00_couplers_RRESP;
  wire auto_pc_to_s00_couplers_RVALID;
  wire [31:0]auto_pc_to_s00_couplers_WDATA;
  wire auto_pc_to_s00_couplers_WREADY;
  wire [3:0]auto_pc_to_s00_couplers_WSTRB;
  wire auto_pc_to_s00_couplers_WVALID;
  wire [39:0]s00_couplers_to_auto_pc_ARADDR;
  wire [1:0]s00_couplers_to_auto_pc_ARBURST;
  wire [3:0]s00_couplers_to_auto_pc_ARCACHE;
  wire [15:0]s00_couplers_to_auto_pc_ARID;
  wire [7:0]s00_couplers_to_auto_pc_ARLEN;
  wire s00_couplers_to_auto_pc_ARLOCK;
  wire [2:0]s00_couplers_to_auto_pc_ARPROT;
  wire [3:0]s00_couplers_to_auto_pc_ARQOS;
  wire s00_couplers_to_auto_pc_ARREADY;
  wire [2:0]s00_couplers_to_auto_pc_ARSIZE;
  wire s00_couplers_to_auto_pc_ARVALID;
  wire [39:0]s00_couplers_to_auto_pc_AWADDR;
  wire [1:0]s00_couplers_to_auto_pc_AWBURST;
  wire [3:0]s00_couplers_to_auto_pc_AWCACHE;
  wire [15:0]s00_couplers_to_auto_pc_AWID;
  wire [7:0]s00_couplers_to_auto_pc_AWLEN;
  wire s00_couplers_to_auto_pc_AWLOCK;
  wire [2:0]s00_couplers_to_auto_pc_AWPROT;
  wire [3:0]s00_couplers_to_auto_pc_AWQOS;
  wire s00_couplers_to_auto_pc_AWREADY;
  wire [2:0]s00_couplers_to_auto_pc_AWSIZE;
  wire s00_couplers_to_auto_pc_AWVALID;
  wire [15:0]s00_couplers_to_auto_pc_BID;
  wire s00_couplers_to_auto_pc_BREADY;
  wire [1:0]s00_couplers_to_auto_pc_BRESP;
  wire s00_couplers_to_auto_pc_BVALID;
  wire [31:0]s00_couplers_to_auto_pc_RDATA;
  wire [15:0]s00_couplers_to_auto_pc_RID;
  wire s00_couplers_to_auto_pc_RLAST;
  wire s00_couplers_to_auto_pc_RREADY;
  wire [1:0]s00_couplers_to_auto_pc_RRESP;
  wire s00_couplers_to_auto_pc_RVALID;
  wire [31:0]s00_couplers_to_auto_pc_WDATA;
  wire s00_couplers_to_auto_pc_WLAST;
  wire s00_couplers_to_auto_pc_WREADY;
  wire [3:0]s00_couplers_to_auto_pc_WSTRB;
  wire s00_couplers_to_auto_pc_WVALID;

  assign M_AXI_araddr[39:0] = auto_pc_to_s00_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[39:0] = auto_pc_to_s00_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_s00_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_s00_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_s00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_s00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s00_couplers_to_auto_pc_ARREADY;
  assign S_AXI_awready = s00_couplers_to_auto_pc_AWREADY;
  assign S_AXI_bid[15:0] = s00_couplers_to_auto_pc_BID;
  assign S_AXI_bresp[1:0] = s00_couplers_to_auto_pc_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_auto_pc_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_auto_pc_RDATA;
  assign S_AXI_rid[15:0] = s00_couplers_to_auto_pc_RID;
  assign S_AXI_rlast = s00_couplers_to_auto_pc_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_auto_pc_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_auto_pc_RVALID;
  assign S_AXI_wready = s00_couplers_to_auto_pc_WREADY;
  assign auto_pc_to_s00_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_s00_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_s00_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_s00_couplers_WREADY = M_AXI_wready;
  assign s00_couplers_to_auto_pc_ARADDR = S_AXI_araddr[39:0];
  assign s00_couplers_to_auto_pc_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_auto_pc_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_auto_pc_ARID = S_AXI_arid[15:0];
  assign s00_couplers_to_auto_pc_ARLEN = S_AXI_arlen[7:0];
  assign s00_couplers_to_auto_pc_ARLOCK = S_AXI_arlock;
  assign s00_couplers_to_auto_pc_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_auto_pc_ARQOS = S_AXI_arqos[3:0];
  assign s00_couplers_to_auto_pc_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_auto_pc_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_auto_pc_AWADDR = S_AXI_awaddr[39:0];
  assign s00_couplers_to_auto_pc_AWBURST = S_AXI_awburst[1:0];
  assign s00_couplers_to_auto_pc_AWCACHE = S_AXI_awcache[3:0];
  assign s00_couplers_to_auto_pc_AWID = S_AXI_awid[15:0];
  assign s00_couplers_to_auto_pc_AWLEN = S_AXI_awlen[7:0];
  assign s00_couplers_to_auto_pc_AWLOCK = S_AXI_awlock;
  assign s00_couplers_to_auto_pc_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_auto_pc_AWQOS = S_AXI_awqos[3:0];
  assign s00_couplers_to_auto_pc_AWSIZE = S_AXI_awsize[2:0];
  assign s00_couplers_to_auto_pc_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_auto_pc_BREADY = S_AXI_bready;
  assign s00_couplers_to_auto_pc_RREADY = S_AXI_rready;
  assign s00_couplers_to_auto_pc_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_auto_pc_WLAST = S_AXI_wlast;
  assign s00_couplers_to_auto_pc_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_auto_pc_WVALID = S_AXI_wvalid;
  sensors96b_auto_pc_0 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_s00_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_s00_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_s00_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_s00_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_s00_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_s00_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_s00_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_s00_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_s00_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_s00_couplers_RDATA),
        .m_axi_rready(auto_pc_to_s00_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_s00_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_s00_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_s00_couplers_WDATA),
        .m_axi_wready(auto_pc_to_s00_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_s00_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_s00_couplers_WVALID),
        .s_axi_araddr(s00_couplers_to_auto_pc_ARADDR),
        .s_axi_arburst(s00_couplers_to_auto_pc_ARBURST),
        .s_axi_arcache(s00_couplers_to_auto_pc_ARCACHE),
        .s_axi_arid(s00_couplers_to_auto_pc_ARID),
        .s_axi_arlen(s00_couplers_to_auto_pc_ARLEN),
        .s_axi_arlock(s00_couplers_to_auto_pc_ARLOCK),
        .s_axi_arprot(s00_couplers_to_auto_pc_ARPROT),
        .s_axi_arqos(s00_couplers_to_auto_pc_ARQOS),
        .s_axi_arready(s00_couplers_to_auto_pc_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s00_couplers_to_auto_pc_ARSIZE),
        .s_axi_arvalid(s00_couplers_to_auto_pc_ARVALID),
        .s_axi_awaddr(s00_couplers_to_auto_pc_AWADDR),
        .s_axi_awburst(s00_couplers_to_auto_pc_AWBURST),
        .s_axi_awcache(s00_couplers_to_auto_pc_AWCACHE),
        .s_axi_awid(s00_couplers_to_auto_pc_AWID),
        .s_axi_awlen(s00_couplers_to_auto_pc_AWLEN),
        .s_axi_awlock(s00_couplers_to_auto_pc_AWLOCK),
        .s_axi_awprot(s00_couplers_to_auto_pc_AWPROT),
        .s_axi_awqos(s00_couplers_to_auto_pc_AWQOS),
        .s_axi_awready(s00_couplers_to_auto_pc_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s00_couplers_to_auto_pc_AWSIZE),
        .s_axi_awvalid(s00_couplers_to_auto_pc_AWVALID),
        .s_axi_bid(s00_couplers_to_auto_pc_BID),
        .s_axi_bready(s00_couplers_to_auto_pc_BREADY),
        .s_axi_bresp(s00_couplers_to_auto_pc_BRESP),
        .s_axi_bvalid(s00_couplers_to_auto_pc_BVALID),
        .s_axi_rdata(s00_couplers_to_auto_pc_RDATA),
        .s_axi_rid(s00_couplers_to_auto_pc_RID),
        .s_axi_rlast(s00_couplers_to_auto_pc_RLAST),
        .s_axi_rready(s00_couplers_to_auto_pc_RREADY),
        .s_axi_rresp(s00_couplers_to_auto_pc_RRESP),
        .s_axi_rvalid(s00_couplers_to_auto_pc_RVALID),
        .s_axi_wdata(s00_couplers_to_auto_pc_WDATA),
        .s_axi_wlast(s00_couplers_to_auto_pc_WLAST),
        .s_axi_wready(s00_couplers_to_auto_pc_WREADY),
        .s_axi_wstrb(s00_couplers_to_auto_pc_WSTRB),
        .s_axi_wvalid(s00_couplers_to_auto_pc_WVALID));
endmodule

(* CORE_GENERATION_INFO = "sensors96b,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=sensors96b,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=2,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "sensors96b.hwdef" *) 
module sensors96b
   (BT_ctsn,
    BT_rtsn,
    GPIO_SENSORS_tri_i,
    GPIO_SENSORS_tri_o,
    GPIO_SENSORS_tri_t,
    UART0_ctsn,
    UART0_rtsn,
    UART0_rxd,
    UART0_txd,
    UART1_rxd,
    UART1_txd);
  input BT_ctsn;
  output BT_rtsn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SENSORS TRI_I" *) input [5:0]GPIO_SENSORS_tri_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SENSORS TRI_O" *) output [5:0]GPIO_SENSORS_tri_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_SENSORS TRI_T" *) output [5:0]GPIO_SENSORS_tri_t;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.UART0_CTSN DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.UART0_CTSN, LAYERED_METADATA undef" *) input UART0_ctsn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.UART0_RTSN DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.UART0_RTSN, LAYERED_METADATA undef" *) output UART0_rtsn;
  input UART0_rxd;
  output UART0_txd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART1 RxD" *) input UART1_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART1 TxD" *) output UART1_txd;

  wire UART0_ctsn;
  wire axi_uart16550_0_ip2intc_irpt;
  wire axi_uart16550_0_rtsn;
  wire axi_uart16550_0_sout;
  wire emio_uart0_ctsn_1;
  wire [0:0]proc_sys_reset_0_interconnect_aresetn;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire [39:0]ps8_0_axi_periph_M00_AXI_ARADDR;
  wire ps8_0_axi_periph_M00_AXI_ARREADY;
  wire ps8_0_axi_periph_M00_AXI_ARVALID;
  wire [39:0]ps8_0_axi_periph_M00_AXI_AWADDR;
  wire ps8_0_axi_periph_M00_AXI_AWREADY;
  wire ps8_0_axi_periph_M00_AXI_AWVALID;
  wire ps8_0_axi_periph_M00_AXI_BREADY;
  wire [1:0]ps8_0_axi_periph_M00_AXI_BRESP;
  wire ps8_0_axi_periph_M00_AXI_BVALID;
  wire [31:0]ps8_0_axi_periph_M00_AXI_RDATA;
  wire ps8_0_axi_periph_M00_AXI_RREADY;
  wire [1:0]ps8_0_axi_periph_M00_AXI_RRESP;
  wire ps8_0_axi_periph_M00_AXI_RVALID;
  wire [31:0]ps8_0_axi_periph_M00_AXI_WDATA;
  wire ps8_0_axi_periph_M00_AXI_WREADY;
  wire [3:0]ps8_0_axi_periph_M00_AXI_WSTRB;
  wire ps8_0_axi_periph_M00_AXI_WVALID;
  wire sin_1;
  wire [0:0]xlconcat_0_dout;
  wire [5:0]zynq_ultra_ps_e_0_GPIO_0_TRI_I;
  wire [5:0]zynq_ultra_ps_e_0_GPIO_0_TRI_O;
  wire [5:0]zynq_ultra_ps_e_0_GPIO_0_TRI_T;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID;
  wire [39:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID;
  wire [7:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY;
  wire [2:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID;
  wire [31:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA;
  wire [15:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY;
  wire [1:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID;
  wire [31:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY;
  wire [3:0]zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB;
  wire zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID;
  wire zynq_ultra_ps_e_0_UART_1_RxD;
  wire zynq_ultra_ps_e_0_UART_1_TxD;
  wire zynq_ultra_ps_e_0_emio_uart0_rtsn;
  wire zynq_ultra_ps_e_0_pl_clk0;
  wire zynq_ultra_ps_e_0_pl_resetn0;

  assign BT_rtsn = zynq_ultra_ps_e_0_emio_uart0_rtsn;
  assign GPIO_SENSORS_tri_o[5:0] = zynq_ultra_ps_e_0_GPIO_0_TRI_O;
  assign GPIO_SENSORS_tri_t[5:0] = zynq_ultra_ps_e_0_GPIO_0_TRI_T;
  assign UART0_rtsn = axi_uart16550_0_rtsn;
  assign UART0_txd = axi_uart16550_0_sout;
  assign UART1_txd = zynq_ultra_ps_e_0_UART_1_TxD;
  assign emio_uart0_ctsn_1 = BT_ctsn;
  assign sin_1 = UART0_rxd;
  assign zynq_ultra_ps_e_0_GPIO_0_TRI_I = GPIO_SENSORS_tri_i[5:0];
  assign zynq_ultra_ps_e_0_UART_1_RxD = UART1_rxd;
  sensors96b_axi_uart16550_0_0 axi_uart16550_0
       (.ctsn(UART0_ctsn),
        .dcdn(1'b1),
        .dsrn(1'b1),
        .freeze(1'b0),
        .ip2intc_irpt(axi_uart16550_0_ip2intc_irpt),
        .rin(1'b1),
        .rtsn(axi_uart16550_0_rtsn),
        .s_axi_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .s_axi_araddr(ps8_0_axi_periph_M00_AXI_ARADDR[12:0]),
        .s_axi_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .s_axi_arready(ps8_0_axi_periph_M00_AXI_ARREADY),
        .s_axi_arvalid(ps8_0_axi_periph_M00_AXI_ARVALID),
        .s_axi_awaddr(ps8_0_axi_periph_M00_AXI_AWADDR[12:0]),
        .s_axi_awready(ps8_0_axi_periph_M00_AXI_AWREADY),
        .s_axi_awvalid(ps8_0_axi_periph_M00_AXI_AWVALID),
        .s_axi_bready(ps8_0_axi_periph_M00_AXI_BREADY),
        .s_axi_bresp(ps8_0_axi_periph_M00_AXI_BRESP),
        .s_axi_bvalid(ps8_0_axi_periph_M00_AXI_BVALID),
        .s_axi_rdata(ps8_0_axi_periph_M00_AXI_RDATA),
        .s_axi_rready(ps8_0_axi_periph_M00_AXI_RREADY),
        .s_axi_rresp(ps8_0_axi_periph_M00_AXI_RRESP),
        .s_axi_rvalid(ps8_0_axi_periph_M00_AXI_RVALID),
        .s_axi_wdata(ps8_0_axi_periph_M00_AXI_WDATA),
        .s_axi_wready(ps8_0_axi_periph_M00_AXI_WREADY),
        .s_axi_wstrb(ps8_0_axi_periph_M00_AXI_WSTRB),
        .s_axi_wvalid(ps8_0_axi_periph_M00_AXI_WVALID),
        .sin(sin_1),
        .sout(axi_uart16550_0_sout));
  sensors96b_proc_sys_reset_0_0 proc_sys_reset_0
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(zynq_ultra_ps_e_0_pl_resetn0),
        .interconnect_aresetn(proc_sys_reset_0_interconnect_aresetn),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(zynq_ultra_ps_e_0_pl_clk0));
  sensors96b_ps8_0_axi_periph_0 ps8_0_axi_periph
       (.ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .ARESETN(proc_sys_reset_0_interconnect_aresetn),
        .M00_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .M00_ARESETN(proc_sys_reset_0_peripheral_aresetn),
        .M00_AXI_araddr(ps8_0_axi_periph_M00_AXI_ARADDR),
        .M00_AXI_arready(ps8_0_axi_periph_M00_AXI_ARREADY),
        .M00_AXI_arvalid(ps8_0_axi_periph_M00_AXI_ARVALID),
        .M00_AXI_awaddr(ps8_0_axi_periph_M00_AXI_AWADDR),
        .M00_AXI_awready(ps8_0_axi_periph_M00_AXI_AWREADY),
        .M00_AXI_awvalid(ps8_0_axi_periph_M00_AXI_AWVALID),
        .M00_AXI_bready(ps8_0_axi_periph_M00_AXI_BREADY),
        .M00_AXI_bresp(ps8_0_axi_periph_M00_AXI_BRESP),
        .M00_AXI_bvalid(ps8_0_axi_periph_M00_AXI_BVALID),
        .M00_AXI_rdata(ps8_0_axi_periph_M00_AXI_RDATA),
        .M00_AXI_rready(ps8_0_axi_periph_M00_AXI_RREADY),
        .M00_AXI_rresp(ps8_0_axi_periph_M00_AXI_RRESP),
        .M00_AXI_rvalid(ps8_0_axi_periph_M00_AXI_RVALID),
        .M00_AXI_wdata(ps8_0_axi_periph_M00_AXI_WDATA),
        .M00_AXI_wready(ps8_0_axi_periph_M00_AXI_WREADY),
        .M00_AXI_wstrb(ps8_0_axi_periph_M00_AXI_WSTRB),
        .M00_AXI_wvalid(ps8_0_axi_periph_M00_AXI_WVALID),
        .S00_ACLK(zynq_ultra_ps_e_0_pl_clk0),
        .S00_ARESETN(proc_sys_reset_0_peripheral_aresetn),
        .S00_AXI_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR),
        .S00_AXI_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST),
        .S00_AXI_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE),
        .S00_AXI_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID),
        .S00_AXI_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN),
        .S00_AXI_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK),
        .S00_AXI_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT),
        .S00_AXI_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS),
        .S00_AXI_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY),
        .S00_AXI_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE),
        .S00_AXI_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID),
        .S00_AXI_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR),
        .S00_AXI_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST),
        .S00_AXI_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE),
        .S00_AXI_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID),
        .S00_AXI_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN),
        .S00_AXI_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK),
        .S00_AXI_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT),
        .S00_AXI_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS),
        .S00_AXI_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY),
        .S00_AXI_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE),
        .S00_AXI_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID),
        .S00_AXI_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID),
        .S00_AXI_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY),
        .S00_AXI_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP),
        .S00_AXI_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID),
        .S00_AXI_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA),
        .S00_AXI_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID),
        .S00_AXI_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST),
        .S00_AXI_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY),
        .S00_AXI_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP),
        .S00_AXI_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID),
        .S00_AXI_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA),
        .S00_AXI_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST),
        .S00_AXI_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY),
        .S00_AXI_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB),
        .S00_AXI_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID));
  sensors96b_xlconcat_0_0 xlconcat_0
       (.In0(axi_uart16550_0_ip2intc_irpt),
        .dout(xlconcat_0_dout));
  sensors96b_zynq_ultra_ps_e_0_0 zynq_ultra_ps_e_0
       (.emio_gpio_i(zynq_ultra_ps_e_0_GPIO_0_TRI_I),
        .emio_gpio_o(zynq_ultra_ps_e_0_GPIO_0_TRI_O),
        .emio_gpio_t(zynq_ultra_ps_e_0_GPIO_0_TRI_T),
        .emio_uart0_ctsn(emio_uart0_ctsn_1),
        .emio_uart0_dcdn(1'b0),
        .emio_uart0_dsrn(1'b0),
        .emio_uart0_rin(1'b0),
        .emio_uart0_rtsn(zynq_ultra_ps_e_0_emio_uart0_rtsn),
        .emio_uart1_rxd(zynq_ultra_ps_e_0_UART_1_RxD),
        .emio_uart1_txd(zynq_ultra_ps_e_0_UART_1_TxD),
        .maxigp2_araddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARADDR),
        .maxigp2_arburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARBURST),
        .maxigp2_arcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARCACHE),
        .maxigp2_arid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARID),
        .maxigp2_arlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLEN),
        .maxigp2_arlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARLOCK),
        .maxigp2_arprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARPROT),
        .maxigp2_arqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARQOS),
        .maxigp2_arready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARREADY),
        .maxigp2_arsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARSIZE),
        .maxigp2_arvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_ARVALID),
        .maxigp2_awaddr(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWADDR),
        .maxigp2_awburst(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWBURST),
        .maxigp2_awcache(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWCACHE),
        .maxigp2_awid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWID),
        .maxigp2_awlen(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLEN),
        .maxigp2_awlock(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWLOCK),
        .maxigp2_awprot(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWPROT),
        .maxigp2_awqos(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWQOS),
        .maxigp2_awready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY),
        .maxigp2_awsize(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWSIZE),
        .maxigp2_awvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID),
        .maxigp2_bid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BID),
        .maxigp2_bready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY),
        .maxigp2_bresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BRESP),
        .maxigp2_bvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID),
        .maxigp2_rdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RDATA),
        .maxigp2_rid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RID),
        .maxigp2_rlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RLAST),
        .maxigp2_rready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RREADY),
        .maxigp2_rresp(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RRESP),
        .maxigp2_rvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_RVALID),
        .maxigp2_wdata(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WDATA),
        .maxigp2_wlast(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WLAST),
        .maxigp2_wready(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY),
        .maxigp2_wstrb(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WSTRB),
        .maxigp2_wvalid(zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID),
        .maxihpm0_lpd_aclk(zynq_ultra_ps_e_0_pl_clk0),
        .pl_clk0(zynq_ultra_ps_e_0_pl_clk0),
        .pl_ps_irq0(xlconcat_0_dout),
        .pl_resetn0(zynq_ultra_ps_e_0_pl_resetn0));
endmodule

module sensors96b_ps8_0_axi_periph_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arid,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awid,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rid,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid);
  input ACLK;
  input ARESETN;
  input M00_ACLK;
  input M00_ARESETN;
  output [39:0]M00_AXI_araddr;
  input M00_AXI_arready;
  output M00_AXI_arvalid;
  output [39:0]M00_AXI_awaddr;
  input M00_AXI_awready;
  output M00_AXI_awvalid;
  output M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input S00_ACLK;
  input S00_ARESETN;
  input [39:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [15:0]S00_AXI_arid;
  input [7:0]S00_AXI_arlen;
  input S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [39:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [15:0]S00_AXI_awid;
  input [7:0]S00_AXI_awlen;
  input S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  output [15:0]S00_AXI_bid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  output [15:0]S00_AXI_rid;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;

  wire S00_ACLK_1;
  wire S00_ARESETN_1;
  wire ps8_0_axi_periph_ACLK_net;
  wire ps8_0_axi_periph_ARESETN_net;
  wire [39:0]ps8_0_axi_periph_to_s00_couplers_ARADDR;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_ARBURST;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_ARCACHE;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_ARID;
  wire [7:0]ps8_0_axi_periph_to_s00_couplers_ARLEN;
  wire ps8_0_axi_periph_to_s00_couplers_ARLOCK;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_ARPROT;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_ARQOS;
  wire ps8_0_axi_periph_to_s00_couplers_ARREADY;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_ARSIZE;
  wire ps8_0_axi_periph_to_s00_couplers_ARVALID;
  wire [39:0]ps8_0_axi_periph_to_s00_couplers_AWADDR;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_AWBURST;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_AWCACHE;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_AWID;
  wire [7:0]ps8_0_axi_periph_to_s00_couplers_AWLEN;
  wire ps8_0_axi_periph_to_s00_couplers_AWLOCK;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_AWPROT;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_AWQOS;
  wire ps8_0_axi_periph_to_s00_couplers_AWREADY;
  wire [2:0]ps8_0_axi_periph_to_s00_couplers_AWSIZE;
  wire ps8_0_axi_periph_to_s00_couplers_AWVALID;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_BID;
  wire ps8_0_axi_periph_to_s00_couplers_BREADY;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_BRESP;
  wire ps8_0_axi_periph_to_s00_couplers_BVALID;
  wire [31:0]ps8_0_axi_periph_to_s00_couplers_RDATA;
  wire [15:0]ps8_0_axi_periph_to_s00_couplers_RID;
  wire ps8_0_axi_periph_to_s00_couplers_RLAST;
  wire ps8_0_axi_periph_to_s00_couplers_RREADY;
  wire [1:0]ps8_0_axi_periph_to_s00_couplers_RRESP;
  wire ps8_0_axi_periph_to_s00_couplers_RVALID;
  wire [31:0]ps8_0_axi_periph_to_s00_couplers_WDATA;
  wire ps8_0_axi_periph_to_s00_couplers_WLAST;
  wire ps8_0_axi_periph_to_s00_couplers_WREADY;
  wire [3:0]ps8_0_axi_periph_to_s00_couplers_WSTRB;
  wire ps8_0_axi_periph_to_s00_couplers_WVALID;
  wire [39:0]s00_couplers_to_ps8_0_axi_periph_ARADDR;
  wire s00_couplers_to_ps8_0_axi_periph_ARREADY;
  wire s00_couplers_to_ps8_0_axi_periph_ARVALID;
  wire [39:0]s00_couplers_to_ps8_0_axi_periph_AWADDR;
  wire s00_couplers_to_ps8_0_axi_periph_AWREADY;
  wire s00_couplers_to_ps8_0_axi_periph_AWVALID;
  wire s00_couplers_to_ps8_0_axi_periph_BREADY;
  wire [1:0]s00_couplers_to_ps8_0_axi_periph_BRESP;
  wire s00_couplers_to_ps8_0_axi_periph_BVALID;
  wire [31:0]s00_couplers_to_ps8_0_axi_periph_RDATA;
  wire s00_couplers_to_ps8_0_axi_periph_RREADY;
  wire [1:0]s00_couplers_to_ps8_0_axi_periph_RRESP;
  wire s00_couplers_to_ps8_0_axi_periph_RVALID;
  wire [31:0]s00_couplers_to_ps8_0_axi_periph_WDATA;
  wire s00_couplers_to_ps8_0_axi_periph_WREADY;
  wire [3:0]s00_couplers_to_ps8_0_axi_periph_WSTRB;
  wire s00_couplers_to_ps8_0_axi_periph_WVALID;

  assign M00_AXI_araddr[39:0] = s00_couplers_to_ps8_0_axi_periph_ARADDR;
  assign M00_AXI_arvalid = s00_couplers_to_ps8_0_axi_periph_ARVALID;
  assign M00_AXI_awaddr[39:0] = s00_couplers_to_ps8_0_axi_periph_AWADDR;
  assign M00_AXI_awvalid = s00_couplers_to_ps8_0_axi_periph_AWVALID;
  assign M00_AXI_bready = s00_couplers_to_ps8_0_axi_periph_BREADY;
  assign M00_AXI_rready = s00_couplers_to_ps8_0_axi_periph_RREADY;
  assign M00_AXI_wdata[31:0] = s00_couplers_to_ps8_0_axi_periph_WDATA;
  assign M00_AXI_wstrb[3:0] = s00_couplers_to_ps8_0_axi_periph_WSTRB;
  assign M00_AXI_wvalid = s00_couplers_to_ps8_0_axi_periph_WVALID;
  assign S00_ACLK_1 = S00_ACLK;
  assign S00_ARESETN_1 = S00_ARESETN;
  assign S00_AXI_arready = ps8_0_axi_periph_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = ps8_0_axi_periph_to_s00_couplers_AWREADY;
  assign S00_AXI_bid[15:0] = ps8_0_axi_periph_to_s00_couplers_BID;
  assign S00_AXI_bresp[1:0] = ps8_0_axi_periph_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = ps8_0_axi_periph_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = ps8_0_axi_periph_to_s00_couplers_RDATA;
  assign S00_AXI_rid[15:0] = ps8_0_axi_periph_to_s00_couplers_RID;
  assign S00_AXI_rlast = ps8_0_axi_periph_to_s00_couplers_RLAST;
  assign S00_AXI_rresp[1:0] = ps8_0_axi_periph_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = ps8_0_axi_periph_to_s00_couplers_RVALID;
  assign S00_AXI_wready = ps8_0_axi_periph_to_s00_couplers_WREADY;
  assign ps8_0_axi_periph_ACLK_net = M00_ACLK;
  assign ps8_0_axi_periph_ARESETN_net = M00_ARESETN;
  assign ps8_0_axi_periph_to_s00_couplers_ARADDR = S00_AXI_araddr[39:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARBURST = S00_AXI_arburst[1:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARCACHE = S00_AXI_arcache[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARID = S00_AXI_arid[15:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARLEN = S00_AXI_arlen[7:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARLOCK = S00_AXI_arlock;
  assign ps8_0_axi_periph_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARQOS = S00_AXI_arqos[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARSIZE = S00_AXI_arsize[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign ps8_0_axi_periph_to_s00_couplers_AWADDR = S00_AXI_awaddr[39:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWBURST = S00_AXI_awburst[1:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWCACHE = S00_AXI_awcache[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWID = S00_AXI_awid[15:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWLEN = S00_AXI_awlen[7:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWLOCK = S00_AXI_awlock;
  assign ps8_0_axi_periph_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWQOS = S00_AXI_awqos[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWSIZE = S00_AXI_awsize[2:0];
  assign ps8_0_axi_periph_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign ps8_0_axi_periph_to_s00_couplers_BREADY = S00_AXI_bready;
  assign ps8_0_axi_periph_to_s00_couplers_RREADY = S00_AXI_rready;
  assign ps8_0_axi_periph_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign ps8_0_axi_periph_to_s00_couplers_WLAST = S00_AXI_wlast;
  assign ps8_0_axi_periph_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign ps8_0_axi_periph_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign s00_couplers_to_ps8_0_axi_periph_ARREADY = M00_AXI_arready;
  assign s00_couplers_to_ps8_0_axi_periph_AWREADY = M00_AXI_awready;
  assign s00_couplers_to_ps8_0_axi_periph_BRESP = M00_AXI_bresp[1:0];
  assign s00_couplers_to_ps8_0_axi_periph_BVALID = M00_AXI_bvalid;
  assign s00_couplers_to_ps8_0_axi_periph_RDATA = M00_AXI_rdata[31:0];
  assign s00_couplers_to_ps8_0_axi_periph_RRESP = M00_AXI_rresp[1:0];
  assign s00_couplers_to_ps8_0_axi_periph_RVALID = M00_AXI_rvalid;
  assign s00_couplers_to_ps8_0_axi_periph_WREADY = M00_AXI_wready;
  s00_couplers_imp_1EEP9YN s00_couplers
       (.M_ACLK(ps8_0_axi_periph_ACLK_net),
        .M_ARESETN(ps8_0_axi_periph_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_ps8_0_axi_periph_ARADDR),
        .M_AXI_arready(s00_couplers_to_ps8_0_axi_periph_ARREADY),
        .M_AXI_arvalid(s00_couplers_to_ps8_0_axi_periph_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_ps8_0_axi_periph_AWADDR),
        .M_AXI_awready(s00_couplers_to_ps8_0_axi_periph_AWREADY),
        .M_AXI_awvalid(s00_couplers_to_ps8_0_axi_periph_AWVALID),
        .M_AXI_bready(s00_couplers_to_ps8_0_axi_periph_BREADY),
        .M_AXI_bresp(s00_couplers_to_ps8_0_axi_periph_BRESP),
        .M_AXI_bvalid(s00_couplers_to_ps8_0_axi_periph_BVALID),
        .M_AXI_rdata(s00_couplers_to_ps8_0_axi_periph_RDATA),
        .M_AXI_rready(s00_couplers_to_ps8_0_axi_periph_RREADY),
        .M_AXI_rresp(s00_couplers_to_ps8_0_axi_periph_RRESP),
        .M_AXI_rvalid(s00_couplers_to_ps8_0_axi_periph_RVALID),
        .M_AXI_wdata(s00_couplers_to_ps8_0_axi_periph_WDATA),
        .M_AXI_wready(s00_couplers_to_ps8_0_axi_periph_WREADY),
        .M_AXI_wstrb(s00_couplers_to_ps8_0_axi_periph_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_ps8_0_axi_periph_WVALID),
        .S_ACLK(S00_ACLK_1),
        .S_ARESETN(S00_ARESETN_1),
        .S_AXI_araddr(ps8_0_axi_periph_to_s00_couplers_ARADDR),
        .S_AXI_arburst(ps8_0_axi_periph_to_s00_couplers_ARBURST),
        .S_AXI_arcache(ps8_0_axi_periph_to_s00_couplers_ARCACHE),
        .S_AXI_arid(ps8_0_axi_periph_to_s00_couplers_ARID),
        .S_AXI_arlen(ps8_0_axi_periph_to_s00_couplers_ARLEN),
        .S_AXI_arlock(ps8_0_axi_periph_to_s00_couplers_ARLOCK),
        .S_AXI_arprot(ps8_0_axi_periph_to_s00_couplers_ARPROT),
        .S_AXI_arqos(ps8_0_axi_periph_to_s00_couplers_ARQOS),
        .S_AXI_arready(ps8_0_axi_periph_to_s00_couplers_ARREADY),
        .S_AXI_arsize(ps8_0_axi_periph_to_s00_couplers_ARSIZE),
        .S_AXI_arvalid(ps8_0_axi_periph_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(ps8_0_axi_periph_to_s00_couplers_AWADDR),
        .S_AXI_awburst(ps8_0_axi_periph_to_s00_couplers_AWBURST),
        .S_AXI_awcache(ps8_0_axi_periph_to_s00_couplers_AWCACHE),
        .S_AXI_awid(ps8_0_axi_periph_to_s00_couplers_AWID),
        .S_AXI_awlen(ps8_0_axi_periph_to_s00_couplers_AWLEN),
        .S_AXI_awlock(ps8_0_axi_periph_to_s00_couplers_AWLOCK),
        .S_AXI_awprot(ps8_0_axi_periph_to_s00_couplers_AWPROT),
        .S_AXI_awqos(ps8_0_axi_periph_to_s00_couplers_AWQOS),
        .S_AXI_awready(ps8_0_axi_periph_to_s00_couplers_AWREADY),
        .S_AXI_awsize(ps8_0_axi_periph_to_s00_couplers_AWSIZE),
        .S_AXI_awvalid(ps8_0_axi_periph_to_s00_couplers_AWVALID),
        .S_AXI_bid(ps8_0_axi_periph_to_s00_couplers_BID),
        .S_AXI_bready(ps8_0_axi_periph_to_s00_couplers_BREADY),
        .S_AXI_bresp(ps8_0_axi_periph_to_s00_couplers_BRESP),
        .S_AXI_bvalid(ps8_0_axi_periph_to_s00_couplers_BVALID),
        .S_AXI_rdata(ps8_0_axi_periph_to_s00_couplers_RDATA),
        .S_AXI_rid(ps8_0_axi_periph_to_s00_couplers_RID),
        .S_AXI_rlast(ps8_0_axi_periph_to_s00_couplers_RLAST),
        .S_AXI_rready(ps8_0_axi_periph_to_s00_couplers_RREADY),
        .S_AXI_rresp(ps8_0_axi_periph_to_s00_couplers_RRESP),
        .S_AXI_rvalid(ps8_0_axi_periph_to_s00_couplers_RVALID),
        .S_AXI_wdata(ps8_0_axi_periph_to_s00_couplers_WDATA),
        .S_AXI_wlast(ps8_0_axi_periph_to_s00_couplers_WLAST),
        .S_AXI_wready(ps8_0_axi_periph_to_s00_couplers_WREADY),
        .S_AXI_wstrb(ps8_0_axi_periph_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(ps8_0_axi_periph_to_s00_couplers_WVALID));
endmodule
