module lota(
    input logic clk,
    input logic reset,
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
    if (~reset) begin
       /* verilator lint_off BLKSEQ */
        for (int i = 0; i < 5; i++) begin// $display("i : %0d",i);
            for (int j = 0; j < 5; j++) begin //$display("j : %0d",j);
               for (int k = 0; k < 64; k++) begin // $display("k : %0d",k);
              Ab[i][j][k] = A[i][j][k];
              $display("Ab[%0d][%0d][%0d] = %0d", i, j, k, Ab[i][j][k]);
            end
        end
        end
    
        for (int m = 0; m < 6 ; m++)begin
           
            RC[(2**m) -1] = rc(m+(7*round));
            $display("%0d ,%0d", RC,(2**m)-1);

            
        end
        for (int n=0 ; n<64 ;n++) begin
            Ab[0][0][n] <= Ab[0][0][n] ^ RC[n];
        end
        
            
    end

end
function logic rc( input [31:0] t);

     logic [7:0] R=10000000;
                // 0// 01000000
                // 1   00100000
                // 2   00010000
                // 3   00001000
                // 4   00000100
                // 5   00000010
                // 6   00000001    
     logic[0:0] bitt;
    // logic [7:0]
     
    
        for(int k=0 ; k < (t%255) ; k++)begin
            
            
            R[0] = R[0] ^ R[8];   
            $display("%0d = %0d ^ %0d",R[0],R[0],R[8]);
            
            R[4] = R[4] ^ R[8];
            $display(" %0d = %0d ^ %0d;",R[4],R[4],R[8]);
            
            R[5] = R[5] ^ R[8];
            $display(" %0d = %0d ^ %0d;",R[5],R[5],R[8]);
            
            R[6] = R[6] ^ R[8];
            $display(" %0d= %0d^ %0d;",R[6],R[6],R[8]);
            R = R >> 1; 
           
            
          //  R={1'b0,R[8:1]} << 1;
         //  $display("R=%0d",R);
        end 
         bitt=R[0];
        $display("bitt=%0d",bitt);
       // return bitt
        
    
     
    return bitt;
    endfunction
endmodule
