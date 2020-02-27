lappend auto_path ../../tedtcl
package require ted

open_checkpoint ./Synth/static_v1_32bit_ZCU_SYN_v2.dcp

create_pblock pblock_2

resize_pblock pblock_2 -add {RAMB36_X12Y0:RAMB36_X12Y83 RAMB36_X10Y36:RAMB36_X11Y83 RAMB36_X5Y0:RAMB36_X11Y34 RAMB18_X12Y0:RAMB18_X12Y167 RAMB18_X10Y72:RAMB18_X11Y167 RAMB18_X5Y0:RAMB18_X11Y69 DSP48E2_X15Y72:DSP48E2_X17Y167 DSP48E2_X7Y0:DSP48E2_X17Y69 SLICE_X91Y0:SLICE_X96Y419 SLICE_X74Y180:SLICE_X90Y419 SLICE_X36Y0:SLICE_X90Y174}

add_cells_to_pblock pblock_2 [get_cells [list */axi_mem_intercon */ps8_0_axi_periph */rst_ps8_0_99M */zynq_ultra_ps_e_0 */pr_decoupler_0 */util_vector_logic_0 */util_vector_logic_1]] -clear_locs

create_pblock pblock_PR_Kernel_int_0
resize_pblock pblock_PR_Kernel_int_0 -add {SLICE_X0Y185:SLICE_X67Y234 DSP48E2_X0Y74:DSP48E2_X12Y93 RAMB18_X0Y74:RAMB18_X8Y93 RAMB36_X0Y37:RAMB36_X8Y46}
# resize_pblock pblock_PR_Kernel_int_0 -add {SLICE_X0Y185:SLICE_X63Y234 DSP48E2_X0Y74:DSP48E2_X12Y93 RAMB18_X0Y74:RAMB18_X7Y93 RAMB36_X0Y37:RAMB36_X7Y46}

read_checkpoint -cell */*/*/inst_PR_WRP/PR_Kernel ${out_dir}/stage1.dcp

add_cells_to_pblock pblock_PR_Kernel_int_0 [get_cells [list */*/*/inst_PR_WRP]]

source place_pre_0.tcl
source route_pre_0.tcl

opt_design
place_design

set clkTiles [get_tiles RCLK_INT_* -of_objects [get_clock_regions -regexp X[0-2]Y[3]]]

set clockIndicesToBlock [lsort -dictionary [struct::set difference [::ted::utility::range 32] {0 10}]]
set nodesToBlock {}

foreach clkTile $clkTiles {
	foreach i $clockIndicesToBlock {
			lappend nodesToBlock "${clkTile}/RCLK_INT_L.CLK_LEAF_SITES_${i}\_CLK_IN->>CLK_LEAF_SITES_${i}\_CLK_LEAF"
	}
}

ted::routing::blockNodes [ted::routing::getNetVCC] $nodesToBlock

# set clkTiles [get_tiles RCLK_BRAM_* -of_objects [get_clock_regions -regexp X[0-2]Y[3]]]
# 
# set clockIndicesToBlock {0 2 4 6}
# set nodesToBlock {}
# 
# foreach clkTile $clkTiles {
# 	foreach i $clockIndicesToBlock {
# 			lappend nodesToBlock "${clkTile}/CLK_BUFCE_ROW_FSR_${i}\_CLK_IN ${clkTile}/CLK_BUFCE_ROW_FSR_${i}\_CLK_OUT"
# 	}
# }
# 
# ted::routing::blockNodes [ted::routing::getNetVCC] $nodesToBlock
# 
# set clkTiles [get_tiles RCLK_DSP_INTF_L_* -of_objects [get_clock_regions -regexp X[0-2]Y[3]]]
# 
# set clockIndicesToBlock {0 2}
# set nodesToBlock {}
# 
# foreach clkTile $clkTiles {
# 	foreach i $clockIndicesToBlock {
# 			lappend nodesToBlock "${clkTile}/CLK_BUFCE_ROW_FSR_${i}\_CLK_IN ${clkTile}/CLK_BUFCE_ROW_FSR_${i}\_CLK_OUT"
# 	}
# }
# 
# ted::routing::blockNodes [ted::routing::getNetVCC] $nodesToBlock
# 
# set clkTiles [get_tiles RCLK_CLEM_L_* -of_objects [get_clock_regions -regexp X[0-2]Y[3]]]
# 
# set clockIndicesToBlock {0}
# set nodesToBlock {}
# 
# foreach clkTile $clkTiles {
# 	foreach i $clockIndicesToBlock {
# 			lappend nodesToBlock "${clkTile}/CLK_BUFCE_ROW_FSR_${i}\_CLK_IN ${clkTile}/CLK_BUFCE_ROW_FSR_${i}\_CLK_OUT"
# 	}
# }
# 
# ted::routing::blockNodes [ted::routing::getNetVCC] $nodesToBlock

write_checkpoint    -force ${out_dir}/${top_module}_post_clk_block.dcp

# route the clock signal
set ::env(clk_sgnl_name) [lindex [get_nets -filter {TYPE==GLOBAL_CLOCK} -hierarchical] 0]
route_design -nets [get_nets $env(clk_sgnl_name)]

ted::routing::blockFreeNodesOnTiles [ted::routing::getNetVCC] [get_tiles -filter {TYPE==INT_RBRK && GRID_POINT_X<257 && GRID_POINT_Y==248}] -excludeClock
ted::routing::blockFreeNodesOnTiles [ted::routing::getNetVCC] [get_tiles -filter {TYPE==INT_RBRK && GRID_POINT_X<257 && GRID_POINT_Y==186}] -excludeClock
ted::routing::blockNodes [ted::routing::getNetVCC] [get_wires -of_objects [get_tiles -filter {TYPE==INT_TERM_P && GRID_POINT_X<257 && GRID_POINT_Y==248}] -regexp -filter {NAME=~[^/]*/SOUTHBUSOUT_.*}]
ted::routing::blockFreeNodesOnTiles [ted::routing::getNetVCC] [get_tiles -filter {TYPE==CLEM && GRID_POINT_X==259 && GRID_POINT_Y<248 && GRID_POINT_Y>186}]

write_checkpoint -force ${out_dir}/${top_module}_post_blocker.dcp

route_design
write_checkpoint -force ${out_dir}/${top_module}_route_w_blocker

# remove the blocker
set_property is_route_fixed 1 [ted::routing::getNetGND]
set_property is_route_fixed 0 [ted::routing::getNetVCC]
route_design    -unroute -physical_nets
route_design  -physical_nets

write_checkpoint -force ${out_dir}/${top_module}_route_final

# generate bitstream
set_property BITSTREAM.GENERAL.CRC DISABLE [current_design]

write_bitstream -force ${out_dir}/Full_${top_module}
