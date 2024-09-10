module X(
    input logic clk,
    input logic reset,
    input logic [63:0] A [4:0][4:0],
    output logic [63:0] Ab [4:0][4:0]
);

// +
always_ff @(posedge clk or negedge reset) begin
    if (~reset) begin
        for (int i = 0; i < 5; i++) begin  
            for (int j = 0; j < 5; j++) begin 
               for (int k = 0; k < 64; k++) begin 
                Ab[i][j][k]= A[i][j][k] ^ ((A[(i+1)%5][j][k] ^ 1) * A[(i+2)%5][j][k]);
                                //1             //0        
                 
               end
               end
        end
      //  $display("Ab[0][0][0] : %0d",Ab[0][0][0]);
        $display("Ab[0][0][0] : %0d",Ab[0][0][0]);
    end
end
endmodule
