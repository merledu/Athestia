from django.shortcuts import render
import subprocess

from django.shortcuts import render
import subprocess
from django.http import JsonResponse

def main_page(request):
    
    return render(request,"main_page.html")

def about(request):
    return render(request,"about.html")

def decompose(r, q=8380417, gamma=(8380417 - 1) // 32):
    r_prime = r % q
    r0 = r_prime % (2 * gamma)
    
    if r_prime - r0 == q - 1:
        r0 -= 1
        r1 = 0
    else:
        r1 = (r_prime - r0) // (2 * gamma)
    
    return r1, r0

def high_bits(r, q, gamma):
    r1, _ = decompose(r, q, gamma)
    return r1

def make_hint(z, r, q=8380417, gamma2=(8380417 - 1) // 32):
    r1 = high_bits(r, q, gamma2)  
    v1 = high_bits(r + z, q, gamma2)  
    # print(r1,v1)
    if r1 != v1:
        return 1
    else:
        return 0
    
import psutil

def close_open_files(directory):
    """
    Closes all files locked by processes within the specified directory.
    """
    for proc in psutil.process_iter(['pid', 'name']):
        
            for file in proc.open_files():
                if directory in file.path:
                    proc.terminate()
    
import shutil
import stat

import os
def home(request):
    submodules = [
        'SHAKE',
        'makehint',
        'usehint',
        'decompose',
        'pkencode',
        'coefficientFromHalfBytes',
        'coefficientFromThreeBytes',
        'powerTwoRound',
        'simpleBitPack',
        'bitUnpack',
        'w1Encode',
        'hintBitUnpack',

        # Add the remaining 7 submodules here
    ]
    selected_submodule = request.GET.get('submodule')
    
    #for decompose
    r2 = request.POST.get('r2')
    r3 = request.POST.get('r3')
    z = request.POST.get('z')
    action = request.POST.get('action')

    #shake
    msg_len = request.POST.get('msg_len')
    d_len = request.POST.get('d_len')
    shake = request.POST.get('shake')
    msg = request.POST.get('msg')

    #usehint
    h = request.POST.get('h')
    r4 = request.POST.get('r4')


    #coeff Three
    b0 = request.POST.get('b0')
    b1 = request.POST.get('b1')
    b2 = request.POST.get('b2')

    #half Byte
    b3 = request.POST.get('b3')

    #power2round
    t = request.POST.get('t')

    #bitunpack
    v = request.POST.get('v')

    #bitunpack
    v = request.POST.get('v')

    #coeff Three
    h0 = request.POST.get('h0')
    h1 = request.POST.get('h1')
    h2 = request.POST.get('h2')
    h0 = request.POST.get('h0')
    h1 = request.POST.get('h1')
    h2 = request.POST.get('h2')
    h0 = request.POST.get('h0')
    h1 = request.POST.get('h1') 

    

    context = {
        'submodules': submodules,
        'selected_submodule': selected_submodule,
        # 'width': width,
        'show_r_input': False,
    }

    if selected_submodule == 'simpleBitPack':
        context['simple_v'] = True

    if selected_submodule == 'powerTwoRound':
        context['power_v'] = True

    if selected_submodule == 'usehint':
        context['usehint_v'] = True

    if selected_submodule == 'coefficientFromHalfBytes':
        context['half_valid'] = True

    if selected_submodule == 'coefficientFromThreeBytes':
        context['three_valid'] = True

    if selected_submodule == 'SHAKE':
        context['valid'] = True

    if selected_submodule == 'usehint':
        context['valid_use'] = True

    if selected_submodule == 'makehint':
        context['show_rz_input'] = True

    if selected_submodule == 'decompose':
        context['show_r_input'] = True

    if selected_submodule == 'bitUnpack':
        context['un_v'] = True

    if selected_submodule == 'hintBitPack':
        context['hint_v'] = True

    if selected_submodule == 'pkencode':
        context['pke_v'] = True

    if selected_submodule == 'w1Encode':
        context['w1e_v'] = True

    if selected_submodule == 'hintBitUnpack':
        context['hintbitu_v'] = True

    

    if selected_submodule == 'bitPack':
        context['p_v'] = True

    if request.method == 'POST' and selected_submodule == 'pkencode' and action=='Simulation':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\pke_files_simulation",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\pke_files_simulation\pkencode_2\pkencode.sim\sim_1\behav\xsim", "encode.vcd")
        context['alert_message_vcd'] = "VCD generated successfully!"
        context['bitstream_file_vcd'] = bitstream_path
    
    if request.method == 'POST' and selected_submodule == 'hintBitUnpack' and action=='Simulation':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\hintbitu_files_simulation",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\hintbitu_files_simulation\HintBitUnpack\HintBitUnpack.sim\sim_1\behav\xsim", "HintBitUnpack_tb.vcd")
        context['alert_message_vcd'] = "Bitstream generated successfully!"
        context['bitstream_file_vcd'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'hintBitUnpack' and action=='Bitstream':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\hintbitu_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\hintbitu_files\HintBitUnpack\HintBitUnpack.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'w1Encode' and action=='Simulation':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\w1e_files_simulation",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\w1e_files_simulation\w1encode\w1encode.sim\sim_1\behav\xsim", "w1encode.vcd")
        context['alert_message_vcd'] = "Bitstream generated successfully!"
        context['bitstream_file_vcd'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'w1Encode' and action=='Bitstream':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\w1e_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\w1e_files\w1encode\w1encode.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'pkencode' and action=='Bitstream':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\pke_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\pke_files\pkencode_2\pkencode.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'simpleBitPack' and action=='Bitstream':
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\simple_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\simple_files\simplebitpack\simplebitpack.runs\impl_1", "Top_SimpleBitPack.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    
    if request.method == 'POST' and selected_submodule == 'bitUnpack' and action=='Bitstream':
        
        code = f"""`timescale 1ns / 1ps



module top (
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);

   logic [767:0] v; // Input array

    // Outputs
    logic [31:0] w [0:255]; // Output array
    logic [31:0] w1 [0:255]; // Output array

    // Instantiate the module
    BitUnpack uut (
        .v(v),
        
        .w(w1)
    );
    
    initial begin
    v = {int(v)};

    end




//       assign w1 = 


    //always_ff @(posedge clk or posedge rst) begin
        //if (~rst) begin
            //led <= 1'b0;
      always_comb begin                 
        //end else if (btn) begin
            if (w1[0] || ~w1[0]) begin
                led = 1'b1;
            end else begin
                led = 1'b0;
            end
        //end
    end
endmodule





"""     
        print(code)
        directory = r"F:\FYP_GUI\unpack_files"
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(r"F:\FYP_GUI\unpack_files\top.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\unpack_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\unpack_files\bitunpack_2\bitunpack_2.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'powerTwoRound' and action=='Bitstream':
        
        code = f"""`timescale 1ns / 1ps

module Top_Power2round (
    input logic clk,
    input logic rst,
    input logic btn,
    output logic led
);
    // Parameters from Dilithium_pkg
    localparam integer d = Dilithium_pkg::d;
    // Input and Output for Power2round
    logic unsigned [22:0] a = {int(t)};
    logic unsigned [9:0] t1;
    logic signed [12:0] t0;

    // Instantiate Power2round
    Power2round u_power2round (
        .t(a),
        .t1(t1),
        .t0(t0)
    );

    // LED output to indicate correct output
    always @(posedge clk) begin
        if (rst) begin
            led <= 1'b0;
        end else if (btn) begin
            // Check the outputs against expected values
            if (t1 || ~t1) begin
                led <= 1'b1;  // Set LED if outputs match expected values
            end else begin
                led <= 1'b0;  // Reset LED if not
            end
        end
    end

endmodule





"""     
        print(code)
        directory = r"F:\FYP_GUI\power_files"
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(r"F:\FYP_GUI\power_files\top.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\power_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\power_files\power2round\power2round.runs\impl_1", "Top_Power2round.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'usehint' and action=='Bitstream':
        
        code = f"""`timescale 1ns / 1ps

module top (
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);


    parameter int Q = 8380417;
    parameter int GAMMA2 = (Q-1)/32;
    parameter int WIDTH = 32;
    parameter int M = (Q-1) / (2 * GAMMA2);

    // Testbench Signals
    logic h;
    logic signed [WIDTH-1:0] r;
    logic signed [$clog2(M)-1:0] r1;
    
    initial begin
    r = {int(r4)};
    h = {int(h)};
    end

    // DUT Instance
    UseHint #(
        .Q(Q),
        .GAMMA2(GAMMA2),
        .WIDTH(WIDTH),
        .M(M)
    ) dut (
        .h(h),
        .r(r),
        .r1(r1)
    );



//       assign w1 = 


    //always_ff @(posedge clk or posedge rst) begin
        //if (~rst) begin
            //led <= 1'b0;
      always_comb begin                 
        //end else if (btn) begin
            if (r1 || ~r1) begin
                led = 1'b1;
            end else begin
                led = 1'b0;
            end
        //end
    end
endmodule




"""     
        print(code)
        directory = r"F:\FYP_GUI\usehint_files"
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(r"F:\FYP_GUI\usehint_files\top.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\usehint_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\usehint_files\useHint\useHint.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'coefficientFromHalfBytes' and action=='Bitstream':
        
        code = f"""`timescale 1ns / 1ps


module top_three_bytes #(parameter int q = 8380417)(
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);
      
    logic [3:0] b;  
    logic [3:0] result;

    // Instantiate CoefFromThreeBytes
    CoefFromHalfByte #(.eta(2))uut (
        .b(b),
        .result(result)
    );

    // Assign fixed values to b0, b1, and b2
       assign b = {int(b3)};


//    // Sequential logic for LED
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 1'b0; // Reset LED
        end else if (btn) begin
            if (result || result==0) begin
                led <= 1'b1;
            end else begin
                led <= 1'b0;
            end
        end
    end
endmodule



"""     
        print(code)
        directory = r"F:\FYP_GUI\half_files"
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(r"F:\FYP_GUI\half_files\top.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\half_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\half_files\coef_half_byte_2\coef_half_byte_2.runs\impl_1", "top_three_bytes.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'coefficientFromThreeBytes' and action=='Bitstream':
        
        code = f"""module top #(parameter int q = 8380417)(
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);
    logic [7:0] b0;
    logic [7:0] b1;  
    logic [7:0] b2;  
    logic [23:0] coef;
    logic valid;

    // Instantiate CoefFromThreeBytes
    CoefFromThreeBytes uut (
        .b0(b0),
        .b1(b1),
        .b2(b2),
        .q(q),
        .coef(coef), // Correct port name
        .valid(valid)
    );

    // Assign fixed values to b0, b1, and b2
    assign b0 = {int(b0)};
    assign b1 = {int(b1)};
    assign b2 = {int(b2)};

    // Sequential logic for LED
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            led <= 1'b0; // Reset LED
        end else if (btn) begin
            if (coef) begin
                led <= 1'b1;
            end else begin
                led <= 1'b0;
            end
        end
    end
endmodule

"""     
        print(code)
        directory = r"F:\FYP_GUI\three_files"
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(r"F:\FYP_GUI\three_files\top.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\three_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\three_files\coefficientthreebytes\coefficientthreebytes.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'decompose' and r2 and action=='Bitstream':
        r1,r0 = decompose(int(r2))
        
        code = f"""`timescale 1ns / 1ps

module top_three_bytes (
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);

    parameter int width=32;
    parameter int r1_width=32;
    parameter int r0_width=32;
    logic [width-1:0] r;  
    logic [r1_width-1:0] r1_check = {r1};
    logic [r0_width-1:0] r0_check = {r0};
    logic [r1_width-1:0] r1 ;
    logic [r0_width-1:0] r0 ;

    Decompose uut (
        .r(r),
        .r1(r1),
        .r0(r0)
    );

    assign r = {r2};

    always_comb begin                 
        if (r0 == r0_check && r1 == r1_check) begin
            led = 1'b1;
        end else begin
            led = 1'b0;
        end
    end
endmodule
"""     
        print(code)
        directory = r"F:\FYP_GUI\Decompose_files"
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(r"F:\FYP_GUI\Decompose_files\top_decompose_userinput.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\Decompose_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\Decompose_files\decompose_2\decompose_2.runs\impl_1", "top_three_bytes.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path
    
    # print(msg)
    if request.method == 'POST' and selected_submodule == 'SHAKE' and action=='Bitstream':
        print(shake)
        if (shake == "256"):
            value = 512
        else:
            value = 256

        
        code = f"""`timescale 1ns / 1ps


module top(    
    input logic clk,
    input logic rst,
    output logic led
   );
   
   logic [{int(msg_len)+3}:0] datain;
   logic [{int(d_len)-1}:0] digest;
   logic [{int(d_len)-1}:0] check;
   assign datain = {int(msg_len)+3}'b1111{bin(int(msg))[2:]};

//   assign datain = 120'h726E676A6A656A6A726A676A657268 ;
//   assign check = 256'hdfde6395b8647257f66c3ccffd567170e6c6b76811cb0293679d459d3d5e976e ;

   
   sponge #(
    .msg_len({int(msg_len)+4}),
    .d_len({int(d_len)}),
    .capacity({value}),
    .r(1600 - {value})
) shake(
       .clk(clk),
       .reset(rst),
       .start(1'b1),
       .message(datain),
       .z(digest)
   );
   
   always_ff @(posedge clk)begin
     if (digest) begin
            led <= 1'b1;  // Assign 1 to 'led'
        end
        else begin
            led <= 1'b0;  // Assign 0 to 'led'
        end
   end
//   assign led = digest[0:5];
endmodule

"""     
        
        print(code)
        directory = r"F:\FYP_GUI\shake_files_simulation"
        if not os.path.exists(directory):
            os.makedirs(directory)  
        with open(r"F:\FYP_GUI\shake_files_simulation\top.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source simulation.tcl",cwd=r"F:\FYP_GUI\shake_files_simulation",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\Shake_files_simulation\shake\shake.runs\impl_2", "top.bit")
        context['alert_message'] = "Simulation completed, VCD generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'SHAKE' and action=='Simulation':
        print(shake)
        if (shake == "256"):
            value = 512
        else:
            value = 256

        
        code = f"""module tb_sponge;

// Parameters
parameter msg_len = {int(msg_len)+4};
parameter d_len = {int(d_len)};
parameter capacity = {value};
parameter r = 1600 - capacity;

// Testbench Signals
logic clk;
logic reset;
logic [msg_len-1:0] message;
logic start;
logic [d_len-1:0] z;

// Clock generation
always #2 clk = ~clk;

// Instantiate the DUT (Device Under Test)
sponge #(.msg_len(msg_len), .d_len(d_len), .capacity(capacity), .r(r)) dut (
    .clk(clk),
    .reset(reset),
    .message(message),
    .start(start),
    .z(z)
);

// Test procedure
initial begin
    // Initialize signals
    clk = 0;
    reset = 1; // Assert reset
    message = {int(msg_len)+4}'b1111{bin(int(msg))[2:]}; // Initialize message to zero
    start = 0;
    #5;

    reset = 0; // Deassert reset
    
    clk=0;
    // Start the sponge operation with message = 111110011
    start = 1;
    //message = 4'b1111;
    //message = 9'b111110011;
  //message = 1604'b11111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011101000111010001110100011;
  message = {int(msg_len)+4}'b1111{bin(int(msg))[2:]};
   $dumpfile("SHAKE.vcd");
        $dumpvars(0, tb_sponge);
    #1200;
    
//    repeat (1000) @(posedge clk);

    $stop;
end



endmodule
"""     
        
        print(code)
        directory = r"F:\FYP_GUI\shake_files\shake"

        # if os.path.exists(directory):
        # # Grant write permissions to the directory and all its contents
        #     for root, dirs, files in os.walk(directory):
        #         for dir in dirs:
        #             os.chmod(os.path.join(root, dir), stat.S_IWUSR | stat.S_IREAD)
        #         for file in files:
        #             os.chmod(os.path.join(root, file), stat.S_IWUSR | stat.S_IREAD)

        #     shutil.rmtree(directory, ignore_errors=False)
  
        with open(r"F:\FYP_GUI\shake_files\tb_sponge.sv", "w") as f:
            f.write(code)
        subprocess.run(r"vivado -mode tcl -source simulation.tcl",cwd=r"F:\FYP_GUI\shake_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\shake_files\shake\shake.sim\sim_1\behav\xsim", "SHAKE.vcd")
        context['alert_message_vcd'] = "Simulation completed, VCD generated successfully!"
        context['bitstream_file_vcd'] = bitstream_path


    if request.method == 'POST' and selected_submodule == 'makehint' and r3 and z and action=='Bitstream':
        out = make_hint(int(z),int(r3))
        
        code = f"""`timescale 1ns / 1ps

module top (
    input logic btn,
    input logic clk,
    input logic rst,
    output logic led
);


    localparam int q = 8380417;
    localparam int WIDTH = 32;

    // Testbench signals
    //logic clk, rst;
    logic [$clog2(q):0] z, r;
    logic Boolean;
    
    initial begin
     z = {z}; // Example value for z
           r = {r3};
    end

    // Instantiate the DUT (Device Under Test)
    makeHint #(
        .q(q),
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .z(z),
        .r(r),
        .Boolean(Boolean)
    );


//       assign w1 = 


    //always_ff @(posedge clk or posedge rst) begin
        //if (~rst) begin
            //led <= 1'b0;
      always_comb begin                 
        //end else if (btn) begin
            if (Boolean == {out}) begin
                led = 1'b1;
            end else begin
                led = 1'b0;
            end
        //end
    end
endmodule

"""     
        print(code)
        directory = r"F:\FYP_GUI\makeHint_files"
        if not os.path.exists(directory):
            os.makedirs(directory)  
        with open(r"F:\FYP_GUI\makeHint_files\top_makehint_userinput.sv", "w") as f:
            f.write(code)
        process = subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\makeHint_files",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\makeHint_files\makeHint\makeHint.runs\impl_1", "top.bit")
        context['alert_message'] = "Bitstream generated successfully!"
        context['bitstream_file'] = bitstream_path

    if request.method == 'POST' and selected_submodule == 'makehint' and r3 and z and action=='Simulation':
        out = make_hint(int(z),int(r3))
        print(out)
        
        code = f"""module makeHint_tb;

    // Parameters
    localparam int q = 8380417;
    localparam int WIDTH = 32;

    // Testbench signals
    logic clk, rst;
    logic [$clog2(q):0] z, r;
    logic Boolean;

    // Instantiate the DUT (Device Under Test)
    makeHint #(
        .q(q),
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .z(z),
        .r(r),
        .Boolean(Boolean)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench process
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        z = 0;
        r = 0;

        // Wait for reset
        #10;
        rst = 0;

        // Test case 1
        z = {z}; // Example value for z
        r = {r3}; // Example value for r
        $dumpfile("makeHint_tb.vcd");
        $dumpvars(0, makeHint_tb);
        #1000;
        
        $stop;
    end

endmodule


"""     
        print(code)
        directory = r"F:\FYP_GUI\makeHint_files_simulation"
        if not os.path.exists(directory):
            os.makedirs(directory)  
        with open(r"F:\FYP_GUI\makeHint_files_simulation\test_makehint_userinput.sv", "w") as f:
            f.write(code)
        process = subprocess.run(r"vivado -mode tcl -source run_synthesis.tcl",cwd=r"F:\FYP_GUI\makeHint_files_simulation",shell=True,check=True,text=True,capture_output=True)
        bitstream_path = os.path.join(r"F:\FYP_GUI\makeHint_files_simulation\makeHint\makeHint.sim\sim_1\behav\xsim", "makeHint_tb.vcd")
        context['alert_message_vcd'] = "Simulation completed, VCD generated successfully!"
        context['bitstream_file_vcd'] = bitstream_path



    return render(request, 'home.html', context)


from django.http import FileResponse,HttpResponse

import os
from django.http import FileResponse, HttpResponse

def download_bitstream(request):
    bitstream_path = request.GET.get('file')
    target_filename = 'top.bit'

    # Check if the target file already exists
    if os.path.exists(target_filename):
        os.remove(target_filename)  # Delete the old file

    # Check if the requested bitstream file exists
    if bitstream_path and os.path.exists(bitstream_path):
        # Copy the new bitstream file to 'top.bit'
        with open(bitstream_path, 'rb') as src, open(target_filename, 'wb') as dst:
            dst.write(src.read())
        
        # Serve the new 'top.bit' file as a response
        return FileResponse(open(target_filename, 'rb'), as_attachment=True, filename=target_filename)
    else:
        return HttpResponse("File not found.", status=404)

    
def download_vcd(request):
    bitstream_path = request.GET.get('file')
    if bitstream_path and os.path.exists(bitstream_path):
        return FileResponse(open(bitstream_path, 'rb'), as_attachment=True, filename='simulation.vcd')
    else:
        return HttpResponse("File not found.", status=404)