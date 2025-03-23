
create_project decompose -part xc7a100tcsg324-1
add_files F:\synthesis_practice\dilithium_project\dilithium_app\decompose\decompose.sv F:\synthesis_practice\dilithium_project\dilithium_app\decompose\top_decompose_userinput.sv
set_property top_decompose_userinput top [current_fileset]
launch_runs synth_1
wait_on_run synth_1
exit
