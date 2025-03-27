
import Dilithium_pkg::*;

module RejBoundedPoly (
    input clk,rst,start,
    input logic [527:0] rho,
    //input logic [4096:0] shakeOut,
    output logic signed [($clog2(eta)+2):0] A [0:255],
    output logic done
);

logic [31:0] count,count2;
logic [7:0] z0;
logic [3:0] b0,result0,b1,result1;  
logic [4095:0] shakeOut;
logic shakeDone;

   sponge #(
    .msg_len(532),
    .d_len(4096),
    .capacity(512)
) shake256(
       .clk(clk),
       .reset(rst),
       .start(1'b1),
       .message({4'b1111,rho}),
       .z(shakeOut),
       .done(shakeDone)
   );


CoefFromHalfByte #(.eta(eta))half0 (
        .b(b0),
        .result(result0)
);

CoefFromHalfByte #(.eta(eta))half1 (
        .b(b1),
        .result(result1)
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        z0 <= 'x;
    end else if (done && shakeDone) begin
        count <= 'x;
        
    end else if (shakeDone) begin
        z0 <= shakeOut[count+:8];
        count <= count + 8; 
        
    end
end

always_comb begin
    if (rst) begin
        b0 = 'x;
    b1='x;
    end else begin
    b0=z0%16;
    b1=z0/16;
    end
end

always_ff @(posedge rst or posedge clk) begin
    if (rst) begin
    count2 <= 0;
    done <= 0;

    end else begin
    
    if (result1 >= 0 && result0 >= 0 && shakeDone && start) begin
        A[count2] <= result0;
        A[count2+1] <= result1;
        count2 <= count2 + 2;
    end else if (result0 >= 0 && (result1 === 'x) && shakeDone && start) begin
        A[count2] <= result0;
        count2 <= count2 + 1;
    end else if (result1 >= 0 && (result0 === 'x) && shakeDone && start) begin
            A[count2] <= result1;
            count2 <= count2 + 1;
        end
    if (count2 >= 256 && shakeDone && start) begin
                    count2 <= 'x;
                    done <= 1;
                end
                if (count2 === 'x && shakeDone && start) begin
                    done <= 0;
                end
    end
end
endmodule
