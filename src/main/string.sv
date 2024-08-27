module string (
    input  logic clk,
    input  logic reset,
    output logic [1599:0] bitstring
    
);
/* verilator lint_off BLKSEQ */
logic[63:0] a;
logic [0:0] Abc [0:5][0:5][0:63];
initial begin
    Abc[0][0][0]=1;

 end
 
    always_ff @(posedge clk or negedge reset) begin
    if (~reset) begin
        for (int i = 0; i < 5; i++) begin 
            for (int j = 0; j < 5; j++) begin 
                for (int k = 0; k < 64; k++) begin 
                    a=64* ((4 * j) + i) + k;
                    bitstring[a]=A[i][j][k];
                    $display("Abc[%0d][%0d][%0d] = %0d,%0d", i, j, k, Abc[i][j][k],a);end
            end
        end
end
$display("bitstring : %0d",bitstring);
$display("Abc : %0d",Abc);
    
   
end
endmodule
