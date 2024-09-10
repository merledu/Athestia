module rc(
    input logic clk,
    input logic  reset,
    input logic [63:0] t,
    output logic [0:0] bitt
);

always_ff @(posedge clk or negedge reset) begin
    logic [8:0] R=10000000;
    if (~reset)begin
        for(int k=0 ; k < (t%255) ; k++)begin
            R={1'b0,R};
           // $display("R=%0d",R);
            R[0] = R[0] ^ R[8];   
           // $display("%0d = %0d ^ %0d",R[0],R[0],R[8]);
            
            R[4] = R[4] ^ R[8];
            //$display(" %0d = %0d^ %0d;",R[4],R[4],R[8]);
            
            R[5] = R[5] ^ R[8];
            //$display(" %0d= %0d^ %0d;",R[5],R[5],R[8]);
            
            R[6] = R[6] ^ R[8];
            // $display(" %0d= %0d^ %0d;",R[6],R[6],R[8]);
            
            R=R[8:1];
           $display("R=%0d",R);
            end
            end 
    assign bitt=R[0];
    $display("bitt=%0d",bitt);
    end
    

endmodule
