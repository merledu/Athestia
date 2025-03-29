`timescale 1ns / 1ps

module HintBitUnpack_tb();

    // Parameters
    parameter int k = 8;  // Number of elements
    parameter int omega = 75;   // Bit width parameter

    // Testbench Signals
    logic clk;
    logic rst;
    logic [7:0] y [k+omega-1:0];
    logic [255:0] h [k-1:0];
    logic valid;

    // Instantiate the DUT (Device Under Test)
    HintBitUnpack #(
        .k(k),
        .omega(omega)
    ) dut (
        .clk(clk),
        .rst(rst),
        .y(y),
        .h(h),
        .valid(valid)
    );
    initial begin
    clk=1;
    rst=1;
    //test 1
    y = '{8'h4b,8'h2b,8'h0b,8'h5,8'h4,8'h2,8'h2,8'h2,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
   
    #10;
    
    rst=0;
        
        y = '{8'h4b,8'h2b,8'h0b,8'h5,8'h4,8'h3,8'h2,8'h1,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
        
        #140;
//         rst=1;
           //test # 2
//           y = '{8'h4b,8'h2b,8'h0b,8'h5,8'h4,8'h2,8'h2,8'h2,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
//       $display(y);
//       $display(h);
//           #10;
            
           
//           rst=0;
               
//               y = '{8'h4b,8'h2b,8'h0b,8'h5,8'h4,8'h3,8'h2,8'h1,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
//           $display(y);
//           $display(h);
//               #140;
// rst=1;
//            //test # 3
//            y = '{8'h4b,8'h2b,8'h0b,8'h5,8'h4,8'h2,8'h2,8'h2,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
//            #10;
//    rst=0;
                
//        y = '{8'h40,8'h2b,8'h0b,8'h5,8'h4,8'h3,8'h2,8'h1,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'h0a,8'h02,8'hfa,8'hf2,8'hea,8'he2,8'hda,8'hd2,8'hca,8'hc2,8'hba,8'hb2,8'haa,8'ha2,8'h9a,8'h92,8'h8a,8'h82,8'h7a,8'h72,8'h6a,8'h62,8'h5a,8'h52,8'h4a,8'h42,8'h3a,8'h32,8'h2a,8'h22,8'h1a,8'h12,8'ha,8'h2,8'ha,8'h9,8'h8,8'h7,8'h1,8'h0,8'h2,8'h2,8'h2,8'h2,8'h5} ;
//        #140;
     $finish;
    end

    always begin
        #0.1 clk = ~clk;
    end
    
    initial begin
        $dumpfile("HintBitUnpack_tb.vcd");
        $dumpvars(0,HintBitUnpack_tb);
    end
           

endmodule