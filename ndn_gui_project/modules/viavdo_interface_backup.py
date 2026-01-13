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
# import threading

# # Set up logging
# logging.basicConfig(level=logging.INFO, format="[%(levelname)s] %(message)s")

# class VivadoInterface:
#     def __init__(self, operation: str = "key", seed: Optional[bytes] = None):
#         """Initialize with operation type (key, sign, or verify) and optional DRBG seed."""
#         self.vivado_path = self._find_vivado()
#         self.temp_dir = tempfile.mkdtemp()
#         self._initialize_randomness(seed)
        
#         # Dynamic paths based on operation using script's parent directory
#         base_path = Path(__file__).parent.parent.parent
#         self.cwd = base_path
#         self.operation = operation.lower()
#         self.project_dirs = {
#             "key": base_path / "key_internal_new",
#             "sign": base_path / "sign_internal",
#             "verify": base_path / "verify"  # Placeholder; to be added later
#         }
#         self.project_dir = self.project_dirs.get(self.operation, self.project_dirs["key"])
        
#         if self.operation == "key":
#             self.tb_file = self.project_dir / "key_internal_new.srcs" / "sim_1" / "new" / "tb.sv"
#             self.design_file = self.project_dir / "key_internal_new.srcs" / "sources_1" / "new" / "key_internal.sv"
#             self.pkg_file = self.project_dir / "key_internal_new.srcs" / "sources_1" / "new" / "Dilithium_pkg.sv"
#             self.sources_dir = str(self.project_dir / "key_internal_new.srcs" / "sources_1" / "new")
#             self.vcd_file = "keyinternal_tb_output.vcd"
#             self.tcl_script = "run_simulation.tcl"
#             self.project_name = "keyinternal_project"
#         elif self.operation == "sign":
#             self.tb_file = self.project_dir / "sign_internal.srcs" / "sim_1" / "new" / "tb_sign.sv"
#             self.design_file = self.project_dir / "sign_internal.srcs" / "sources_1" / "new" / "SignInternal2.sv"
#             self.pkg_file = self.project_dir / "sign_internal.srcs" / "sources_1" / "new" / "Dilithium_pkg.sv"
#             self.sources_dir = str(self.project_dir / "sign_internal.srcs" / "sources_1" / "new")
#             self.vcd_file = "sign_output.vcd"
#             self.tcl_script = "run_sign_simulation.tcl"
#             self.project_name = "Signinternal_project"
#         else:
#             raise ValueError(f"Unsupported operation: {operation}")

#         self.work_dir = os.path.abspath("vivado_sim").replace('\\', '/')
        
#         # Check if project_dir exists before downloading
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
#                 r"C:\Users\msame\Downloads\Vivado\2018.2\bin",
#                 r"C:\Xilinx\Vivado",
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
#                 path = os.path.join(base, exe)
#                 if os.path.exists(path):
#                     logging.info(f"Vivado found at: {path}")
#                     return path
#         logging.error("Vivado not found.")
#         return None

#     def is_vivado_available(self):
#         return self.vivado_path is not None

#     def _download_repo(self, destination):
#         repo_url = "https://github.com/merledu/Athetia.git"
#         branch_name = "modules"
#         folder_name = self.operation + "_internal"  # Dynamic based on operation

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

#     def _create_tcl_script2(self):
#         tb_tcl = self._quote_path(str(self.tb_file))
#         design_tcl = self._quote_path(str(self.design_file))
#         vcd_tcl = self._quote_path(self.vcd_file)
#         pkg_tcl = self._quote_path(str(self.pkg_file))
#         sources_tcl = self._quote_path(self.sources_dir)
#         work_tcl = self._quote_path(self.work_dir)

#         tcl_content = f"""
#             # Normalize paths
#             set tb_file [file normalize {tb_tcl}]
#             set design_file [file normalize {design_tcl}]
#             set vcd_file [file normalize {vcd_tcl}]
#             set pkg_file [file normalize {pkg_tcl}]
#             set sources_dir [file normalize {sources_tcl}]

#             # Create or open the project
#             create_project -force {self.project_name} {work_tcl}

#             # Add the testbench and design files
#             add_files $sources_dir
#             add_files $pkg_file
#             add_files $tb_file
#             add_files $design_file

#             # Set the top module
#             set_property top sign [get_filesets sim_1]

#             # Launch simulation
#             launch_simulation

#             # Add all signals and dump to VCD
#             # add_wave /sign/*
#             add_wave /sign/uut/signencode/sigma[37015:0]
#             open_vcd $vcd_file
#             # log_vcd /sign/*
#             log_vcd /sign/uut/signencode/sigma[37015:0]
#             run all
#             close_vcd

#             # Close the project
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
#         self._create_tcl_script() if self.operation == "key" else self._create_tcl_script2()
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

#     def _run_vivado_simulation2(self):
#         if not os.path.exists(self.tb_file):
#             logging.error(f"Error: Testbench file not found at {self.tb_file}")
#             return False
#         if not os.path.exists(self.design_file):
#             logging.error(f"Error: Design file not found at {self.design_file}")
#             return False
#         if not os.path.exists(self.vivado_path):
#             logging.error(f"Error: Vivado not found at {self.vivado_path}")
#             return False
#         if not os.path.exists(self.pkg_file):
#             logging.error(f"Error: Package file not found at {self.pkg_file}")
#             return False

#         os.makedirs(self.work_dir, exist_ok=True)
#         self._create_tcl_script2()
#         cmd = f'"{self.vivado_path}" -mode batch -source "{self.tcl_script}"'
#         logging.info(f"Executing: {cmd}")
#         result = subprocess.run(cmd, shell=True, capture_output=True, text=True)

#         if result.returncode != 0:
#             logging.error("Vivado simulation failed:")
#             logging.error(result.stderr)
#             with open("vivado_error.log", "w") as f:
#                 f.write(result.stderr)
#             return False

#         logging.info("Vivado simulation completed successfully.")
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

#     # def _parse_vcd_output(self):
#     #     if not os.path.exists(self.vcd_file):
#     #         logging.error(f"VCD missing: {self.vcd_file}")
#     #         return None

#     #     try:
#     #         vcd = vcdvcd.VCDVCD(self.vcd_file, store_tvs=True)
#     #         output_values = {}
#     #         signals = {
#     #             "sk": "KeyInternal_tb.uut.dut.sk[39167:0]",
#     #             "pk": "KeyInternal_tb.uut.pk[20735:0]"
#     #         }
#     #         for key, sig in signals.items():
#     #             if sig in vcd.signals:
#     #                 value_bin = vcd[sig].tv[-1][1]
#     #                 if value_bin in ('x', 'z'):
#     #                     value_bin = '0'
#     #                 elif value_bin.startswith('b'):
#     #                     value_bin = value_bin[1:]
#     #                 # Replace invalid 'x' or 'z' with '0'
#     #                 value_bin = value_bin.replace('x', '0').replace('z', '0')
#     #                 value_hex = hex(int(value_bin, 2))
#     #                 output_values[key] = value_hex
#     #             else:
#     #                 logging.warning(f"Signal missing: {sig}")
#     #         return output_values
#     #     except Exception as e:
#     #         logging.error(f"VCD parse failed: {e}")
#     #         return None


#     def _parse_vcd_output2(self):
#         # if not os.path.exists(self.vcd_file):
#         #     logging.error(f"VCD file not found: {self.vcd_file}")
#         #     return None

#         # try:
#         #     vcd = vcdvcd.VCDVCD(self.vcd_file, store_tvs=True)

#         #     logging.info("\n--- Available Signals in VCD ---")
#         #     for sig in vcd.signals:
#         #         logging.info(sig)

#         #     output_values = {}
#         #     for sig in vcd.signals:
#         #         try:
#         #             value_bin = vcd[sig].tv[-1][1]  # Last recorded value in binary
#         #             if value_bin.startswith('b'):  # Example: b1010
#         #                 value_bin = value_bin[1:]
#         #             elif value_bin in ('x', 'z'):  # Handle undefined/tri-state
#         #                 value_bin = '0'

#         #             value_hex = hex(int(value_bin, 2))
#         #             output_values[sig] = value_hex
#         #         except Exception as e:
#         #             logging.warning(f"Could not parse {sig}: {e}")
#         #     return output_values
#         # except Exception as e:
#         #     logging.error(f"Failed to parse VCD file: {e}")
#         #     return None

#         if not os.path.exists(self.vcd_file):
#             logging.error(f"VCD file not found: {self.vcd_file}")
#             return None
#         try:
#             vcd = vcdvcd.VCDVCD(self.vcd_file, store_tvs=True)
#             sig = "sign.uut.signencode.sigma[37015:0]"  # Exact path from your design
#             if sig in vcd.signals:
#                 value_bin = vcd[sig].tv[-1][1]  # Last value
#                 if value_bin.startswith('b'): value_bin = value_bin[1:]
#                 elif value_bin in ('x', 'z'): value_bin = '0'
#                 value_hex = hex(int(value_bin, 2))
#                 return {sig: value_hex}
#             else:
#                 logging.warning(f"Sigma signal missing")
#                 return None
#         except Exception as e:
#             logging.error(f"Failed to parse VCD: {e}")
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

#     def _write_signtb_sv(self, sk, msg, rnd, ctx, msg_len, ctx_len, rnd_len):
#         tb_code = f"""`timescale 1ns/1ps

#         module sign;
#             // Parameters for the testbench
#             logic [8 * (32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta)+1)) 
#                                             + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1:0] sk;
#             logic clk;
#             logic rst;
#             // logic [{(msg_len*8)-1}:0] msg;
#             // logic [{(ctx_len*8)-1}:0] ctx;
#             // logic [{(rnd_len*8)-1}:0] rnd;

#             // Clock generation
#             initial begin
#                 clk = 0;
#                 forever #0.0008 clk = ~clk; // 100 MHz clock
#             end

#             // DUT instantiation
#             sign_internal2 #(.msg_len({msg_len}), .ctx_len({ctx_len}), .rnd_len({rnd_len})) uut (
#                 .sk(39168'h{sk}),
#                 .clk(clk),
#                 .rst(rst),
#                 .n_msg('h{msg}),
#                 .rnd('h{rnd}),
#                 .ctx('h{ctx})
#             );

#             // Testbench logic
#             initial begin
#                 // Reset sequence
#                 rst = 1;
#                 #1 rst = 0;

#                 // Test case 1: Initialize inputs
#                 #10000;

#                 $finish;
#             end

#         endmodule
#         """
#         with open(self.tb_file, "w") as f:
#             f.write(tb_code)
#         logging.info(f"Testbench written to: {self.tb_file}")

#     def run_keygen(self, id_prefix):
#         if not self.is_vivado_available():
#             raise RuntimeError("Vivado not available.")
        
#         zeta = self.random_bytes(32).hex()
#         self._write_keytb_sv(zeta)
        
#         if not self._run_vivado_simulation():
#             raise RuntimeError("Simulation failed.")
        
#         outputs = self._parse_vcd_output()
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

#     # def run_sign(self, sk, message, id_prefix):
#     #     if not self.is_vivado_available():
#     #         raise RuntimeError("Vivado not available.")
        
#     #     logging.info("Starting Vivado simulation for sign...")
#     #     rnd = self.random_bytes(32).hex()  # Use DRBG for rnd, as with zeta
#     #     ctx = os.urandom(128).hex()  # Keep ctx as is, converted to hex for SV
#     #     msg_len = len(bytes.fromhex(message))
#     #     ctx_len = 128
#     #     rnd_len = 32
        
#     #     self._write_signtb_sv(sk, message, rnd, ctx, msg_len, ctx_len, rnd_len)

#     #     if not self._run_vivado_simulation2():
#     #         raise RuntimeError("Simulation failed.")
        
#     #     outputs = self._parse_vcd_output2()
#     #     if not outputs:
#     #         raise ValueError("No signals parsed from VCD.")
        
#     #     sign = outputs.get("sign.uut.signencode.sigma[37015:0]")
#     #     if sign:
#     #         return {
#     #             'signature': sign,
#     #             'sig_id': f"{id_prefix}3"
#     #         }
#     #     else:
#     #         raise ValueError("Signature not found in VCD output.")


#     def run_sign(self, sk, message, id_prefix):
#         if not self.is_vivado_available():
#             raise RuntimeError("Vivado not available.")
        
#         logging.info("Starting Vivado simulation for sign...")
#         rnd = self.random_bytes(32).hex()  # Use DRBG for rnd, as with zeta
#         ctx = os.urandom(128).hex()  # Keep ctx as is, converted to hex for SV
#         msg_len = len(bytes.fromhex(message))
#         ctx_len = 128
#         rnd_len = 32
        
#         self._write_signtb_sv(sk, message, rnd, ctx, msg_len, ctx_len, rnd_len)

#         # Run simulation in a thread to avoid blocking GUI
#         result = [None]  # To store subprocess result
#         def run_simulation_thread():
#             if not self._run_vivado_simulation2():
#                 result[0] = RuntimeError("Simulation failed.")
#             else:
#                 outputs = self._parse_vcd_output2()
#                 if not outputs:
#                     result[0] = ValueError("No signals parsed from VCD.")
#                 else:
#                     sign = outputs.get("sign.uut.signencode.sigma[37015:0]")
#                     if sign:
#                         result[0] = {
#                             'signature': sign,
#                             'sig_id': f"{id_prefix}3"
#                         }
#                     else:
#                         result[0] = ValueError("Signature not found in VCD output.")

#         thread = threading.Thread(target=run_simulation_thread)
#         thread.start()
        
#         # Keep GUI responsive while waiting for thread to finish
#         from PyQt5.QtWidgets import QApplication
#         import time
#         while thread.is_alive():
#             QApplication.processEvents()  # Process Qt events to keep GUI alive
#             time.sleep(0.1)  # Small sleep to avoid CPU spin

#         thread.join()  # Wait for thread to finish
        
#         if isinstance(result[0], Exception):
#             raise result[0]
#         return result[0]


#     def run_verify(self, pk, message, signature):
#         logging.warning("Verify emulation not implemented.")
#         return False