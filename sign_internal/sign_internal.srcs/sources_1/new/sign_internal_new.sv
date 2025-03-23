`timescale 1ns / 1ps
import Dilithium_pkg::*;
function automatic logic [22:0] extend_bits2(
            input logic [13:0] value,
            input int target_width,
            input bit is_signed
        );
            logic [22:0] extended_value;
            int i;
    
            extended_value[13:0] = value; 
    
            if (is_signed) begin
                for (i = 14; i < target_width; i++)  
                    extended_value[i] = value[13];   
            end else begin
                for (i = 14; i < target_width; i++) 
                    extended_value[i] = 1'b0;       
            end
            
            return extended_value;
        endfunction

module sign_internal_new(
    input logic [8*(32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta)+1)) 
                                      + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1 : 0] sk,
    output logic [255:0] rho,
    output logic [255:0] K,
    output logic [511:0] tr,
    input clk,rst      
    );    
    logic skdone,initiator,nttdone,rst_ntt,ntt_disabler,s1_ntt_done,s2_ntt_done;
    logic [3:0] counts1,count_t0;
    logic [4:0] count_rst;
    logic signed [22:0] w [0:255];
    logic signed [31:0] w_hat [0:255];
    logic signed [3:0] s1 [0:Dilithium_pkg::l-1][0:255];
    logic signed [31:0] s1_ntt [0:Dilithium_pkg::l-1][0:255];
    logic signed [31:0] s2_ntt [0:Dilithium_pkg::k-1][0:255];
    logic signed [31:0] t0_ntt [0:Dilithium_pkg::k-1][0:255];
    logic signed [3:0] s2 [0:Dilithium_pkg::k-1][0:255];
    logic signed [13:0] t0 [0:Dilithium_pkg::k-1][0:255];

    
    skDecode skDecode (
            .sk(sk),
            .rho(rho),
            .K(K),
            .tr(tr),
            .clk(clk),
            .rst(rst),
            .s1(s1),
            .s2(s2),
            .t0(t0),
            .done(skdone)
        );
        
          NTT #(.width(23)) NTT (
                        .clk(clk),
                        .rst(rst_ntt),
                        .w(w),
                        .w_hat(w_hat),
                        .done(nttdone),
                        .disabler(ntt_disabler)
                    );
        
always_ff @(posedge clk or negedge rst) begin
                        if (rst) begin
                            count_rst <= 0;
                            initiator <= 0;
                            counts1   <= 0;   
                            s1_ntt_done <= 0;
                            s2_ntt_done <= 0;    
                            count_t0 <= 0;     
                        end else begin
                            rst_ntt <= initiator;
                            for (int i = 0; i < 256; i++) begin
                                w[i] <= extend_bits2(t0[0][i], 23, 1);
                            end
                            if(skdone)begin
                            count_rst <= count_rst+1;
                            initiator<=1;
                            end

                            
                            if (count_rst == 2) begin
                                initiator <= 0;
                                count_rst <= 'x;
                            end else if (count_rst === 'x) begin
                                initiator <= 0;   
                            end
                        end
end
endmodule