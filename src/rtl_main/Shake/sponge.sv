module sponge
#(parameter msg_len=5 , parameter d_len=2048,capacity=512 , parameter r=1600-capacity)
(
    input logic clk,
    input logic reset,
    input logic [msg_len-1: 0] message,
    input logic start,
   // input logic [31:0]capacity,
    output logic [d_len-1:0] z
);
//input logic start;
logic [1599:0] str=1600'b0;
logic [1599:0] str2;
logic don;
//logic [31:0]r=1600-capacity;
logic [(r-(msg_len+2))+1:0] pad;
logic [r+d_len:0]h;
//logic cal = (r-(msg_len+2))+2;


logic[31:0] len=r+msg_len;
logic [ ((r-(msg_len+2))+1)+msg_len:0]p;
logic [31:0] n;
logic [1599:0] String;

keccak kp (
    .clk(clk),
    .rst(reset),
   // .start(start),
    .AB(str),
    .X(str2),
    .round_done(don)
);
pad10_1 #(.x(r),.m(msg_len)) pd(
   // .clk(clk),
   
    //.rst(reset),
    //.m(msg_len),
    .p(pad)

);




always_ff @(posedge clk or posedge reset) begin
    if (reset ==0 && start == 1)begin 
        p={pad,message}; // correct
        n=$bits(p)/r;  // correct 
        for(int i=0;i<n;i++ ) begin //correct
         str = str ^ {p,512'b0};
 //correct
        end
        $display("str: %0b", str);
        h={str2[r:0],h[0]}; //1089
        while (d_len > $bits(h))begin   //100000 > 1089
             str=str;
             h={str2[r:0],h[0]};
            

        // end

        // z=[d_len-1:(r+1)-d_len] z;
     end
    assign z=h[d_len-1:0];
    $display("z :%0h",z);
    end     

end

endmodule
