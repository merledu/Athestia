module state_array (
    input  logic clk,
    input  logic reset,
   
    output logic [0:0] Abc [0:5][0:5][0:63]// Adjusted array dimensions to match loop bounds
    
);

logic [1599:0] bitstring;
logic[63:0] a;
 initial begin
bitstring[0]=1;
// bitstring[1]=1;
// bitstring[2]=1;
// bitstring[3]=1;
// bitstring[1088]=1;

// bitstring[893]=1;
// bitstring[894]=1;
// bitstring[895]=1;
// bitstring[1343]=1;

 end
 
    always_ff @(posedge clk or negedge reset) begin
    if (~reset) begin
        for (int i = 0; i < 5; i++) begin  // $display("i : %0d",i);
            for (int j = 0; j < 5; j++) begin //$display("j : %0d",j);
               for (int k = 0; k < 64; k++) begin // $display("k : %0d",k);
                   Abc[i][j][k] = bitstring[64* (4 * j + i) + k];
                   $display("Abc[%0d][%0d][%0d] = %0d", i, j, k, Abc[i][j][k]);end
            end
        end
        
    end
     
        $display("Abc : %0d",Abc);
        $display("bitstring : %0d",bitstring);

        
    
  
    
   
end
 

    
endmodule
