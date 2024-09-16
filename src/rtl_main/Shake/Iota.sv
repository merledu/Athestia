module Iota(
    input logic clk,
    input logic reset,
    input logic start,
    output logic valid,
    input logic [31:0]round,
    input logic [63:0]A[4:0][4:0], 
    output logic [63:0]Ab[4:0][4:0]   
);
// initial begin
//     A[0][0][0]=1;
// end

logic [63:0]RC;
//logic r[31:0];
//logic [0:0] b;
always_ff @(posedge clk or negedge reset) begin
    if (~reset && start == 1) begin
      
        for (int i = 0; i < 5; i++) begin// $display("i : %0d",i);
            for (int j = 0; j < 5; j++) begin //$display("j : %0d",j);
               for (int k = 0; k < 64; k++) begin // $display("k : %0d",k);
              Ab[i][j][k] = A[i][j][k];
             // $display("Ab[%0d][%0d][%0d] = %0d", i, j, k, Ab[i][j][k]);
            end
        end
        end
    
        for (int m = 0; m < 6; m++)begin
           
            RC[(2**m) -1] <= rc(m+(7*round));
           
            

            
        end
        for (int n=0 ; n<64 ;n++) begin
            Ab[0][0][63-n] <= Ab[0][0][63-n] ^ RC[n];
        end
         $display("%63b", RC);
         valid=1;  
    end
    else  begin
      valid=0;
      
    end


end
function logic rc( input [31:0] t);

    logic [8:0] R=128;
    logic[0:0] bitt;
  //  logic[8:0]a;
    // logic [7:0]
    // $display ("%0d",R[0]);
     
    
        for(int k=0 ; k < (t%255) ; k++)begin
            
            
            R[8] = R[0] ^ R[8];   
          //  $display("%0d = %0d ^ %0d",R[0],R[0],R[8]);
            
            R[4] = R[4] ^ R[8];
          //  $display(" %0d = %0d ^ %0d;",R[4],R[4],R[8]);
            
            R[3] = R[3] ^ R[8];
           // $display(" %0d = %0d ^ %0d;",R[5],R[5],R[8]);
            
            R[2] = R[2] ^ R[8];
//$display(" %0d= %0d^ %0d;",R[6],R[6],R[8]);
            R = R >> 1;
          //  R = {k+1'b0,R}; 
           
            
          //  R={1'b0,R[8:1]} << 1;
          //  $display("R=%8b",R);
            
           
        end 
      //  R=8'b;  
        bitt=R[7];
        
        $display("bitt=%0d",bitt);
       // return bitt
        
    
     
    return bitt;
    endfunction
endmodule
