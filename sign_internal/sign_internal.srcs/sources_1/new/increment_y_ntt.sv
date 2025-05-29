`timescale 1ns / 1ps
import Dilithium_pkg::*;

module increment_y_ntt(
    input logic signed [31:0] y_in [0:Dilithium_pkg::l-1][0:255],
    output logic signed [31:0] y_out [0:Dilithium_pkg::l-1][0:255],
    input logic clk,rst,
    output logic done    
    );
    
    logic rst_ntt,nttdone,ntt_disabler,ntt_done_done;
    logic signed [31:0] w [0:255];
    logic signed [31:0] w_hat [0:255];
    logic [3:0] count,rst_count;
    logic trigger_rst_ntt;
    logic nttdone_d;
    
    NTT #(.width(32)) NTT (
            .clk(clk),
            .rst(rst_ntt),
            .w(w),
            .w_hat(w_hat),
            .done(nttdone),
            .disabler(ntt_disabler)
        );
        
   
    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count <= 0;
            done <= 0;
//            rst_ntt <= 1;  // Assert NTT reset
            ntt_disabler <= 0;
            rst_ntt <= 1;
            rst_count<= 0;
//            trigger_rst_ntt <= 1;
            
//            rst_ntt <= 0;
//            rst_ntt <= 1;
        end else begin
            nttdone_d <= nttdone; // track previous value
            if (rst_ntt && rst_count == 1) begin
                            rst_ntt <= 0;
                            rst_count <= 'x;
                        end
                        rst_count <= rst_count + 1;
        
                    // Load current input
                    w <= y_in[count];
        
                    // Detect rising edge of nttdone
                    if (nttdone && !nttdone_d) begin
                        y_out[count] <= w_hat;
                        count <= count + 1;
                        rst_ntt <= 1;
                    end 
        
                    if (count == 8) begin
                        done <= 1;
//                        rst_ntt <= 'x;
                    end
                    
//                    if (done) begin
//                        rst_ntt <= 'x;
//                    end
        end
                
    end
    

endmodule











