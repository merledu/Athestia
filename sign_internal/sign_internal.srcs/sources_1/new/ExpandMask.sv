`timescale 1ns / 1ps
import Dilithium_pkg::*;



module Expand_mask #(
parameter int gamma1=524288,
parameter int cols_l=Dilithium_pkg.l
)(
input clk,
input rst,
 input logic [511:0] rho_double_prime,
 input logic [31:0]  k,
 output logic signed [31:0] outputt [0:l-1] [0:255],
 output logic done 
);
logic h_done;
logic h_done2;
logic bp_strt;
logic [5119:0] hash;

//logic [689:0] hash;
logic [527:0] rho;
//logic [(($clog2((gamma1-1) + gamma1)+1) * 256) - 1:0] in;
logic [31:0] out[0:255];
int  count;
int count2;

logic [15:0] twobyte;
logic shk_strt;
logic shk_reset;
logic [(($clog2((gamma1-1) + gamma1)+3) * 256) - 1:0] in;
logic [5119:0]sn;
logic[5119:0] sout;

//logic h_don;
expandmask_shake #(
.msg_len(512+16+4),
.d_len(5120),
//.d_len(690),
.capacity(512),
.r(1088)
)shake( 
.clk(clk),
.reset(shk_reset),
.message({4'b1111,rho}),
.start(shk_strt),
.z(hash),
.done(h_done)) ;


 BitUnpack2 #(
 .a(524287),
 .b(524288),
 .b_len(($clog2((gamma1-1) + (gamma1))+3)),
 .w_len(32)
) bp (
.v(in),
.start(bp_strt),
.w(out)
);
 SwapNibbles #(
 .WIDTH(5120))SN (
 .in(sn),
 .out(sout));

always_ff @(posedge clk  ) begin
 if (rst) begin
    count <=0;
    in <=0;
    shk_strt <=0;
     shk_reset <=1; 
     bp_strt <= 0 ;
     count2 <= 0;
//     hash <=0;  
 end
 else if (!rst && count <= 8) begin
       count2 <=count2+1;
 
       if ( shk_strt==0)begin
       twobyte<= count+k;
      //  shk_reset <=0;
       shk_reset <= 0;  // Release reset before starting SHAKE
       shk_strt <= 1;
         rho <= {16'(count + k), rho_double_prime}; // Assign rho first!
                   // Now start SHAKE
       
           end 
           h_done2 <=  h_done==1;     
        if (h_done2==1 && count <= l+1 && shk_strt) begin
                         sn <= hash;
                          bp_strt <= 1;
                         in <= sout;
                         
                                                
                         shk_reset <= 1;
                         shk_strt <= 0;
                        
                        
                         
                         for (int i = 0; i < 256; i++) begin
                                     outputt[count-2][i] <= out[i]; 
                                 end
                                
//                            if (shk_strt== 0) begin    
                           count <= count + 1;
//                           end
 if (count ==l+1) begin
 done <= 1;
 end
 else begin
 done <= 0;
 end
                           end
                                 
                        
                                   
      
     
//       end
       end 
       
//       always_ff @(posedge clk) begin 
    //       if (bp_strt ==1) begin
       
  
////       shk_strt <=0;
       
//        for (int i = 0; i < 256; i++) begin
//            outputt[count-1][i] <= out[i]; 
//        end
        
         
//          end
  
 
//   end
//     always_ff @(posedge clk) begin
//       if (bp_strt) begin
//           for (int i = 0; i < 256; i++) begin
//               outputt[count * 256 + i] <= out[i]; 
//           end
//           bp_strt <= 0;   // Reset bp_strt after one cycle
//           count <= count + 1;  // Move to the next iteration
//       end
//   end
      
      


end

endmodule
