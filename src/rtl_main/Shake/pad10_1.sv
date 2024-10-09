module pad10_1 #(
    parameter x = 8
) (
    input logic [32:0] m,
    output logic [x-1:0] p
);
    integer j;

    always_comb begin
        p = '0;
        j = (-m - 2) % x;
        p[0] =1;
        p[j+1] = 1;    
    end
    
endmodule 