`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 01:53:00 AM
// Design Name: 
// Module Name: Sample_in_ball
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sample_in_ball#(parameter lmbda=256 , parameter t=60)( 
input logic  clk,
input logic  rst,
output logic  done,
input logic [(lmbda/4)-1:0] in,
input logic start,
output logic signed [0:1] out [255:0]= '{default: 0}

    );
//logic start; 
logic [4999:0]hash ;  
logic h_don;
logic[31:0] counts;
logic  signed [63:0] signs;
logic  signed [31:0] signs1;
int i;
//int k;
logic[7:0] j;
logic h_done;
logic [7:0] temp_j;
int non_zero_count;
int f ;
int enable;
 int max_iter = 16; // Limit iterations
int iter = 0;
int temp_f ; 
    
sponge #(
.msg_len((lmbda/4)+4),
.d_len(5000),
.capacity(512),
.r(1600-512)
)shake( 
.clk(clk),
.reset(rst),
.message({4'b1111,in}),
.start(1'b1),
.z(hash),
.done(h_don)) ;
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        h_done <= 0;
    end else begin
        h_done <= h_don;  
    end
end


    always_ff @(posedge clk) begin

    
    if (rst) begin
    i <= 0;
    counts<=196;
     non_zero_count <=0; 
     f <=0;
     max_iter <= 16; 
     iter <= 0;
    signs <=0;
     signs1 <=0;
  
    end
     else if (!rst && h_done && (i < 60) )  begin //255-t
      if (i==0) begin
       
       
//       signs <={hash[7:0],hash[15:8],hash[23:16],hash[31:24]} ;
//      signs <= {hash[31:24], hash[23:16], hash[15:8], hash[7:0]}; // Big-endian
        signs <= hash[63:0];
       end
//       signs <= 'h6057c2e1;
//       signs1 <= signs; 
       i <= i+1;
       
       enable <= 1;
            j <= hash[64 + (f * 8) +: 8];
               
              if (j<=counts )begin
               counts <= counts+1;
               
                
                 end
            else begin
              counts <= counts;
              i<= i;
            end
             f=f+1;
      
      if (j<=counts )begin
      out[counts] <= out[j];
      $display("%d  %d",counts,j);
                                      
      out[j] <= 1 - (2 * (signs & 1)); 
        signs <= signs >> 1 ;
        end
//  if (out[j] ==0 && j <= counts) begin
//       if (hash[511-i])begin
//        out[j] <= -1;
          
//          out[counts] <= out[j];
           
//           out[j] <= 1 - (2 * (signs & 1)); 
//             signs = signs >> 1 ;
           
//           signs <= signs/2 ;

//           if (counts==198)begin
//            signs = signs >> 1 ;
//           end
                
                 
       
//     end
 if(counts == 255)begin
 done <= 1;
    end   
     end
    
     end 
     
  endmodule
