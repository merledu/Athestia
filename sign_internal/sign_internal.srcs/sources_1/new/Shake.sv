module sponge
#(parameter msg_len = 9, parameter d_len = 7000, capacity = 256, parameter r = 1600 - capacity)
(
    input logic clk,
    input logic reset,
    input logic [msg_len - 1: 0] message,
    input logic start,
    output logic [d_len - 1: 0] z,
    output logic done
);

logic [1599:0] str;
logic [1599:0] str2;
logic don;
logic k_reset;
logic [capacity - 1:0] zeros = '0;
logic [((-msg_len - 2) % r + r) % r + 1:0] pad;
logic [r * ((d_len/r)+1):0] h;
(* keep = "true" *) logic [((-msg_len - 2) % r + r) % r + 1 + msg_len:0] k;
(* keep = "true" *) logic [31:0] n;
logic [1599:0] store;
logic [1599:0] store2;
int count;
int count2;
logic k_strt;
always_comb begin
    k = {pad, message};
    n = $bits(k) / r;
//    if (capacity == 256) begin
//        if (count2== (d_len/r)+1)begin
//             done <= 1;
//             end
//    end else begin
             if (count== n && d_len <= r)begin
             done = 1;
             end 
             if (count2== (d_len/r)+1) begin
             done = 1;
             end
//    end             
      
   end
 
always_ff @(posedge clk ) begin
    if (reset) begin
        h <= '0;
        z <= '0;
        k_reset<=1;
        store <= 1600'b0;
        count <= 0;
        count2 <= 0;
        done <= 0;
    end 
    else if (reset == 0 && start == 1 ) begin
  //----------------------------------------------------------------Absorbing---------------------------------------------------
           if (count < n)begin 
           
           str <= store ^ {zeros, k[count * r +: r]};
           end
           k_strt <=1;
           if (don && count < n ) begin
           store <= str2;
            h[r-1:0] <= str2[r-1:0];
            store2<= str2;
           count <= count +1;
           k_reset <= 1;
            end 
            if (k_reset)  begin
               k_reset <= 0;
           end 
                          
   //------------------------------------------------------------squeezing-----------------------------------------------------------------------     
      if(count2 < (d_len/r)+1 && d_len >r  && count==n)begin
         
          str <= store2;
          if (don) begin
          h[(count2 * r) + r +: r] <= str2[r - 1 : 0];
           count2 <= count2+1;
           store2<= str2;
           
           k_reset <= 1;
          end
          end
      else  begin 
            z=h[d_len-1:0];
           end
//         checking <= (d_len/r)+2;      
//         if (count== (d_len/r)+2)begin
//         done <= 1;
//         end
  end
  end


keccak kp (
    .clk(clk),
    .rst(k_reset || reset ),
    .round_start(k_strt),
    .AB(str),
    .X(str2),
    .round_done(don)
);


pad10_1 #(.x(r), .m(msg_len)) pd (
    .p(pad)
);

endmodule
//Suthor = Amir jawed ---licensed ------ ---------------------------