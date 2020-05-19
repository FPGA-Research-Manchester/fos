# set top_module vadd_OOC_Synth

lappend auto_path ../../tedtcl
package require ted

open_checkpoint ./Synth/Static/blocker_2_slots_0.dcp

read_checkpoint -cell */*/*/inst_PR_WRP/PR_Kernel ./Synth/reconfig_modules/${top_module}.dcp

add_cells_to_pblock pblock_PR_Kernel_int_0 [get_cells [list */*/*/inst_PR_WRP]]

opt_design
place_design

# route the clock signal
set ::env(clk_sgnl_name) [lindex [get_nets -filter {TYPE==GLOBAL_CLOCK} -hierarchical] 0]
route_design -nets [get_nets $env(clk_sgnl_name)]

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
