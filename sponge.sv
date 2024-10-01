module sponge
#(parameter msg_len=8 , parameter d_len=1000,capacity=512 , parameter r=1600-capacity)
(
    input logic clk,
    input logic reset,
    input logic [msg_len: 0] message,
    input logic start,
   // input logic [31:0]capacity,
    output logic [d_len-1:0] z
);
//input logic start;
logic [1599:0] str;
logic [1599:0] str2;
logic don;
//logic [31:0]r=1600-capacity;
logic [(r-1):0] pad;
logic [r+d_len:0]h;


keccak_p kp (
    .clk(clk),
    .rst(reset),
    .start(start),
    .S(str),
    .S_prime(str2),
    .done(don)
);
pad10_1 #(.x(r)) pd(
    .clk(clk),
    .rst(reset),
    .m(msg_len),
    .p(pad)

);
logic[31:0] len=r+msg_len;
logic [(r+msg_len):0]p;
logic [31:0] n;
logic [1599:0] String;


always_ff @(posedge clk or posedge reset) begin
    if (~reset && start == 1)begin 
        p={message,pad}; // correct
        n=len/r;  // correct 
        for(int i=0;i<n;i++ ) begin //correct
       str = str ^ {p[i], {capacity{1'b0}}};
 //correct
        end
        
        h={h[0],str2[1599:1599-r]}; //1089
        while (d_len > $bits(h))begin   //100000 > 1089
             str=str;
             h={h[0],str2[1599:1599-r]};
            

        // end

        // z=[d_len-1:(r+1)-d_len] z;
     end
    assign z=h[r+d_len:r-d_len];
    $display("z :%0h",z);
    end     

end

endmodule
