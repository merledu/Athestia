# import subprocess
# import os
# import platform
# import tempfile
# import json
# import shutil
# import sys
# from pathlib import Path
# import urllib.request
# import zipfile
# import vcdvcd
# import pickle
# import time
# import logging
# from typing import Optional


# # Set up logging
# logging.basicConfig(level=logging.INFO, format="[%(levelname)s] %(message)s")

# class VivadoInterface:
#     def __init__(self, seed: Optional[bytes] = None):
#         """Initialize with optional DRBG seed for deterministic randomness."""
#         self.vivado_path = self._find_vivado()
#         self.temp_dir = tempfile.mkdtemp()
#         self._initialize_randomness(seed)

#         # Paths (configurable) - Manually set dynamic path for key_internal_new
#         self.cwd = Path.cwd()
#         self.project_dir = Path(__file__).parent.parent.parent / "key_internal_new"  # Points to Athetia/key_internal_new
#         self.tb_file = self.project_dir / "key_internal_new.srcs" / "sim_1" / "new" / "tb.sv"
#         self.design_file = self.project_dir / "key_internal_new.srcs" / "sources_1" / "new" / "key_internal.sv"
#         self.pkg_file = self.project_dir / "key_internal_new.srcs" / "sources_1" / "new" / "Dilithium_pkg.sv"
#         self.sources_dir = str(self.project_dir / "key_internal_new.srcs" / "sources_1" / "new")
#         self.vcd_file = "keyinternal_tb_output.vcd"
#         self.tcl_script = "run_simulation.tcl"
#         self.work_dir = os.path.abspath("vivado_sim").replace('\\', '/')
#         self.project_name = "keyinternal_project"

#         if not self.project_dir.exists():
#             self._download_repo(self.cwd)

#     def _initialize_randomness(self, seed: Optional[bytes]):
#         """Set up random_bytes with DRBG if seed provided, else fall back to os.urandom."""
#         try:
#             from drbg.aes256_ctr_drbg import AES256_CTR_DRBG
#             self.random_bytes = AES256_CTR_DRBG(seed or os.urandom(48)).random_bytes if seed else os.urandom
#             logging.info("Using DRBG for randomness.")
#         except ImportError:
#             self.random_bytes = os.urandom
#             logging.warning("pycryptodome not found; using os.urandom.")
#         logging.info(f"random_bytes from: {self.random_bytes.__module__}")

#     def _find_vivado(self):
#         system = platform.system()
#         if system == "Windows":
#             base_paths = [
#                 r"C:\Users\msame\Downloads\Vivado\2018.2\bin",  # Your confirmed base path
#                 r"C:\Xilinx\Vivado",  # Default location
#                 r"D:\Xilinx\Vivado",
#                 r"E:\Xilinx\Vivado",
#                 r"C:\Program Files\Xilinx\Vivado"
#             ]
#             exe = "vivado.bat"
#         elif system in ["Linux", "Darwin"]:
#             base_paths = ["/opt/Xilinx/Vivado", "/tools/Xilinx/Vivado", "/usr/local/Xilinx/Vivado"]
#             exe = "vivado"
#         else:
#             logging.error("Unsupported platform.")
#             return None

#         for base in base_paths:
#             if os.path.exists(base):
#                 # Check if base is already the bin directory
#                 if os.path.isdir(base):
#                     path = os.path.join(base, exe)
#                     if os.path.exists(path):
#                         logging.info(f"Vivado found at: {path}")
#                         return path
#                 # Search subdirectories if base is a root install directory
#                 for root, dirs, files in os.walk(base):
#                     if exe in files:
#                         path = os.path.join(root, exe)
#                         logging.info(f"Vivado found at: {path}")
#                         return path
#         logging.error("Vivado not found.")
#         return None

#     def is_vivado_available(self):
#         return self.vivado_path is not None

#     def _download_repo(self, destination):
#         repo_url = "https://github.com/merledu/Athestia.git"
#         branch_name = "modules"
#         folder_name = "key_internal_new"

#         try:
#             subprocess.run(["git", "--version"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
#         except subprocess.CalledProcessError:
#             raise EnvironmentError("Git not installed.")

#         temp_clone_dir = destination / "Athestia_temp_clone"
#         target_folder = destination / folder_name

#         try:
#             subprocess.run(["git", "clone", "--branch", branch_name, "--single-branch", repo_url, str(temp_clone_dir)], check=True)
#         except subprocess.CalledProcessError as e:
#             raise RuntimeError(f"Git clone failed: {e}")

#         source_folder = temp_clone_dir / folder_name
#         if not source_folder.exists():
#             raise FileNotFoundError(f"Folder '{folder_name}' not found.")

#         if target_folder.exists():
#             shutil.rmtree(target_folder)
#         shutil.move(str(source_folder), str(target_folder))
#         shutil.rmtree(temp_clone_dir)
#         logging.info("Repo downloaded.")

#     def _quote_path(self, path):
#         path = path.replace("\\", "/")
#         return f"{{{path}}}"

#     def _create_tcl_script(self):
#         tb_tcl = self._quote_path(str(self.tb_file))
#         design_tcl = self._quote_path(str(self.design_file))
#         vcd_tcl = self._quote_path(self.vcd_file)
#         pkg_tcl = self._quote_path(str(self.pkg_file))
#         sources_tcl = self._quote_path(self.sources_dir)
#         work_tcl = self._quote_path(self.work_dir)

#         tcl_content = f"""
#             set tb_file [file normalize {tb_tcl}]
#             set design_file [file normalize {design_tcl}]
#             set vcd_file [file normalize {vcd_tcl}]
#             set pkg_file [file normalize {pkg_tcl}]
#             set sources_dir [file normalize {sources_tcl}]

#             create_project -force {self.project_name} {work_tcl}

#             add_files $sources_dir
#             add_files $pkg_file
#             add_files $tb_file
#             add_files $design_file

#             set_property top KeyInternal_tb [get_filesets sim_1]

#             launch_simulation

#             add_wave /KeyInternal_tb/*
#             open_vcd $vcd_file
#             log_vcd /KeyInternal_tb/*
#             run all
#             close_vcd

#             close_project
#             exit
#             """
#         with open(self.tcl_script, "w") as f:
#             f.write(tcl_content)
#         logging.info(f"TCL created: {self.tcl_script}")

#     def _run_vivado_simulation(self):
#         for file_path in [self.tb_file, self.design_file, self.pkg_file, self.vivado_path]:
#             if not os.path.exists(file_path):
#                 logging.error(f"File missing: {file_path}")
#                 return False

#         os.makedirs(self.work_dir, exist_ok=True)
#         self._create_tcl_script()

#         cmd = f'"{self.vivado_path}" -mode batch -source "{self.tcl_script}"'
#         logging.info(f"Running: {cmd}")
#         result = subprocess.run(cmd, shell=True, capture_output=True, text=True)

#         if result.returncode != 0:
#             logging.error("Vivado failed:")
#             logging.error(result.stderr)
#             with open("vivado_error.log", "w") as f:
#                 f.write(result.stderr)
#             return False

#         logging.info("Simulation success.")
#         return True


#     def _parse_vcd_output(self):
#         if not os.path.exists(self.vcd_file):
#             logging.error(f"VCD missing: {self.vcd_file}")
#             return None

#         try:
#             vcd = vcdvcd.VCDVCD(self.vcd_file, store_tvs=True)
#             output_values = {}
#             signals = {
#                 "sk": "KeyInternal_tb.uut.dut.sk[39167:0]",
#                 "pk": "KeyInternal_tb.uut.pk[20735:0]"
#             }
#             for key, sig in signals.items():
#                 if sig in vcd.signals:
#                     value_bin = vcd[sig].tv[-1][1]
#                     if value_bin in ('x', 'z'):
#                         value_bin = '0'
#                     elif value_bin.startswith('b'):
#                         value_bin = value_bin[1:]
#                     value_hex = hex(int(value_bin, 2))
#                     output_values[key] = value_hex
#                 else:
#                     logging.warning(f"Signal missing: {sig}")
#             return output_values
#         except Exception as e:
#             logging.error(f"VCD parse failed: {e}")
#             return None

#     def _write_keytb_sv(self, zeta_hex):
#         tb_code = f"""`timescale 1ns/1ps

#             module KeyInternal_tb;
#                 parameter clock_period = 0.005;  // 100MHz clock
                
#                 logic clk;
#                 logic rst;
#                 logic [255:0] zeta;
                
#                 key_internal uut (
#                     .clk(clk),
#                     .rst(rst),
#                     .zeta(zeta)
#                 );

#                 initial begin
#                     clk = 0;
#                     forever #(clock_period) clk = ~clk;
#                 end

#                 initial begin
#                     rst = 1;
#                     zeta = 256'h0;
#                     #clock_period;
#                     rst = 0;
#                     zeta = 256'h{zeta_hex};
#                     #1000;  // Sufficient sim time
#                     $finish;
#                 end
#             endmodule
#             """
#         with open(self.tb_file, "w") as f:
#             f.write(tb_code)
#         logging.info(f"TB written: {self.tb_file}")

#     def run_keygen(self, id_prefix):
#         if not self.is_vivado_available():
#             raise RuntimeError("Vivado not available.")
        
#         zeta = self.random_bytes(32).hex()
#         self._write_keytb_sv(zeta)
        
#         if not self._run_vivado_simulation():
#             raise RuntimeError("Simulation failed.")
        
#         outputs = self.()
#         if not outputs:
#             raise ValueError("No outputs parsed.")
        
#         pk = outputs.get("pk", "0x0")[2:5186]  # Adjust slice if needed
#         sk = outputs.get("sk", "0x0")[2:9794]
        
#         return {
#             'pk': pk,
#             'sk': sk,
#             'pk_id': f"{id_prefix}1",
#             'sk_id': f"{id_prefix}2"
#         }

#     def run_sign(self, sk, message, id_prefix):
#         logging.warning("Sign emulation not implemented.")
#         return {'signature': '', 'sig_id': f"{id_prefix}3"}

#     def run_verify(self, pk, message, signature):
#         logging.warning("Verify emulation not implemented.")
#         return False

