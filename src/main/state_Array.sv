
`include "src/main/config_module.sv"

module state_array (
    input  logic clk,
    input  logic reset,
    input logic [`len_bitstring-1:0] bitstring,
    output logic [`w-1:0] Abc [4:0][4:0]// Adjusted array dimensions to match loop bounds
    
);


logic[63:0] a;
 always_ff @(posedge clk or negedge reset) begin
    if (~reset) begin
       
        for (int i = 0; i < 5; i++) begin// $display("i : %0d",i);
            for (int j = 0; j < 5; j++) begin //$display("j : %0d",j);
               for (int k = 0; k < `w; k++) begin // $display("k : %0d",k);
               a = 64 * ((5 * j) + i) + k;
               Abc[i][j][k] = bitstring[`w * ((5 * j) + i) + k];
               $display("Abc[%0d][%0d][%0d] = %0d,%0d", i, j, k, Abc[i][j][k],a);
            end
        end
          $display("%0d",`len_bitstring);
         $display("%0d",`w);
        
        
        
    end
      
end
end

endmodule
