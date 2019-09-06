#ifndef IP_SENSORS96B_ZYNQ_ULTRA_PS_E_0_0_H_
#define IP_SENSORS96B_ZYNQ_ULTRA_PS_E_0_0_H_

// (c) Copyright 1995-2019 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

#ifndef XTLM
#include "xtlm.h"
#endif

#ifndef SYSTEMC_H
#include "systemc.h"
#endif

class zynq_ultra_ps_e_tlm;

class sensors96b_zynq_ultra_ps_e_0_0 : public sc_module
{
public:

  sensors96b_zynq_ultra_ps_e_0_0(const sc_module_name& nm);
  virtual ~sensors96b_zynq_ultra_ps_e_0_0();

public: // module pin-to-pin RTL interface

  sc_in< bool > maxihpm0_lpd_aclk;
  sc_out< sc_bv<16> > maxigp2_awid;
  sc_out< sc_bv<40> > maxigp2_awaddr;
  sc_out< sc_bv<8> > maxigp2_awlen;
  sc_out< sc_bv<3> > maxigp2_awsize;
  sc_out< sc_bv<2> > maxigp2_awburst;
  sc_out< bool > maxigp2_awlock;
  sc_out< sc_bv<4> > maxigp2_awcache;
  sc_out< sc_bv<3> > maxigp2_awprot;
  sc_out< bool > maxigp2_awvalid;
  sc_out< sc_bv<16> > maxigp2_awuser;
  sc_in< bool > maxigp2_awready;
  sc_out< sc_bv<32> > maxigp2_wdata;
  sc_out< sc_bv<4> > maxigp2_wstrb;
  sc_out< bool > maxigp2_wlast;
  sc_out< bool > maxigp2_wvalid;
  sc_in< bool > maxigp2_wready;
  sc_in< sc_bv<16> > maxigp2_bid;
  sc_in< sc_bv<2> > maxigp2_bresp;
  sc_in< bool > maxigp2_bvalid;
  sc_out< bool > maxigp2_bready;
  sc_out< sc_bv<16> > maxigp2_arid;
  sc_out< sc_bv<40> > maxigp2_araddr;
  sc_out< sc_bv<8> > maxigp2_arlen;
  sc_out< sc_bv<3> > maxigp2_arsize;
  sc_out< sc_bv<2> > maxigp2_arburst;
  sc_out< bool > maxigp2_arlock;
  sc_out< sc_bv<4> > maxigp2_arcache;
  sc_out< sc_bv<3> > maxigp2_arprot;
  sc_out< bool > maxigp2_arvalid;
  sc_out< sc_bv<16> > maxigp2_aruser;
  sc_in< bool > maxigp2_arready;
  sc_in< sc_bv<16> > maxigp2_rid;
  sc_in< sc_bv<32> > maxigp2_rdata;
  sc_in< sc_bv<2> > maxigp2_rresp;
  sc_in< bool > maxigp2_rlast;
  sc_in< bool > maxigp2_rvalid;
  sc_out< bool > maxigp2_rready;
  sc_out< sc_bv<4> > maxigp2_awqos;
  sc_out< sc_bv<4> > maxigp2_arqos;
  sc_in< sc_bv<6> > emio_gpio_i;
  sc_out< sc_bv<6> > emio_gpio_o;
  sc_out< sc_bv<6> > emio_gpio_t;
  sc_in< bool > emio_uart0_ctsn;
  sc_out< bool > emio_uart0_rtsn;
  sc_in< bool > emio_uart0_dsrn;
  sc_in< bool > emio_uart0_dcdn;
  sc_in< bool > emio_uart0_rin;
  sc_out< bool > emio_uart0_dtrn;
  sc_out< bool > emio_uart1_txd;
  sc_in< bool > emio_uart1_rxd;
  sc_in< sc_bv<1> > pl_ps_irq0;
  sc_out< bool > pl_resetn0;
  sc_out< bool > pl_clk0;
  sc_out< bool > pl_clk1;
  sc_out< bool > pl_clk2;
  sc_out< bool > pl_clk3;

public: // module socket-to-socket TLM interface

  xtlm::xtlm_aximm_initiator_socket* M_AXI_HPM0_LPD_wr_socket;
  xtlm::xtlm_aximm_initiator_socket* M_AXI_HPM0_LPD_rd_socket;

protected:

  virtual void before_end_of_elaboration();

private:

  sensors96b_zynq_ultra_ps_e_0_0(const sensors96b_zynq_ultra_ps_e_0_0&);
  const sensors96b_zynq_ultra_ps_e_0_0& operator=(const sensors96b_zynq_ultra_ps_e_0_0&);

  zynq_ultra_ps_e_tlm* mp_impl;

  xtlm::xaximm_xtlm2pin_t<32,40,16,16,1,1,16,1>* mp_M_AXI_HPM0_LPD_transactor;
  sc_signal< bool > m_M_AXI_HPM0_LPD_transactor_rst_signal;

};

#endif // IP_SENSORS96B_ZYNQ_ULTRA_PS_E_0_0_H_
