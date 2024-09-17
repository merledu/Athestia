module pad10_1 #(
    parameter x = 8
) (
    input logic [32:0] m,
    output logic [x-1:0] p,
    input logic clk,rst
);
    integer j;

    initial begin
        p = 0;
    end
    
    always_ff @( posedge clk or negedge rst ) begin
        j = (-m - 2) % x;
        p[0] =1;
        p[j+1] = 1;    
    end
    
endmodule 
