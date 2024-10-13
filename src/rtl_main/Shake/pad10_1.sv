module pad10_1 #(
    parameter x = 8, parameter m=0
) (
   // input logic [32:0] m,
    output logic [(x-(m+2))+1:0] p
);
    integer j;

    always_comb begin
        p = '0;
      //  j = (-m - 2) % x;
        p[0] =1;
        p[(x-(m+2))+1] = 1;    
    end
    
endmodule 
