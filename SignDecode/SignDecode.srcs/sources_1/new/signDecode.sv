module SigDecode #(
    parameter int gamma1 = 524288,
    parameter int cols_l = 7,
    parameter int Lambda = 256,  // Example, adjust as needed
    parameter int omega = 75,
    parameter int rows_k = 8
)(
    input logic clk,
    input logic rst,
    input logic [37015:0] sigma,  // Adjusted width, assuming large input
    output logic [Lambda/4 - 1:0] c_tilde,  // Extracted challenge
    output logic [31:0] z [0:cols_l-1][0:255],  // Unpacked signature values
    output logic [255:0] h [rows_k-1:0],  // Unpacked hint
    output logic valid
);

    localparam int bl =640;  // Compute block length for z elements
    localparam int cl = Lambda / 4;
    
    logic [640:0] xi;
    logic [31:0]offset;
    logic [31:0] out[0:255];
    int  count;
    logic hbp_rst;
    
    
    logic [bl-1:0] z_packed [0:cols_l-1];
    logic [7:0] y [rows_k+omega-1:0];
     logic [7:0] y_2 [rows_k+omega-1:0];
logic Valid;
    logic unpack_done, hint_done;
    logic bp_start, hint_unpack_start;
     BitUnpack #(
                  .a(gamma1 - 1),
                  .b(gamma1),
                  .b_len($clog2(gamma1) + 1),
                  .w_len(32)
              ) unpack_z (
                  .v({xi,4480'b0}),
                  .start(bp_start),
                  .w(out)
              );
    HintBitUnpack #(
    .k(8),
    .omega(75)
    ) Hbp (
    .clk(clk),
    .rst( hbp_rst),
    .y(y),
    .h(h),
    .valid(Valid)
    );
              


    assign c_tilde = sigma[cl-1:0];  // Extract first `cl` bytes
//    assign bit_unpack_start = 1;  // Start unpacking process
   

    // Extract `z` blocks from sigma
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            unpack_done <= 0;
             offset <= 64;
             count <= 0;
//             hbp_rst <= 1;
            end
      else if (!rst && count <= 8) begin
            
            xi <= sigma[offset +: bl];  // Extracts 'bl' elements starting from 'offset'
            bp_start <= 1;
            for (int i = 0; i < 256; i++) begin
                                     z[count-1][i] <= out[i]; 
                                 end
            offset <= offset + bl;
            
            count <= count+1;
           
              
        end
    end
      always_ff @(posedge clk or posedge rst) begin
       if (rst)begin
      
                 
                 hbp_rst <= 1;
                 end
                 else begin
                for (int i = 0; i < 83; i++) begin
                        
                        y_2[i] <= sigma[36352 + (i * 8) +: 8]; // Slicing 8 bits from sigma
                    end
                  
                 
                   
                   
                  
                  if (count ==4)begin
                   y <= y_2;
                   hbp_rst <= 0;
                  end
      
      end
      end
    

    // Instantiate `BitUnpack` for each `z` column
   
           
       
   

    // Extract `y`
  

    // Instantiate `HintBitUnpack`
   

    // Set valid signal when both `z` and `h` are unpacked

endmodule
