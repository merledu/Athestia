module sponge
#(parameter msg_len=9 , parameter d_len=4096,capacity=512 , parameter r=1600-capacity)
(
    input logic clk,
    input logic reset,
    input logic [msg_len-1: 0] message,
    input logic start,
   // input logic [31:0]capacity,
    output logic [d_len-1:0] z
);
//input logic start;
logic [1599:0] str;
logic [1599:0] str2;
logic [1599:0] Keccak_in;
logic don;
//logic [31:0]r=1600-capacity;
logic [((-msg_len - 2) % r + r) % r+1:0] pad;
logic [4351:0]h;
logic chk; 
//logic cal = (r-(msg_len+2))+2;


logic[31:0] len=r+msg_len;
logic [ ((-msg_len - 2) % r + r) % r+1+msg_len:0]k;
logic [31:0] n;
logic [1599:0] strng;
logic valid;



logic valid_d;
//assign Keccak_in = (valid) ? str : 1600'b0; 
keccak kp (
    .clk(clk),
    .rst(reset),
   // .start(start),
    .AB( Keccak_in),
    .X(str2),
    .round_done(don)
);
pad10_1 #(.x(r),.m(msg_len)) pd (
  .p(pad)
);


always_ff @(posedge clk or posedge reset) begin //0
    if (reset ==0 && start == 1)begin //1
        k={pad,message}; // correct
        n=$bits(k)/r;  // correct 
//        for (int i = 0; i < n; i++) begin
//            strng = (i == 1) ? {512'b0, k} : {512'b0, k[(i * r) +: r]};
//            str = (i == 1) ? (1600'b0 ^ strng) : (str2 ^ strng);
//        end
 for(int i=0;i<n;i++ ) begin //correct
         //strng={512'b0,k};
        if (i==0) begin
         str=1600'b0^{512'b0,k[(i * r)+:r]};
        //   str=1600'b0^{512'b0,k};
         end
         else if (i>1 && don==1) begin
         str=str2^{512'b0,k[(i * r)+:r]};
         
         end
         end

    //    for(int i=0;i<n;i++ ) begin //correct //start
    //    if (i==1)begin
//          strng={512'b0,k};
//          str=1600'b0^strng;
          
//          if (n>1 && don==1 && n<5) begin//2
//         // don=0'b0;
//          str=str2^{512'b0,strng[2175:1088]};
//          end //2
//           if (n>2 && don==1  && n<5) begin //3
//        //    don=0'b0;
//           str=str2^{512'b0,strng[3263:2176]};
//           end//3
//           if (n>3 && don==1  && n<5) begin //4
//         //   don=0'b0;
//           str=str2^{512'b0,strng[3263:2176]};
//           end //4
          
     //     end
//        else begin
     
//        str=str2^{512'b0,k[(i * r)+:r]};
      //  end  
       //end //end
// //correct
       
        valid <= 1;
        if (valid==1)begin //5
        valid<=0;
        end//5
        
        if (valid==1)begin//6
        Keccak_in = str;
        end//6
        
      //  $display("str: %0b", str);
        if (don==1'b1)
        begin //7
       // $display("don 2: %0b", str2);
        h[r-1:0]=str2[r-1:0];
     //   $display("don 1: %0b", don);
        end //7
        if (d_len > r)
        begin  //8
         $display("str2 2: %0h", str2);
          str<=str2;
          valid<=1;
          //$display("don 2: %0b", don);
          
         if (don==1'b1)
               begin  //9
                h[2175:r]=str2[r-1:0];
                valid<=0;
               end //9
         end   //8   
          if (d_len > 2175)
                     begin //10 
                     $display("str2 3: %0h", str2);
                      str<=str2;
                      valid<=1;
                      if (don==1'b1)
                            begin //11
                             h[3263:2176]=str2[r-1:0];
                               valid<=0;
                             
                            end   //11 
        end //10
        if (d_len > 3263)
            begin //12 
            $display("str2 4: %0h", str2);
               str<=str2;
               valid<=1;
            if (don==1'b1)
            begin //13
            h[4351:3264]<=str2[r-1:0];
            valid<=0;
            end       //13
            end//12
         //1089
//        while (d_len > $bits(h))
//        begin   //100000 > 1089
//        str=str;
//        h={str2[r:0],h[0]};
//        chk=1;  
//        end

        // z=[d_len-1:(r+1)-d_len] z;
        
    assign z=h[d_len-1:0];
    $display("z :%0h",z);
     //end    1
     end//1
     end //0
     endmodule
