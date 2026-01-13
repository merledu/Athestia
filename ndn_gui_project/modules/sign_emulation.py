# import subprocess
# import os
# import vcdvcd  # Ensure this package is installed
# from Dilithium import *
# import os
# import subprocess
# import shutil
# import sys
# from pathlib import Path
# import urllib.request
# import zipfile


# random_bytes = os.urandom
# ctx = os.urandom(128)
# rnd = random_bytes(32)
# def find_vivado_path():
#     search_roots = [r"C:\Xilinx", r"D:\Xilinx", r"E:\Vivado"]
#     for root in search_roots:
#         for path in Path(root).rglob("vivado.bat"):
#             return str(path)
#     return None
# def download_repo2(destination):
#     repo_url = "https://github.com/merledu/Athestia.git"
#     branch_name = "modules"
#     folder_name = "sign_internal"

#     temp_clone_dir = destination / "Athestia_temp_clone"
#     target_folder = destination / folder_name

#     # Check if Git is installed
#     try:
#         subprocess.run(
#             ["git", "--version"],
#             check=True,
#             stdout=subprocess.DEVNULL,
#             stderr=subprocess.DEVNULL
#         )
#     except subprocess.CalledProcessError:
#         raise EnvironmentError("Git is not installed or not available in PATH.")

#     try:
#         subprocess.run(
#             ["git", "clone", "--branch", branch_name, "--single-branch", repo_url, str(temp_clone_dir)],
#             check=True,
#             stdout=subprocess.DEVNULL,
#             stderr=subprocess.DEVNULL
#         )
#     except subprocess.CalledProcessError as e:
#         raise RuntimeError(f"Git clone failed: {e}")

#     source_folder = temp_clone_dir / folder_name
#     if not source_folder.exists():
#         raise FileNotFoundError(f"Folder '{folder_name}' not found in the branch '{branch_name}'.")

#     if target_folder.exists():
#         shutil.rmtree(target_folder)

#     shutil.move(str(source_folder), str(target_folder))

#     # shutil.rmtree("Athestia_temp_clone")


# # === Configuration ===
# cwd=Path.cwd()
# VIVADO_PATH =find_vivado_path()
# # if not VIVADO_PATH:
# #     print("[ERROR] Vivado installation not found.")
# #     sys.exit(1)

# project_dir = cwd / "sign_internal"
# if not project_dir.exists():
#     download_repo2(cwd)   

# all = str(project_dir / "sign_internal.srcs" / "sources_1" / "new")
# TB_FILE = str(project_dir / "sign_internal.srcs" / "sim_1" / "new" / "tb.sv")
# DESIGN_FILE = str(Path(all) / "SignInternal2.sv")
# PKG_FILE = str(Path(all) / "Dilithium_pkg.sv")




# # === Configuration ===
# # VIVADO_PATH = r"E:\Vivado\2018.2\bin\vivado.bat"
# # TB_FILE = r"E:\sign_internal\sign_internal.srcs\sim_1\new\tb_sign.sv"
# # DESIGN_FILE = r"E:\sign_internal\sign_internal.srcs\sources_1\new\SignInternal2.sv"
# # PKG_FILE = r"E:\sign_internal\sign_internal.srcs\sources_1\new\Dilithium_pkg.sv"
# # all=r"E:\sign_internal\sign_internal.srcs\sources_1\new"

# print("Exists:", os.path.exists(DESIGN_FILE))

# VCD_FILE = "sign_output.vcd"
# TCL_SCRIPT = "run_sign_simulation.tcl"
# WORK_DIR = os.path.abspath("vivado_sim").replace('\\', '/')
# PROJECT_NAME = "Signinternal_project"

# def quote_path(path):
#     """Quote paths for TCL compatibility, especially with spaces."""
#     path = path.replace("\\", "/")
#     return f"{{{path}}}"  # TCL uses {} to wrap paths with spaces
# # === Dynamic SV code generation ===
# def write_signtb_sv(sk,msg,rnd,ctx,msg_len,ctx_len,rnd_len):
#     tb_code = f"""`timescale 1ns/1ps



# module sign;
#     // Parameters for the testbench
# //    localparam int SK_WIDTH = 8 * (32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta)+1)) 
# //                                                   + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1;

#     // Testbench signals
#     logic [8 * (32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta)+1)) + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1:0] sk;
#     logic clk;
#     logic rst;
   
#     //logic [{(msg_len*8)-1}:0]msg;
#     //logic [{(ctx_len*8)-1}:0]ctx;
#     //logic [{(rnd_len*8)-1}:0]rnd;
    

#     // Clock generation
#     initial begin
#         clk = 0;
#         forever #0.0008 clk = ~clk; // 100 MHz clock
#     end

#     // DUT instantiation
#     sign_internal2 #(.msg_len({msg_len}),.ctx_len({ctx_len}),.rnd_len({rnd_len})) uut (
#         .sk(39168'h{sk}),
#         .clk(clk),
#         .rst(rst),
#         .n_msg('h{msg}),
#         .rnd('h{rnd}),
#         .ctx('h{ctx})
#     );

#     // Testbench logic
#     initial begin
#         // Reset sequence
#         rst = 1;
#         #1 rst = 0;


#         // Test case 1: Initialize inputs
#              #1000;

#         $finish;
#     end



# endmodule

# """
#     tb_path = TB_FILE
#     with open(tb_path, "w") as f:
#         f.write(tb_code)
#     print(f"Testbench written to: {tb_path}")


# def create_tcl_script2():
#     tb_file_tcl = quote_path(TB_FILE)
#     design_file_tcl = quote_path(DESIGN_FILE)
#     vcd_file_tcl = quote_path(VCD_FILE)
#     work_dir_tcl = quote_path(WORK_DIR)
#     pkg_file_tcl = quote_path(PKG_FILE)
#     all_tcl= quote_path(all)

#     tcl_content = f"""
# # Normalize paths
# set tb_file [file normalize {tb_file_tcl}]
# set design_file [file normalize {design_file_tcl}]
# set vcd_file [file normalize {vcd_file_tcl}]
# set pkg_file [file normalize {pkg_file_tcl}]
# set all [file normalize {all_tcl}]

# # Create or open the project
# create_project -force {PROJECT_NAME} {work_dir_tcl}

# # Add the testbench and design files
# add_files $all
# add_files $pkg_file
# add_files $tb_file
# add_files $design_file

# # Set the top module
# set_property top sign [get_filesets sim_1]

# # Launch simulation
# launch_simulation

# # Add all signals and dump to VCD
# add_wave /sign/*
# open_vcd $vcd_file
# log_vcd /sign/*
# run all
# close_vcd

# # Close the project
# close_project
# exit
# """
#     with open(TCL_SCRIPT, "w") as f:
#         f.write(tcl_content)
#     print(f"TCL script written to: {TCL_SCRIPT}")

# def run_vivado_simulation2():
#     if not os.path.exists(TB_FILE):
#         print(f"Error: Testbench file not found at {TB_FILE}")
#         return False
#     if not os.path.exists(DESIGN_FILE):
#         print(f"Error: Design file not found at {DESIGN_FILE}")
#         return False
#     if not os.path.exists(VIVADO_PATH):
#         print(f"Error: Vivado not found at {VIVADO_PATH}")
#         return False
#     if not os.path.exists(PKG_FILE):
#         print(f"Error: Vivado not found at {PKG_FILE}")
#         return False

#     os.makedirs(WORK_DIR, exist_ok=True)
#     create_tcl_script2()

#     cmd = f'"{VIVADO_PATH}" -mode batch -source "{TCL_SCRIPT}"'
#     print(f"Executing: {cmd}")
#     result = subprocess.run(cmd, shell=True, capture_output=True, text=True)

#     if result.returncode != 0:
#         print("Vivado simulation failed:")
#         print(result.stderr)
#         with open("vivado_error.log", "w") as f:
#             f.write(result.stderr)
#         return False

#     print("Vivado simulation completed successfully.")
#     return True

# # def parse_vcd_output2():
# #     if not os.path.exists(VCD_FILE):
# #         print(f"VCD file not found: {VCD_FILE}")
# #         return None

# #     try:
# #         vcd = vcdvcd.VCDVCD(VCD_FILE)
# #         signals = [sig for sig in vcd.signals if sig.startswith("/KeyInternal_tb/uut/")]

# #         output_values = {}
# #         for sig in signals:
# #             value = vcd[sig].tv[-1][1]  # Last value
# #             output_values[sig] = value

# #         return output_values
# #     except Exception as e:
# #         print(f"Failed to parse VCD file: {e}")
# #         return None
# # def parse_vcd_output2():
# #     if not os.path.exists(VCD_FILE):
# #         print(f"VCD file not found: {VCD_FILE}")
# #         return None

# #     try:
# #         vcd = vcdvcd.VCDVCD(VCD_FILE, store_tvs=True)
# #         output_values = {}

# #         print("\n--- Available Signals in VCD ---")
# #         for sig in vcd.signals:
# #             try:
# #                 value_bin = vcd[sig].tv[-1][1]  # Last recorded value in binary
# #                 if value_bin.startswith('b'):  # Example: b1010
# #                     value_bin = value_bin[1:]
# #                 elif value_bin in ('x', 'z'):  # Handle undefined/tri-state
# #                     value_bin = '0'

# #                 value_hex = hex(int(value_bin, 2))
# #                 output_values[sig] = value_hex
# #             except Exception as e:
# #                 print(f"Could not parse {sig}: {e}")
# #         return None
# def parse_vcd_output2():
#     if not os.path.exists(VCD_FILE):
#         print(f"VCD file not found: {VCD_FILE}")
#         return None

#     try:
#         vcd = vcdvcd.VCDVCD(VCD_FILE, store_tvs=True)

#         print("\n--- Available Signals in VCD ---")
#         for sig in vcd.signals:
            
#             print(sig)

#         output_values = {}
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

#         return output_values
#     except Exception as e:
#         print(f"Failed to parse VCD file: {e}")
#         return None
# # def parse_vcd_output2():
# #     if not os.path.exists(VCD_FILE):
# #         print(f"VCD file not found: {VCD_FILE}")
# #         return None

# #     try:
# #         vcd = vcdvcd.VCDVCD(VCD_FILE, store_tvs=True)

# #         target_signals = [
# #             "/KeyInternal_tb/uut/dut/sk",  # Adjust depending on exact signal path
# #             "/KeyInternal_tb/uut/dut/pk"
# #         ]

# #         output_values = {}
# #         for sig in vcd.signals:
# #             for target in target_signals:
# #                 if sig.startswith(target):
# #                     try:
# #                         value_bin = vcd[sig].tv[-1][1]  # Last value
# #                         if value_bin.startswith('b'):
# #                             value_bin = value_bin[1:]
# #                         elif value_bin in ('x', 'z'):  # Handle undefined
# #                             value_bin = '0'
# #                         value_hex = hex(int(value_bin, 2))
# #                         output_values[sig] = value_hex
# #                     except Exception as e:
# #                         print(f"Could not parse {sig}: {e}")
# #         return output_values
# #     except Exception as e:
# #         print(f"Failed to parse VCD file: {e}")
# #         return None


# def sign_emu(sk,msg,rnd,ctx,msg_len,ctx_len,rnd_len):
#     print("Starting Vivado simulation...")
    
#     write_signtb_sv(sk,msg,rnd,ctx,msg_len,ctx_len,rnd_len)

#     if not run_vivado_simulation2():
#         print("Simulation failed.")
#         return

#     outputs = parse_vcd_output2()
#     if outputs:

#         print("\nSimulation Output Signals:")
#         sign=outputs.get("sign.uut.signencode.sigma[37015:0]")
#         return sign
#         # for signal, value in outputs.items():
#         #     # if (signal=="KeyInternal_tb.uut.dut.sk[39167:0]" or signal =="KeyInternal_tb.uut.pk[20735:0]"):
#         #         print(f"{signal}: {value}")
#     else:
#         print("No signals parsed from VCD.")
#         return None

# # if __name__ == "__main__":
# #     # zeta_value = "24caa1b44d22446b945452a70af1d8b83f6adbd0030f12d11c684681596d4ca5"
# #     # zeta_value = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcd"
# #     sk="455d6be82563c9fad3f40e4c163ba5b9b59e38fc131154ad747158900e60b6254d592c6ce177477e0a7340c4de6329804d5b648cad995d3289c2dac39c15aea8d31a12fa1e454705a062c81cee046cd2cd683d027cbac72b0bfca47c4d3ddea00082548802f683b1c8df3708cba1c1ec5d0882831289aa1f1427d0eb25202d2f252dda80f93c0da79f5330620ee23a792622c80b41ea8f13d0d16b56303b289f03879625a1b31e4fe341047348894cba1b627416f5997169490dd5772802ca1343b997dfc056667e5ae135773cb0d7a30c8fa532de2cf995acc7197a648c77b753346cb6487ee17fb6cc085127cc34b31f88aea2b3f0c2ba57170ddc7d015578ba63bd5fadd389f2b15b5dd9451c6a5b3b890cc372212696971b81578c967adf864c3b3e4d554c03554aaf76f56740e2c652357e5fb99ea91daaa9ec2ffcd5386c88e1d925b65546dd9ef39059b009aead9d9dffe8303c79d69dcd2ce98ed71d63ef2b7a6536ebaeb7c4554c1b730e9ed40e3e2cb2d5821ec17606618b0da687036044a69cb7c01d1198eecc48c431a106837fb06f24b10ec0bdb692785136751043f8df84eb284977f82b537f621573f5b84169e184a726ee0e234eee10a38e16b894286978f9aa30cddcb6e6747dc803d44e1313028082468d094d34c9c0bebc2b32b4a59ac71517b4a662ab645cdde63194a30b6fa9d922f62d1f861d544a83d195ba2f67d66543b3a208762359b119b0b049e00f77094248d55a9ac8901707e0459b5d1ad63135e39a8dc7043127380f145705ccf3a3e70dab1ba444a9f184424612875624fc45a7b536e6f1dd65c27b123fd680e56f48c3745c9d56c3d8e57e8ca43ee030c3284aa900320597a6a557e56b1b981e0cbd5094425926180a3b10a9841aa9d95d425f5cc3fd41069f7f1066ba8fb638263258e19aae1ea280938de844ac02a6285c32abf97bf5182f644e29326257a71807f7a343d2dec313f879c0118f73b0ee8b49c35b6124723055a82bb6305bc41de84f2bb08b9beededc1d805c53e5f97eeea92047f693ba59bbb1c0e3360c2f0bb607ba47e35aad33da820bdb7cd515dcc0a167e0f249dd33c5abe5ee6f650c6ea782390bf5c633388ae89fd7f717e83bcba86eaf6c4ae03daa37900f8141f704c10233b41b11fb819d7badd586219346e64b83344fc2fd8634b7c59d1223bcb18742c796715b67305483b9dd988480c36984541a78dcda3dc0acf731894c72aae29ec30501ab0c3b88aebdcc7998fecb1879713b4ccd346d69dcb57ff6e6d60accc64c31f8a11c1128c8262c171a1d0135b222dbc806aa1b42dbba240cf36ae104fba9e5503c91153ea0d4ad010a4dac212db82ddb77def4111bf46e535932cb26b10cc48ef119324a09f8322d36b1ee58a4843ededcf121268f4b915864385606b303580eefdeefb078ec2984cc3e047a32bd126fc5ffaf4615229e37bfab11eb071228384c79d2e02b0f6bd1e668b9ff167acc89e8f54ef54b56b519c1ee50849d318a8efebee8612c36ba9c0a5f3a282e3825f73be37267f5fb4b58c0abc29fbc44fb6175c3ab3f09642d76d1eb1ad73ffe777aece0fde14b08b66b99850e17c4b9572f253a46d56fa384f0b4ff1f6a32d5960ca97d34d67f5287bd5abf5f58fc407eb908bc8bc252af9b4447116fe977c8064569945cf11289a3610bb278295cefb10c608cb491863978eae83ad095bddad06ef0dd9cb8702064e7803c94f0995a8a34f1731833c90e55857b0ef2cdfea78d324a87243949d349b603f93ff0cf91c7efbd1d52a3c26e5d9f6d9a56c41c1c944f72a44bca4191fcf32962e60518a4c68c0ed9acd384c299e88c2218f3d1b82c7cab0a8a3d269ac4c9ad45280baa690d534a6cf0d323718ff0c264add0233872017d135b9adc42e77d4210a5dcd3807407281e264248d02780ad29b4527d969769789cdf3f0a7e4762fd4f359d66f636a492176b1ce858afaf34cf23c2009a4fbadeb7193e8ec501fa6693cf46e2bc9abec53e7586cef96b592e614815ce13ba52a55b23a8dc61939a0801ed0c8774c67bed1de223cfa8c02984f28e72054c5f91ebf682ab01476c163342d65ff277fffeb687c87dc4a60c2025f6461915421e54e8a792667ed4c2aba457b0b585069baf9cba2aa8e11549517ce398fb8e1f313e1487277c445f97deccd218d1d9e8ba6c2f62f2b55cf576597af90c3fccc2a61c8636fe80034127236661ce71e64c29d3f9b5c9976d44f70776aa7e7743018ab550b5a2e9c1e889973b4b21afd25d4ca0edea4cba98200bb58298e67371ed267500fdefc549790545a16cbe6578df59ab794ef2aca06d10a2dc7b21d41f5c280d5bdedeac2d056f8f03c7042bcd627ccce177ba66308a39ad1dbf724001fa525324578bab9ef4e3bea48d37e1474ca16658a8503d7d24347c82eed47012a555e81f85c17152f8f26ce6740e3b8e0bbceefcb82c607188d05031c61956a12c63dc6f2b7bd562ee4f35d2df2acb025cacaa9410f624f87b86834c897946f17b0739d1fdd5a731e09066fdf81ade21cea101f622e4be0dc7d9fa00def72a051ba7db3a9b72e9c47bca1dd2bc896a3a4a0ba4ef2f91702716d83f850c11a64c5839cda625e0742307c7a835155e2eae89e2cd012f45275e696cdc0c3bcb11715eee6751601ff726dc0db12abd0dc858203a265865afeb04aab8ddadfe387ff96e59dde339f495c95077355691056739e9e10d5edc65975bd620c1a3c89fdf3f43783149cd8fbbf78e7c8bb9d42119552ada258cb6c4142d0175390f88db4f8d4c2d6e0d62311d20f69d7c5143627e6f813333162434fa2c525f0a14faca09e1e9fd2dac6f92a3e07a5faddacf993054c6800f02a5c12660895d1b18b279cbb5f6ecef2deba7ceb91f960999ecb49d8c31c5fe0bbb320e838543f4470be1e83acc7be4198db8ad032c6dbd7e07e114a95574a346e083027fe573713a064b9e6a29aa9cd9086a594ba97f0ff4f7661a605c06c85cb1638addd090d236aecb2065c9985ba380812ab836af8d2741e7f8d04b0e795a8e0147b72e330f9639d6747a0fbf17d79c1ac2b9fdb0b5c7f0408bafc4484e7d51cededb38673fe9d55aafdf36fe94897a67442807bfe9b3133e190455d7ee46d7921f81d977f7f17b9699a96bf384517aa074e95600bb5b4528a341a3f2b8913d1fc77f3c3db11c5ce18e9822b3bd55a79a988491a3581f72583ff4f41ea1d4288287c30e806da6a40404477f6b5a08c97c8a857d7c9cc99692e791118b9e756104b701ef1edcb95e4ce9b638f9cf86a719735f67b4e6767675d0baabd396bd0bbb47b71269a0eb150bfab8e310c3d425a639d915f11813bd02f61d5eee32482e16e5229bece7686ff7c906799394d19649fd433c4a7f4a9d41faf5148c2df567d4286112df1fff31441d74b7fd3fa894f4be06c923f00946a99301acc15fbcc85d60af4896948699141fcbba251749f45a386de983ab2c3a62660a83cd209210c180d41a6ff6aefc563d5fd40d49b51ed1d978606dfc5f807d3f4e83c0958af0dc5e473ae12e388533e806ae7ea6011df72ac7e30ad60828ac6ce086fd36f548f84dfe1f0f6a6575f988d37e07408dd629c68db836508360e6b7f985a07238e38a0fd7c80623c66cc77414fc6538c56ca223042c734c5a68481f79708968965f12bd183a150dc77032e057c3ba318f6b735dfa717e19e652b68c8c81597b6233c7a6eb89f51ebf66ffaa6f0c1912335e39869d5e9b416e171d428a9e2304253f9eeed27be88339ab40bb95cd308c23f24e4f240cf22b9000ce5f9e99f7ba17efb8f4eeb858aa053adc4ad154f27eb7474c3569b2592530dbe94dca356b42529e786c433e5340c448a07b337dd1043acd6337943be7ea2e6275cc8e315f9aa4e94e853915aa1415878d1a3c5a23c157a19bef0defcd22645d4d9e624e85f6958213efa28e2a8163f73486725ac5f1ae80baa8914ad26d4d00a7bf523b01c17d0d2b2a9e99773b176fe9add22479ab403e777290bf6f8bed184888a4e75dff0a5f88af1fb2877877c6dfca359918ac6a7579842c12257084ab5819296527ae4e8d2a5c019d44b1c70490b20c04f0a2a140b6d4d3eeb21656edbd2d9be62254affd68260a586e62455b17470199803bb0a63f0fb305f249400ddfa64e8cec0042785835b64a0767d0933378051c6e7a3817a9bbc84fe85f279ad041fe22727aa6bae31e31c35361189bf6c592c48dfa94362432b4814c502c03461226a974d7951bbed967cc18728f126bfabceee672efb3a1f59948171415fe63cb65c45096742a9a6c463d180f2cf0f0ba28f6766b6584589d82b9e3ce327f87fe6f1a49bde9df5b5c7a0fad0004e5c529ff69c186a21c80eaf704764c459b053f77b8a09f46f5b3120622283e26eaf238df503176ab7d6e7287099473dfedd096086497ac8efcdab28e41164f01b2a1a44442c867748609c49ceda6d497e13b4b4d3fdc0181bfe4cf7e643c539803bda27e3aad768bec71bc04832814748777ff817247a1615239e008719c46083ce6d3e5180ac1871637e3bb95b05cd77805015303a09d51009cfae09711731ef3780aebe0badabb0f3972ddd8554bc3c673714f4e5a6078ac38140c80b2dd5f58a1670f604a8e9530c4d7cb03762a2ff326806a10cd6cc7d6740518e48d94136c025801212150928c81a0894002cc86044971250a6934009220c19034cb30c2126c42a36d080a3146d82040dc65a21924381369c3247034dc8536d805a6db6d88d02c24418c271805104c20304204b8d269c20a6cb61289a09172320809171969b0402a405b0030a164b8c28182c461928109c82201380851b08130268b29c70c0002a448a8196c32190a02d92d102370a10c2c33108cc68925071182449810a1186cc88291891206150b62388c4226218818626c228b2a348c8e08920136d22a424910c70882004808c4912a16c304c6c104469c0dc69c21045b45449b8e32102e02c325b10b2926434a04c14947204d105320485c6dc11b89228c21c2425085180126538124947020a30c021a04a90b50251a8128442e40505227130c064982402280289b21130848821404a4a00596426234948ca82045065c4a489870c81990240b8022d32992590610e36c020a0044e425a6922da89c50a0102e411004c71061365a8584a00826627225206d46590a12c909172289c00901b80108c2db51a64a0a481b8cb7004946240da6528984d12c470b8629106405104228546806db8989130930435020642c032184c8e068308486352412051a6c42220a052121381851a0030240840008d41208604639036003090e484a81a04a22120329c2d44489215208110e40038519092db2da5207006586a10238c132191231424029229c8d12a44880498e45239000187100506222d40e28e32c10990c160844c8c16da20248806325408b80c9018231088ca7134621092905020d161411370c69a50051130b6494525100a312365041c2906842ca4c80488500d245868a6d98428044c96900038a380325b89285a0d40582e08c900a1040c91020e32a08024c92191036c385960860025c0a04094046d460b24241c4cc11c41400c1188ca11925268909b0034880e029b6247044c229a6600632cc4592824902238042910480a366148c4430038483148914981044212412c82dc6936da2c96820526e372148188b2c171c2206e34536e230a70861960a66368c64a2db8d86212148130d140a6046a04104012e38a26548c86d880902344a5092228504890532940128a19240146d865185224371b8d100929250a5118108c98902d130b69200240a41188a2d30530126e006304889c0a26490a06e12d27186915236448c100905b84869128a0130c850871301825c3225134828dc44380c0a104c45121945a2db2430909185186a106100a0d344c6d960a6d48c91140480180444d26db9046832984a22cc3012822c01232641117120a286464985181061b2c424905024800c2847010144c410141325408342021046151460c4a12db8c49128cb6e085b4934212d38239048cc6628c28140c480c11104864029486140370989c9118a14a310c7237210d921a28c8588628e17214530644232022136cb64965044040c21c7228e428325c8200409026494db10a4dc8d34536e16102cb41289930240424a8612049093102d46c110c7202a44418880134480cc4cb49030b24a08a2936226e429949929080c50050840401c6425104020623088d488c49100a81866110a8814c049c6998084924dc0816920126cc0400896cb6534db40831a4c401a31a8cc8216813020c32d24400e36d851b81b9245030c032012184464a6c14822d285011a08872409b30b68b2980126646d060c2014094244094db64c12040a72388150164185881c00891861b30249c48912165c92345460b0d410b6802a00ca0890445230cc6908c800882185a70110351472041a88001b8628918229026984439206101143124a21008c42c08a22526d069872248262409b81c7234434d22606890636cc09a7093210807130e02082112e471084981a6845202d18016199146224cb05c6cc28c61a60924230b8a440441c49c50c8c861451989880c29091c08460340a49c6486428410d309340841946190b04b4c344050271490870a85a50100b2c24e326345932dabe16a9633e1ed6fcdba043a43d15d525e1c6fbeb4a7af2d7cfe86969836bbc0ec52ee75bec23491ca1b17af8451e9f15a439e7f0305889b7032eca720bff4f960eca0d813e78aacc8f0cbda2a906c6e3fef616477bbbbc252095d721d1b3de50f981723b8110b744ce4763cb5daa32268ccb64ccb6a945e9f98a2b51e1d7"
# #     msg="3885fa51de5e7bda99638ada5208711fb0a214b1f9f19946eb2f9f7bb7b2ee9a0334b41338768cf0f289ce4cda61abc70e64d296291c8047ebb466afbf0022e774efd61e545de73a1523be6f224c6c8a83d76d52df5871e7b36d28830fdd31f266e7d8eb8a8d73b17d9880055d11249e48dc2be792d0081c7dee6ae735632a38f2cc093b7480fff664bcd446d76b89a248893b33b2495f96debb6d9b228c7b1a6e48139108e829c7dd3483d6fbc1441265c89eab27f686a86d725cb91363d4d740bad88f57f89a5f5f74567dc6889b1c775b3659edcff277c16b23958c70b47960ab9641e9b5ba6d2e3f4cb3a008e2e4d73f42b72c7aea70c760cdecd404d3efbfdc1d1af15933c1a0c92bae833fd6b8893fbd4c2efc4ce5c1257989e7ce98296b5df3c4ebc7f27d0c8016634f3bec87891463954786c0c38f3759cce0a9d9d2300142264c12cdc24c3f3faee5e9968539f2ffd36a03e2e49c3034b36d269d62a644334df8c63b7646a148074712dda6a1d393eda906672c1f5d8a1cdd1a5425a1dc07a1b6488c72b7898cc9bada9d8a528e129993b0b9a0dc062e9b3c1f982c4c23656a0a3bf058462036207a9e7244c0ffc94f07ba92f12367c5af1af13698f05f7c9774337f169eb952737998253e94e9da3c55492592907446a376403e55e99e301a21dad08c80b2b04d671e788b41871b3016fa42a63aea0600ecdca05e7bfd89da680a1cb9194ebca298d72b72fbbb61ef240d3eef5b89e036d3cfa0a31252d269949d23376a6217c83da00d62bf9404317ab1396dbf997fde29e6e649ae18904504c1dd5e972a84c2f675b1bb7c7d773fcb6e29601965aafa1e450d847ccd1a250fc85dfeb6a599502c77764ae7c362ac6ea77e3fef302c9f17e240521d0046295a8cacb31f798825d4d833a2ee60135ae26115d54fdb36df9bbee6d46446332c304def5b16ae8cf51e586a16fc8ab1b6cfe66fbceb71da7f56cd186192b3c08ea50771a170b74334d420b6f6701fe2110c2f057ed67741bf72700549952a626b98dc71f5180f4617a23be7cabbe30e36ea065562ae41b72ec6b12e00b2fa9eaabd4a5e94aeecf8fce9eddc9b8f76048e61ce5e8fd5ffbc5625432f67e14565a89c3c0c70857a87fd0d5879c1651b9e4fad9f9fe39b0fd5bd8e086f6bbd911ba38734ff53699409e64761817c86fbf109a5dfba41a6820c8c674ee27d0b1c407c3cd539301b4be61896b89c3a8e5837921665c6ddd7dafd052773eb1ab28cdb2a200440b1c2c0ed5af9a1abede5d2fd0e174f66a55662a462d73308a85fcb660add7119891885d055786ce3362f0f205575dd02622535d4be60ddd98eb845fa2e3aa11074b974f5917f102de97e6e33c813b33281c804e4a89d5b293bac419d3271b5fb8dfeac9c01e770e21507ea3ff1aa107b0412796536bc68d65d4abae53e72fb78c872a5c96717319a5721cfa1b21b37909bc69920f850c4d196d53eb62c8ba4a20c71767e044713ece0de0d15edc62441132a4a77d9da8078aed43292d97b6ecc7c2c9440a5b98b54b2ac401942afe3cfb0fca302412cc931f1fdd03014811364704198c131e39c5a9ef6c52c996636fef163e1dcd86b8b4f62634fa7e85b3f3198dba80016219dcd6049644b679d988ac7d13fb19f378c04b6495ece94f47142b69493bebd35e8cfc5147c8f0740e8c5cac5e0161c8e91614fa44acdc3ce386bd72194d309dacc92e96feb8bbbfdfd75609804cf145a262702326e19ea1a0bf6db10b7e6ab15bcf0f84d2caca206a651a7d46c2bca69567cfb6cd0d76bb2a7ce64f5afaa4516ca4bdb13d6c62e7984fc8b1d7215aee02c71ba3aea3e44e58546a65e48ad56fb0b900a214fb6938f4e81e8d34b4e3f912083c93ef00a2c8c06f68e9020cf30d7a69011e20b8d9175de2aec685670993606143dc5e4170b00647e1a5827026f7e51102dbb3c5d8693f2535fc51ec335955c578a0b926bf28e84107e8d73384ddbbb6d174543defaa88eaad391b745e2a04884fccf7863ece51d9e362cdff820b905840ab0abef527d5de17ce79861d63e2edd44ee3b7e6257813128a5a8cec9958a198b333b31f558327e7297e6044dbbc7f7fd01b4317d8721b32f79c7add58f17e75d7ed6a303fce8ebbcbd0bcb707de46cddb0d0c7e1599b031188027b9185a8e37fffa6cee524f30119c874c07b5642b1955bd025be4f0504e3d2917bf96d5a3714284b70d61586b8bcceae18e4da88bb4550e535b5832430f9a2eb12937807ac6e3dac530ad1db80d51768efa1ed20084ad535a987258190031b763429732444c602aaa62e34b0737565609d1b348e0c81e3c8be425e2448bb1c4fef5aa75661f324289e427ada1524c13422c4e475cf8c6ab246ab660168dd61ea12e5c119cd0ffea9f60befc90708b299802a0284d7a78062f0f40fb68d22c0c1e18fc83062a86613c63a7ec39ca0aa3df8cc803ddadd136a655f28d9ff471cd34b2ee877408236d8c4efbd9c28bcc54f4ad1bec0a282e6037c5dcb037f8c137e1eaa786eb832fd7695a879eb1f7642a89ad98e2d895b31c848e4fae3b7335837db3f7e7e44579717d4472af909fae3061b2269a6fde5f4c278af26d33719bf624f410fe0f8c36443417759423037bf4d00f4c894cab139f64abb069430c4dfbb88c8aac7eb030d57bd2664868cb29140f0d9d242512a979e0819963dbdd0127d989eb9678df761fde770d6a44cb3699829c5a357f19c6a5e310cbed16ccf9aed13e7ededf829b3f877d45be053f35154affd13f82dba8bfc345b368138909117d6e99065c57b9fff11aae01d40890a3eba6a216ebca2c0585bf1b99df331bfe643430a6a62eb8f335e13e682da6ebbaa50f8c6ce6e225b33283709d4c2010ce0eaf9d9fd7f9fdbcfdbee10a8bc3e7eec350f4cfa6af07821e8d6412ae1ba715d060597e194bd2ab11df7f38011b277eab91c9eb2b41275fa81b815a95eb0ed207cb3a2b6a69c5877e49bdd73fdf70f355f5671c41bbea8f4909d60dba881526c0ad3035e10c1441cc426ce193402fd89a9df49073e2805bd0aad26093c7ccf6248706929f3b0259d125400f4f08fc08ea0d632c9374b2de1ce4653629a3ae048576cd0c398d395f8baabf4ea2810cd7bed9769654a062afd43875bad5cc203d774b89d84befcf5cd41390e8b5643b9bd78d87503d17afe5141d2801077e89cf7a81c75707348bcf1a29c2410f79ea6ffce9d34844cff06f9ba4b42eb7ce455599d16e339cd484a301b84603556ed5aa32c8042dab318aba9167bb62706d074bd46ca73e0bb6d3285520468c89fd0a3ccf19fbffba27ba5846b3922519223294b0fa3ef8b7979e7bf4ebc87aeb0e20a46d8e9366610781bcb24ee74814ae0f32fda1cb8fbe1175277b700ade6f4f6d4882fdc79a9ecc33a968723678a0566746dc857d4932a0e64c196beaf10cb34d72d1aeb516d67494317e12174bdb0c772518b401d9d22405e2177b7122d142acb524c3970191407067f14bdb10899a711ce4c5d848a17390bd98d2ff6af361503b75621707757583c84399e89658f5687d0a644e0b6a5403b122d978ce5115648feb9fab178369a77f421005179b0a54a37a72509f2344c1115e65e49bfcc5773e3568aab94a40f9a0bccec94a5efc261874d543deb4c55ca6de89c92d750b727ca8c6d2226fab593988bfe2647b86b2623fcc1727719879600c03eac077dc2ba14c5ca18819f3b8d98c1a5604e2f82b47d756edb8f45afb005d72265bb098b1bc9431182ed52a484c034dab5742748d13e892e910ee62bcf151913aa7cd5d18f3689960b1effc62ad1e91a5a6bf93cdd8e502731daf90ce217416dd43ffa07eb624b7fea903db33fc204c025cbd0641bdc351b2cae9fb43d7db4f3dc91f2ebd6e12ff81f7a514d519de86fd638e71646dc52f709dedb3dc296416ddc49d6add018ea439cd844a08be8ca8fc630de05959dadff3ffae2f706f2358938e47007c63a9ebd4da47a6d98b16c20144c7791b83cd73f9cd66ed636f23daaa2bb67a778c3c88b9220b7f1233f678d8dc2e3b97ba3d1fc0c316aefcbc7875a66cfcbdc49c5a75183ebff9785e61b5d6ee148740f832ffeea6b9a4758d8bfca985c8a53748a43c81a92368fa4397726150d80ea7f134be3a0ccf2de2a60f8ab2b34fe285bc8e9e49d7f5a7d4c9f5ab0f474314b57d54a8511a6b2a798659eb9998b646f3a4eca4c249c4dffb9cd96017141eab52fac5356ea7917b415414b37e1a0e3c13aea75a5aae427ba874bcc4310b136567be88aed370d85c1371637e251151e18ead5c686cc440b4a8598ce9fadd3a4640bf5bcf816f68a2d65b46d93ad4469712cb3593aeaaf8a36dd3f679f3fe6146471d2d75b592601f34b992118d6779c402f5c72f97969795b6a851ad68eebed7f9f0921da6c0d1805b166ef518d726065a3266fe2731bea08587cf1d40b2b6460aba278cd55c1d421446c47137928cdf824b533687b0b0b841f1981f01c43fa86018fa5ebf9920fe1524e9d07d3d68e30aef8af56f7fce59f97f4ad3c40e3040172c112e982e2fe91a552152c6d04b1488a51422393a48f05aa055405e5d3a16f499c9512c4a5adccf91eb0a5e6b832934364b1eea0e06ecd320c3e7d8df9acd1b0a6e2d16f9f84e5a3762a75f4e91ef2d3c1c28022b2ce692ec7dfb766303e0071def440d66023a3dfcc4b2ab6f8d948ee4ca9cc372caffed779a2a7bfcd7f7337290415f4de1b729d1ea05567a4b235ee97c8198672c9442ef5685cbe7ce4124cd7f28df4c3540f30362e188c5a9733c76db8280465ecc560bfe6fe76beb420398e088fb125402a43b9e85044b0b8d45e359550c3bc0de7eb2d2d35dc559971820ddffe510881a12c8ee54b7d9c81af0612a04029635d7d8021a484f70b4ded2076ce36d1ba8356b4f32435d7c26a4fac7d2ecab558481eb0617d2f64fca92140f72a06ce4add4c8e498b353f28a6beb754d87adc8238c72daf866f3d53f2b84903f4df97638161a0e23c6bcc13de88bb"
# #     rnd="094f6d4459dd13164f8ef96200f6b87d9bfad2614a1b1ddb79616ed07e428f1c"
# #     ctx="be4dc6b9905e743fd17dfba4f3c871d9a72545b901f22ea8bee7b6a7e7c473c030cacd15d67843a29fb957245950a35ccad3ad24313768cc1e1dfba8a8cc580c093b7429fb5b032fe1a21a479a"
# #     sign_emu(sk,msg,rnd,ctx,3577,77,32)