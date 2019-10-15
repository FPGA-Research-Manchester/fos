# setting top_module
# set top_module sobel_1_slot_5k

lappend auto_path ../../tedtcl
package require ted

open_checkpoint ./Synth/Static/static_v1_32bit_SYN.dcp

create_pblock pblock_0

resize_pblock pblock_0 -add {SLICE_X0Y0:SLICE_X4Y179 DSP48E2_X0Y0:DSP48E2_X0Y71 RAMB18_X0Y0:RAMB18_X0Y71 RAMB36_X0Y0:RAMB36_X0Y35}

add_cells_to_pblock pblock_0 [get_cells [list */pr_decoupler_0 */ps8_0_axi_periph */rst_ps8_0_99M */util_vector_logic_0 */util_vector_logic_1 */zynq_ultra_ps_e_0 */axi_interconnect_0]] -clear_locs

# add module checkpoint to static's blackbox

read_checkpoint -cell */PR_SLOT_0_0/U0/inst_PR_WRP/PR_Kernel ./Synth/reconfig_modules/${top_module}.dcp

create_pblock pblock_PR_Kernel

# resize_pblock pblock_PR_Kernel -add {SLICE_X15Y0:SLICE_X48Y59 DSP48E2_X1Y0:DSP48E2_X4Y23 RAMB18_X2Y0:RAMB18_X5Y23 RAMB36_X2Y0:RAMB36_X5Y11}
resize_pblock pblock_PR_Kernel -add {SLICE_X15Y5:SLICE_X48Y54 DSP48E2_X1Y2:DSP48E2_X4Y21 RAMB18_X2Y2:RAMB18_X5Y21 RAMB36_X2Y1:RAMB36_X5Y10}

add_cells_to_pblock pblock_PR_Kernel [get_cells [list */PR_SLOT_0_0/U0/inst_PR_WRP]]

opt_design

# pre-place the connection macros
source place_pre_0.tcl

place_design

# pre-route the connection macros
source route_pre_0.tcl

write_checkpoint -force ./DCPs/${top_module}_place

# adding blocker
# clock constraints
set clockIndicesToBlock [lsort -dictionary [struct::set difference [::ted::utility::range 32] {0 10}]]

set clkTiles [get_tiles -filter {TYPE == RCLK_INT_L && GRID_POINT_X>181 && GRID_POINT_Y == 155}]

set nodesToBlock {}

foreach clkTile $clkTiles {
	foreach i $clockIndicesToBlock {
			lappend nodesToBlock "${clkTile}/RCLK_INT_L.CLK_LEAF_SITES_${i}\_CLK_IN->>CLK_LEAF_SITES_${i}\_CLK_LEAF"
	}
}

ted::routing::blockNodes [ted::routing::getNetVCC] $nodesToBlock

set clkTiles [get_tiles -filter {TYPE == RCLK_INT_R && GRID_POINT_Y == 155}]

set nodesToBlock {}

foreach clkTile $clkTiles {
	foreach i $clockIndicesToBlock {
			lappend nodesToBlock "${clkTile}/RCLK_INT_R.CLK_LEAF_SITES_${i}\_CLK_IN->>CLK_LEAF_SITES_${i}\_CLK_LEAF"
	}
}

ted::routing::blockNodes [ted::routing::getNetVCC] $nodesToBlock

# route the clock signal
set ::env(clk_sgnl_name) [lindex [get_nets -filter {TYPE==GLOBAL_CLOCK} -hierarchical] 0]
route_design -nets [get_nets $env(clk_sgnl_name)]

# right border
ted::routing::blockNodes [ted::routing::getNetVCC] [get_wires -of_objects  [get_tiles -filter {TYPE==INT_INTF_RIGHT_TERM_IO && GRID_POINT_Y>124}] -regexp -filter {NAME=~[^/]*/EASTBUSOUT_.*}]

# bottom border
ted::routing::blockNodes [ted::routing::getNetVCC] [get_wires -of_objects [get_tiles -filter {TYPE==INT_TERM_B && GRID_POINT_X>186}] -regexp -filter {NAME=~[^/]*/SOUTHBUSOUT_.*}]

# left border
ted::routing::blockFreeNodesOnTiles [ted::routing::getNetVCC] [get_tiles -filter {TYPE==CLEL_R && GRID_POINT_X==187 && GRID_POINT_Y>124}]

# top border
ted::routing::blockFreeNodesOnTiles [ted::routing::getNetVCC] [get_tiles -filter {TYPE==INT_RBRK && GRID_POINT_X>187 && GRID_POINT_Y==124}]

route_design

write_checkpoint -force ./DCPs/${top_module}_route_w_blocker

# remove the blocker
set_property is_route_fixed 1 [ted::routing::getNetGND]
set_property is_route_fixed 0 [ted::routing::getNetVCC]
route_design    -unroute -physical_nets
route_design  -physical_nets

write_checkpoint -force ./DCPs/${top_module}_route_final

# generate bitstream
set_property BITSTREAM.GENERAL.CRC DISABLE [current_design]

write_bitstream -force ./bins/${top_module}_full
