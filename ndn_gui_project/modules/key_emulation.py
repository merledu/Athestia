import os
import subprocess
import shutil
import sys
from pathlib import Path
import urllib.request
import zipfile
# from Dilithium import *
import vcdvcd

random_bytes = os.urandom
ctx = os.urandom(128)
rnd = random_bytes(32)


def find_vivado_path():
    search_roots = [r"C:\Xilinx", r"D:\Xilinx", r"E:\Vivado"]
    for root in search_roots:
        for path in Path(root).rglob("vivado.bat"):
            return str(path)
    return None


import os
import subprocess
import shutil
import sys
from pathlib import Path
import urllib.request
import zipfile

def download_repo(destination):
    repo_url = "https://github.com/merledu/Athestia.git"
    branch_name = "key_new"
    folder_name = "key_internal_new"

    temp_clone_dir = destination / "Athestia_temp_clone"
    target_folder = destination / folder_name

    # Check if Git is installed
    try:
        subprocess.run(
            ["git", "--version"],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
    except subprocess.CalledProcessError:
        raise EnvironmentError("Git is not installed or not available in PATH.")

    try:
        subprocess.run(
            ["git", "clone", "--branch", branch_name, "--single-branch", repo_url, str(temp_clone_dir)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"Git clone failed: {e}")

    source_folder = temp_clone_dir / folder_name
    if not source_folder.exists():
        raise FileNotFoundError(f"Folder '{folder_name}' not found in the branch '{branch_name}'.")

    if target_folder.exists():
        shutil.rmtree(target_folder)

    shutil.move(str(source_folder), str(target_folder))

    # shutil.rmtree("Athestia_temp_clone")
# === Configuration ===
cwd = Path.cwd()
VIVADO_PATH = find_vivado_path()
    
if not VIVADO_PATH:
    print("[ERROR] Vivado installation not found.")
    sys.exit(1)
# print(f"[INFO] Found Vivado at: {VIVADO_PATH}")

project_dir = cwd / "key_internal_new"
if not project_dir.exists():
    download_repo(cwd)

all = str(project_dir / "key_internal_new.srcs" / "sources_1" / "new")
TB_FILE = str(project_dir / "key_internal_new.srcs" / "sim_1" / "new" / "tb.sv")
DESIGN_FILE = str(Path(all) / "key_internal.sv")
PKG_FILE = str(Path(all) / "Dilithium_pkg.sv")




# print("Exists:", os.path.exists(DESIGN_FILE))

VCD_FILE = "keyinternal_tb_output.vcd"
TCL_SCRIPT = "run_simulation.tcl"
WORK_DIR = os.path.abspath("vivado_sim").replace('\\', '/')
PROJECT_NAME = "keyinternal_project"

def quote_path(path):
    """Quote paths for TCL compatibility, especially with spaces."""
    path = path.replace("\\", "/")
    return f"{{{path}}}"  # TCL uses {} to wrap paths with spaces
# === Dynamic SV code generation ===
def write_keytb_sv(zeta_hex):
    tb_code = f"""`timescale 1ns/1ps

module KeyInternal_tb;
    parameter clock_period = 0.005;
    
    logic clk;
    logic rst;
    logic [255:0] zeta;
    
    key_internal uut (
        .clk(clk),
        .rst(rst),
        .zeta(zeta)
    );

    initial begin
        clk = 0;
        forever #(clock_period) clk = ~clk;
    end

    initial begin
        rst = 1;
        zeta = 256'h0;
        #clock_period;
        rst = 0;
        zeta = 256'h{zeta_hex};  // Dynamically set value
        #1000;
        $finish;
    end
endmodule
"""
    tb_path = TB_FILE
    with open(tb_path, "w") as f:
        f.write(tb_code)
    # print(f"Testbench written to: {tb_path}")


def create_tcl_script():
    tb_file_tcl = quote_path(TB_FILE)
    design_file_tcl = quote_path(DESIGN_FILE)
    vcd_file_tcl = quote_path(VCD_FILE)
    work_dir_tcl = quote_path(WORK_DIR)
    pkg_file_tcl = quote_path(PKG_FILE)
    all_tcl= quote_path(all)

    tcl_content = f"""
# Normalize paths
set tb_file [file normalize {tb_file_tcl}]
set design_file [file normalize {design_file_tcl}]
set vcd_file [file normalize {vcd_file_tcl}]
set pkg_file [file normalize {pkg_file_tcl}]
set all [file normalize {all_tcl}]

# Create or open the project
create_project -force {PROJECT_NAME} {work_dir_tcl}

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
"""
    with open(TCL_SCRIPT, "w") as f:
        f.write(tcl_content)
    # print(f"TCL script written to: {TCL_SCRIPT}")

def run_vivado_simulation():
    if not os.path.exists(TB_FILE):
        print(f"Error: Testbench file not found at {TB_FILE}")
        return False
    if not os.path.exists(DESIGN_FILE):
        print(f"Error: Design file not found at {DESIGN_FILE}")
        return False
    if not os.path.exists(VIVADO_PATH):
        print(f"Error: Vivado not found at {VIVADO_PATH}")
        return False
    if not os.path.exists(PKG_FILE):
        print(f"Error: Vivado not found at {PKG_FILE}")
        return False

    os.makedirs(WORK_DIR, exist_ok=True)
    create_tcl_script()

    cmd = f'"{VIVADO_PATH}" -mode batch -source "{TCL_SCRIPT}"'
    # print(f"Executing: {cmd}")
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)

    if result.returncode != 0:
        print("Vivado simulation failed:")
        print(result.stderr)
        with open("vivado_error.log", "w") as f:
            f.write(result.stderr)
        return False

    # print("Vivado simulation completed successfully.")
    return True

# def parse_vcd_output():
#     if not os.path.exists(VCD_FILE):
#         print(f"VCD file not found: {VCD_FILE}")
#         return None

#     try:
#         vcd = vcdvcd.VCDVCD(VCD_FILE)
#         signals = [sig for sig in vcd.signals if sig.startswith("/KeyInternal_tb/uut/")]

#         output_values = {}
#         for sig in signals:
#             value = vcd[sig].tv[-1][1]  # Last value
#             output_values[sig] = value

#         return output_values
#     except Exception as e:
#         print(f"Failed to parse VCD file: {e}")
#         return None
# def parse_vcd_output():
#     if not os.path.exists(VCD_FILE):
#         print(f"VCD file not found: {VCD_FILE}")
#         return None

#     try:
#         vcd = vcdvcd.VCDVCD(VCD_FILE, store_tvs=True)
#         output_values = {}

#         print("\n--- Available Signals in VCD ---")
#         for sig in vcd.signals:
#             try:
#                 value_bin = vcd[sig].tv[-1][1]  # Last recorded value in binary
#                 if value_bin.startswith('b'):  # Example: b1010
#                     value_bin = value_bin[1:]
#                 elif value_bin in ('x', 'z'):  # Handle undefined/tri-state
#                     value_bin = '0'

#                 value_hex = hex(int(value_bin, 2))
#                 output_values[sig] = value_hex
#             except Exception as e:
#                 print(f"Could not parse {sig}: {e}")
#         return None
def parse_vcd_output():
    if not os.path.exists(VCD_FILE):
        print(f"VCD file not found: {VCD_FILE}")
        return None

    try:
        vcd = vcdvcd.VCDVCD(VCD_FILE, store_tvs=True)

        # print("\n--- Available Signals in VCD ---")
        # for sig in vcd.signals:
            
        #     print(sig)

        output_values = {}
        for sig in vcd.signals:
            if (sig=="KeyInternal_tb.uut.dut.sk[39167:0]" or sig =="KeyInternal_tb.uut.pk[20735:0]"):
                try:
                    value_bin = vcd[sig].tv[-1][1]  # Last recorded value in binary
                    if value_bin.startswith('b'):  # Example: b1010
                        value_bin = value_bin[1:]
                    elif value_bin in ('x', 'z'):  # Handle undefined/tri-state
                        value_bin = '0'

                    value_hex = hex(int(value_bin, 2))
                    output_values[sig] = value_hex
                except Exception as e:
                    print(f"Could not parse {sig}: {e}")

        return output_values
    except Exception as e:
        print(f"Failed to parse VCD file: {e}")
        return None
# def parse_vcd_output():
#     if not os.path.exists(VCD_FILE):
#         print(f"VCD file not found: {VCD_FILE}")
#         return None

#     try:
#         vcd = vcdvcd.VCDVCD(VCD_FILE, store_tvs=True)

#         target_signals = [
#             "/KeyInternal_tb/uut/dut/sk",  # Adjust depending on exact signal path
#             "/KeyInternal_tb/uut/dut/pk"
#         ]

#         output_values = {}
#         for sig in vcd.signals:
#             for target in target_signals:
#                 if sig.startswith(target):
#                     try:
#                         value_bin = vcd[sig].tv[-1][1]  # Last value
#                         if value_bin.startswith('b'):
#                             value_bin = value_bin[1:]
#                         elif value_bin in ('x', 'z'):  # Handle undefined
#                             value_bin = '0'
#                         value_hex = hex(int(value_bin, 2))
#                         output_values[sig] = value_hex
#                     except Exception as e:
#                         print(f"Could not parse {sig}: {e}")
#         return output_values
#     except Exception as e:
#         print(f"Failed to parse VCD file: {e}")
#         return None


def key_emu(zeta_value):
    write_keytb_sv(zeta_value)

    if not run_vivado_simulation():
        print("Simulation failed.")
        return None, None

    outputs = parse_vcd_output()
    if outputs:
        sk = outputs.get("KeyInternal_tb.uut.dut.sk[39167:0]")
        pk = outputs.get("KeyInternal_tb.uut.pk[20735:0]")
        return pk, sk
    else:
        print("No signals parsed from VCD.")
        return None, None
    

# if __name__ == "__main__":
#     # zeta_value = "24caa1b44d22446b945452a70af1d8b83f6adbd0030f12d11c684681596d4ca5"
#     zeta_value = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcd"
#     print(key_emu(zeta_value))
