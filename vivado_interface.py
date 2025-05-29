import subprocess
import os
import platform
import tempfile
import json
# from key_emulation import *
# from sign_emulation import *

class VivadoInterface:
    def __init__(self):
        self.vivado_path = self._find_vivado()
        self.temp_dir = tempfile.mkdtemp()

    def _find_vivado(self):
        """Check if Vivado is installed and return its executable path."""
        system = platform.system()
        possible_paths = []
        
        if system == "Windows":
            # Common Vivado installation paths on Windows
            base_paths = [
                r"C:\Xilinx\Vivado",
                r"D:\Xilinx\Vivado",
                r"C:\Program Files\Xilinx\Vivado"
            ]
            for base in base_paths:
                if os.path.exists(base):
                    for version in os.listdir(base):
                        path = os.path.join(base, version, "bin", "vivado.bat")
                        if os.path.exists(path):
                            return path
        elif system in ["Linux", "Darwin"]:
            # Common Vivado paths on Linux/Mac
            base_paths = [
                "/opt/Xilinx/Vivado",
                "/tools/Xilinx/Vivado",
                "/usr/local/Xilinx/Vivado"
            ]
            for base in base_paths:
                if os.path.exists(base):
                    for version in os.listdir(base):
                        path = os.path.join(base, version, "bin", "vivado")
                        if os.path.exists(path):
                            return path
        return None

    def is_vivado_available(self):
        """Return True if Vivado is found, False otherwise."""
        return self.vivado_path is not None

    def run_keygen(self, id_prefix):
        pk,sk=key_emu(random_bytes(32).hex())
        return {
        'pk': pk,
        'sk': sk,
        'pk_id': f"{id_prefix}1",
        'sk_id': f"{id_prefix}2"
    }
    def run_sign(self,sk_hex, msg_hex, id_prefix):
        sign=sign_emu(sk_hex,msg_hex,rnd,ctx,len(msg_hex),len(ctx),len(rnd))
        return{
            'signature':sign,
            'sig_id': f"{id_prefix}3"
        }



    # def run_keygen(self, id_prefix):
    #     """Run SystemVerilog key generation in Vivado."""
    #     if not self.is_vivado_available():
    #         raise RuntimeError("Vivado not found. Cannot run emulation.")

    #     # Placeholder: Create Tcl script to run SystemVerilog keygen
    #     tcl_script_content = f"""
    #     # Simulate Vivado key generation
    #     # Replace with actual SystemVerilog project path and commands
    #     puts "Running key generation with ID: {id_prefix}"
    #     # Output result to a temporary file
    #     set result [dict create pk "pk_{id_prefix}" sk "sk_{id_prefix}" pk_id "{id_prefix}_pk" sk_id "{id_prefix}_sk"]
    #     set fp [open "{self.temp_dir}/keygen_result.json" w]
    #     puts $fp [dict get $result]
    #     close $fp
    #     """
    #     tcl_path = os.path.join(self.temp_dir, "keygen.tcl")
    #     with open(tcl_path, "w") as f:
    #         f.write(tcl_script_content)

    #     # Run Vivado with Tcl script
    #     try:
    #         result = subprocess.run(
    #             [self.vivado_path, "-mode", "batch", "-source", tcl_path],
    #             capture_output=True, text=True, timeout=60
    #         )
    #         if result.returncode != 0:
    #             raise RuntimeError(f"Vivado keygen failed: {result.stderr}")
    #     except subprocess.TimeoutExpired:
    #         raise RuntimeError("Vivado keygen timed out.")
    #     except subprocess.SubprocessError as e:
    #         raise RuntimeError(f"Vivado keygen error: {str(e)}")

    #     # Read result
    #     result_file = os.path.join(self.temp_dir, "keygen_result.json")
    #     if not os.path.exists(result_file):
    #         raise RuntimeError("Keygen result file not found.")
    #     with open(result_file, "r") as f:
    #         return json.load(f)

    # def run_sign(self, sk, message, id_prefix):
    #     """Run SystemVerilog signing in Vivado."""
    #     if not self.is_vivado_available():
    #         raise RuntimeError("Vivado not found. Cannot run emulation.")

    #     # Placeholder: Create Tcl script for signing
    #     tcl_script_content = f"""
    #     # Simulate Vivado signing
    #     # Replace with actual SystemVerilog project path and commands
    #     puts "Signing message with SK: {sk} and ID: {id_prefix}"
    #     set result [dict create signature "sig_{id_prefix}" sig_id "{id_prefix}_sig"]
    #     set fp [open "{self.temp_dir}/sign_result.json" w]
    #     puts $fp [dict get $result]
    #     close $fp
    #     """
    #     tcl_path = os.path.join(self.temp_dir, "sign.tcl")
    #     with open(tcl_path, "w") as f:
    #         f.write(tcl_script_content)

    #     # Run Vivado
    #     try:
    #         result = subprocess.run(
    #             [self.vivado_path, "-mode", "batch", "-source", tcl_path],
    #             capture_output=True, text=True, timeout=60
    #         )
    #         if result.returncode != 0:
    #             raise RuntimeError(f"Vivado signing failed: {result.stderr}")
    #     except subprocess.TimeoutExpired:
    #         raise RuntimeError("Vivado signing timed out.")
    #     except subprocess.SubprocessError as e:
    #         raise RuntimeError(f"Vivado signing error: {str(e)}")

    #     # Read result
    #     result_file = os.path.join(self.temp_dir, "sign_result.json")
    #     if not os.path.exists(result_file):
    #         raise RuntimeError("Sign result file not found.")
    #     with open(result_file, "r") as f:
    #         return json.load(f)

    def run_verify(self, pk, message, signature):
        """Run SystemVerilog verification in Vivado."""
        if not self.is_vivado_available():
            raise RuntimeError("Vivado not found. Cannot run emulation.")

        # Placeholder: Create Tcl script for verification
        tcl_script_content = f"""
        # Simulate Vivado verification
        # Replace with actual SystemVerilog project path and commands
        puts "Verifying message with PK: {pk}"
        set result [expr {{1}}]  ;# Simulate successful verification
        set fp [open "{self.temp_dir}/verify_result.json" w]
        puts $fp $result
        close $fp
        """
        tcl_path = os.path.join(self.temp_dir, "verify.tcl")
        with open(tcl_path, "w") as f:
            f.write(tcl_script_content)

        # Run Vivado
        try:
            result = subprocess.run(
                [self.vivado_path, "-mode", "batch", "-source", tcl_path],
                capture_output=True, text=True, timeout=60
            )
            if result.returncode != 0:
                raise RuntimeError(f"Vivado verification failed: {result.stderr}")
        except subprocess.TimeoutExpired:
            raise RuntimeError("Vivado verification timed out.")
        except subprocess.SubprocessError as e:
            raise RuntimeError(f"Vivado verification error: {str(e)}")

        # Read result
        result_file = os.path.join(self.temp_dir, "verify_result.json")
        if not os.path.exists(result_file):
            raise RuntimeError("Verify result file not found.")
        with open(result_file, "r") as f:
            return bool(int(f.read().strip()))