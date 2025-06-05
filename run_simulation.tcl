
# Normalize paths
set tb_file [file normalize {C:/Users/Asfiyan/Desktop/hafsa_Athestia/key_internal_new/key_internal_new.srcs/sim_1/new/tb.sv}]
set design_file [file normalize {C:/Users/Asfiyan/Desktop/hafsa_Athestia/key_internal_new/key_internal_new.srcs/sources_1/new/key_internal.sv}]
set vcd_file [file normalize {keyinternal_tb_output.vcd}]
set pkg_file [file normalize {C:/Users/Asfiyan/Desktop/hafsa_Athestia/key_internal_new/key_internal_new.srcs/sources_1/new/Dilithium_pkg.sv}]
set all [file normalize {C:/Users/Asfiyan/Desktop/hafsa_Athestia/key_internal_new/key_internal_new.srcs/sources_1/new}]

# Create or open the project
create_project -force keyinternal_project {C:/Users/Asfiyan/Desktop/hafsa_Athestia/vivado_sim}

# Add the testbench and design files
add_files $all
add_files $pkg_file
add_files $tb_file
add_files $design_file

# Set the top module
set_property top KeyInternal_tb [get_filesets sim_1]

# Launch simulation
launch_simulation

# Add all signals and dump to VCD
add_wave /KeyInternal_tb/*
open_vcd $vcd_file
log_vcd /KeyInternal_tb/*
run all
close_vcd

# Close the project
close_project
exit
