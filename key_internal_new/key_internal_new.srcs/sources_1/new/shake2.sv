module spongee
#(parameter msg_len = 9, parameter d_len = 7000, capacity = 256, parameter r = 1600 - capacity)
(
    input logic clk,
    input logic reset,
    input logic [msg_len - 1: 0] message,
    input logic start,
    output logic [d_len - 1: 0] z,
    output logic done
);
logic [(msg_len+4) - 1: 0] msg_use;
logic [1599:0] str;
logic [1599:0] strr;
logic [1599:0] strrr;
logic [1599:0] strrrr;
logic [1599:0] str2;
logic [1599:0] str3;
logic [1599:0] str4;
logic [1599:0] str5;
logic [1599:0] s1;
logic [1599:0] s2;
logic [1599:0] Keccak_in;
logic don;
logic don1;
logic don2;
logic don3;
logic [capacity - 1:0] zeros = '0;
logic [((-msg_len - 2) % r + r) % r + 1:0] pad;
logic [(r * 7):0] h;
logic chk;
logic [31:0] len = r + msg_len;
(* keep = "true" *) logic [((-msg_len - 2) % r + r) % r + 1 + msg_len:0] k;
(* keep = "true" *) logic [31:0] n;
logic [1599:0] strng;
//-------------------------------------------
logic [1599:0] strEx1;
logic [1599:0] strEx2;
logic [1599:0] strEx3;

logic [1599:0] str2Ex1;
logic [1599:0] str2Ex2;
logic [1599:0] str2Ex3;

logic don6;
logic don7;
logic don8;
//----------------------
logic [1599:0] s3;
logic [1599:0] s5;
logic [1599:0] s7;
logic [1599:0] s9;
logic [1599:0] s11;
logic [1599:0] s13;
logic [1599:0] s15;
logic [1599:0] s17;
logic [1599:0] s19;
logic [1599:0] s21;
logic [1599:0] s23;
logic [1599:0] s25;
logic [1599:0] s27;
logic [1599:0] s29;
logic [1599:0] s31;
logic [1599:0] s33;
logic [1599:0] s35;
logic [1599:0] s37;
//----------------------------
 logic [1599:0]  s4, s6, s8, s10, s12, s14, s16, s18, s20, s22, s24, s26, s28, s30, s32, s34, s36 , s38;
  logic don9, don10, don11, don12, don13, don14, don15, don16, don17, don18, don19, don20, don21, don22, don23, don24, don25, don26, don27, don28, don29;



//-------------------------------------------

always_comb begin
//    msg_use = {4'b1111,message};
    $display("str1: %h",str);
    k = {pad, message};
    $display("zeros: %h",zeros);
    $display("k: %h",k);
    n = $bits(k) / r;
    str = 1600'b0 ^ {zeros, k[r - 1:0]};

    if (d_len > r && n == 1) begin
        strr = str2;
    end else if (d_len > r && n == 2) begin
        strr = s2;
    end
    else if (d_len > r && n == 3) begin
            strr = s4;
        end
        else if (d_len > r && n == 4) begin
                strr = s2;
            end
        else if (d_len > r && n == 5) begin
                strr = s8;
            end
            else if (d_len > r && n == 6) begin
                strr = s10;
            end
            else if (d_len > r && n == 7) begin
                strr = s12;
            end
            else if (d_len > r && n == 8) begin
                strr = s14;
            end
            else if (d_len > r && n == 9) begin
                strr = s16;
            end
            else if (d_len > r && n == 10) begin
                strr = s18;
            end
            else if (d_len > r && n == 11) begin
                strr = s20;
            end
            else if (d_len > r && n == 12) begin
                strr = s22;
            end
            else if (d_len > r && n == 13) begin
                strr = s24;
            end
            else if (d_len > r && n == 14) begin
                strr = s26;
            end
            else if (d_len > r && n == 15) begin
                strr = s28;
            end
            else if (d_len > r && n == 16) begin
                strr = s30;
            end
            else if (d_len > r && n == 17) begin
                strr = s32;
            end
            else if (d_len > r && n == 18) begin
                strr = s34;
            end
            else if (d_len > r && n == 19) begin
                strr = s36;
            end
            else if (d_len > r && n == 20) begin
                strr = s38;
            end    
    
    //--- now n=3 .....n=20 above condition

    if (d_len > (r * 2) - 1) begin
        strrr = str3;
    end

    if (d_len > (r * 3) - 1) begin
        strrrr = str4;
    end
    if(d_len > (r*4)-1)begin
         strEx1=str5;
    
    end
        if(d_len > (r*5)-1)begin
         strEx2=str2Ex1;
    
    end
        if(d_len > (r*6)-1)begin
         strEx3=str2Ex2;
    
    end
    if(d_len > (r*7)-1)begin
             z=0;
        
        end
        

    if (don && n >= 2) begin
        s1 = str2 ^ {zeros, k[(r * 2) - 1:r]};
    end else begin
        s1 = 0;
    end
    
      if (don5 && n >= 3) begin //don chnge
          s3 = s2 ^ {zeros, k[(r * 3) - 1:r*2]};
      end else begin
          s3 = 0;
      end
       if (don9 && n >= 4) begin //don chnge
               s5 = s4 ^ {zeros, k[(r * 4) - 1:r*3]};
           end else begin
               s5 = 0;
           end
        if (don10 && n >= 5) begin //don chnge
                s7 = s6 ^ {zeros, k[(r * 5) - 1:r*4]};
            end else begin
                s7 = 0;
            end
            
            if (don11 && n >= 6) begin //don chnge
                s9 = s8 ^ {zeros, k[(r * 6) - 1:r*5]};
            end else begin
                s9 = 0;
            end
            
            if (don12 && n >= 7) begin //don chnge
                s11 = s10 ^ {zeros, k[(r * 7) - 1:r*6]};
            end else begin
                s11 = 0;
            end
             if (don13 && n >= 8) begin //don chnge
                 s13 = s12 ^ {zeros, k[(r * 8) - 1:r*7]};
             end else begin
                 s13 = 0;
             end
             
             if (don14 && n >= 9) begin //don chnge
                 s15 = s14 ^ {zeros, k[(r * 9) - 1:r*8]};
             end else begin
                 s15 = 0;
             end
             
             if (don15 && n >= 10) begin //don chnge
                 s17 = s16 ^ {zeros, k[(r * 10) - 1:r*9]};
             end else begin
                 s17 = 0;
             end
             
             if (don16 && n >= 11) begin //don chnge
                 s19 = s18 ^ {zeros, k[(r * 11) - 1:r*10]};
             end else begin
                 s19 = 0;
             end
             
             if (don17 && n >= 12) begin //don chnge
                 s21 = s20 ^ {zeros, k[(r * 12) - 1:r*11]};
             end else begin
                 s21 = 0;
             end
             
             if (don18 && n >= 13) begin //don chnge
                 s23 = s22 ^ {zeros, k[(r * 13) - 1:r*12]};
             end else begin
                 s23 = 0;
             end
             
             if (don19 && n >= 14) begin //don chnge
                 s25 = s24 ^ {zeros, k[(r * 14) - 1:r*13]};
             end else begin
                 s25 = 0;
             end
             
             if (don20 && n >= 15) begin //don chnge
                 s27 = s26 ^ {zeros, k[(r * 15) - 1:r*14]};
             end else begin
                 s27 = 0;
             end
             
             if (don21 && n >= 16) begin //don chnge
                 s29 = s28 ^ {zeros, k[(r * 16) - 1:r*15]};
             end else begin
                 s29 = 0;
             end
             
             if (don22 && n >= 17) begin //don chnge
                 s31 = s30 ^ {zeros, k[(r * 17) - 1:r*16]};
             end else begin
                 s31 = 0;
             end
             
             if (don23 && n >= 18) begin //don chnge
                 s33 = s32 ^ {zeros, k[(r * 18) - 1:r*17]};
             end else begin
                 s33 = 0;
             end
             
             if (don24 && n >= 19) begin //don chnge
                 s35 = s34 ^ {zeros, k[(r * 19) - 1:r*18]};
             end else begin
                 s35 = 0;
             end
             
             if (don25 && n == 20) begin //don chnge
                 s37 = s36 ^ {zeros, k[(r * 20) - 1:r*19]};
             end else begin
                 s37 = 0;
             end
    
end

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        h <= '0;
        z <= '0;
    end else if (reset == 0 && start == 1) begin
        //k = {pad, message};
        z <= h[d_len - 1:0];
        if (don5 && n == 2) begin
             h[r - 1:0] <= s2[r - 1:0];
         end else if (don9 && n == 3) begin
             h[r - 1:0] <= s4[r - 1:0];
         end else if (don10 && n == 4) begin
               h[r - 1:0] <= s6[r - 1:0];
         end else if (don11 && n == 5) begin
             h[r - 1:0] <= s8[r - 1:0];
         end else if (don12 && n == 6) begin
             h[r - 1:0] <= s10[r - 1:0];
         end else if (don13 && n == 7) begin
             h[r - 1:0] <= s12[r - 1:0];
         end else if (don14 && n == 8) begin
             h[r - 1:0] <= s14[r - 1:0];
         end else if (don15 && n == 9) begin
             h[r - 1:0] <= s16[r - 1:0];
         end else if (don16 && n == 10) begin
             h[r - 1:0] <= s18[r - 1:0];
         end else if (don17 && n == 11) begin
             h[r - 1:0] <= s20[r - 1:0];
         end else if (don18 && n == 12) begin
             h[r - 1:0] <= s22[r - 1:0];
         end else if (don19 && n == 13) begin
             h[r - 1:0] <= s24[r - 1:0];
         end else if (don20 && n == 14) begin
             h[r - 1:0] <= s26[r - 1:0];
         end else if (don21 && n == 15) begin
             h[r - 1:0] <= s28[r - 1:0];
         end else if (don22 && n == 16) begin
             h[r - 1:0] <= s30[r - 1:0];
         end else if (don23 && n == 17) begin
             h[r - 1:0] <= s32[r - 1:0];
         end else if (don24 && n == 18) begin
             h[r - 1:0] <= s34[r - 1:0];
         end else if (don25 && n == 19) begin
             h[r - 1:0] <= s36[r - 1:0];
         end
           else if (don26 && n == 20) begin
                     h[r - 1:0] <= s38[r - 1:0];
                 end

         else begin
            h[r - 1:0] <= str2[r - 1:0];
        end

        if (don1 == 1'b1) begin
            h[(r * 2) - 1:r] <= str3[r - 1:0];
        end else begin
            h[(r * 2) - 1:r] <= '0;
        end

        if (don2 == 1'b1) begin
            h[(r * 3) - 1:r * 2] <= str4[r - 1:0];
        end else begin
            h[(r * 3) - 1:r * 2] <= '0;
        end

        if (don3 == 1'b1) begin
            h[(r * 4) - 1:r * 3] <= str5[r - 1:0];
        end else begin
            h[(r * 4) - 1:r * 3] <= '0;
        end
        
        if (don6 ==1'b1)begin
             h[(r * 5) - 1:r * 4] <= str2Ex1[r - 1:0];
              end else begin
                  h[(r * 5) - 1:r * 4] <= '0;
              end
         if (don7 ==1'b1)begin
                          h[(r * 6) - 1:r * 5] <= str2Ex2[r - 1:0];
                           end else begin
                               h[(r * 6) - 1:r * 5] <= '0;
                           end  
          if (don8 ==1'b1)begin
                       h[(r * 7) - 1:r * 6] <= str2Ex3[r - 1:0];
                          end else begin
                                    h[(r * 7) - 1:r * 6] <= '0;
                                        end                    
          if (z[d_len-1] == 1'b1 ||z[d_len-2] == 1'b1 || z[d_len-3] == 1'b1 || z[d_len-4] == 1'b1  ) begin
          done<=1;
          end                     
              
        $display("message :%0h",message);
        $display("z :%0h", z);
    end
   // done=1;
end

keccak kp (
    .clk(clk),
    .rst(reset),
    .round_start(1'b1),
    .AB(str),
    .X(str2),
    .round_done(don)
);

keccak kp4 (
    .clk(clk),
    .rst(reset),
    .round_start(don),
    .AB(s1),
    .X(s2),
    .round_done(don5)
);
//---------------------
keccak kp8 (
    .clk(clk),
    .rst(reset),
    .round_start(don5),
    .AB(s3),
    .X(s4),
    .round_done(don9)
);
 keccak kp9 (
     .clk(clk),
     .rst(reset),
     .round_start(don9),
     .AB(s5),
     .X(s6),
     .round_done(don10)
 );
 
 keccak kp10 (
     .clk(clk),
     .rst(reset),
     .round_start(don10),
     .AB(s7),
     .X(s8),
     .round_done(don11)
 );
 
 keccak kp11 (
     .clk(clk),
     .rst(reset),
     .round_start(don11),
     .AB(s9),
     .X(s10),
     .round_done(don12)
 );
 
 keccak kp12 (
     .clk(clk),
     .rst(reset),
     .round_start(don12),
     .AB(s11),
     .X(s12),
     .round_done(don13)
 );
 
 keccak kp13 (
     .clk(clk),
     .rst(reset),
     .round_start(don13),
     .AB(s13),
     .X(s14),
     .round_done(don14)
 );
 
 keccak kp14 (
     .clk(clk),
     .rst(reset),
     .round_start(don14),
     .AB(s15),
     .X(s16),
     .round_done(don15)
 );
  keccak kp15 (
     .clk(clk),
     .rst(reset),
     .round_start(don15),
     .AB(s17),
     .X(s18),
     .round_done(don16)
 );
 keccak kp16 (
      .clk(clk),
      .rst(reset),
      .round_start(don16),
      .AB(s19),
      .X(s20),
      .round_done(don17)
  );
   keccak kp17 (
       .clk(clk),
       .rst(reset),
       .round_start(don17),
       .AB(s21),
       .X(s22),
       .round_done(don18)
   );
    keccak kp18 (
         .clk(clk),
         .rst(reset),
         .round_start(don18),
         .AB(s23),
         .X(s24),
         .round_done(don19)
     );
     keccak kp19 (
              .clk(clk),
              .rst(reset),
              .round_start(don19),
              .AB(s25),
              .X(s26),
              .round_done(don20)
          );
       keccak kp20 (
                      .clk(clk),
                      .rst(reset),
                      .round_start(don20),
                      .AB(s27),
                      .X(s28),
                      .round_done(don21)
                  ); 
       keccak kp21 (
                       .clk(clk),
                       .rst(reset),
                       .round_start(don21),
                       .AB(s29),
                       .X(s30),
                       .round_done(don22)
                   ); 
            keccak kp22 (
            .clk(clk),
            .rst(reset),
            .round_start(don22),
            .AB(s31),
            .X(s32),
            .round_done(don23)
        ); 
          keccak kp23 (
                  .clk(clk),
                  .rst(reset),
                  .round_start(don23),
                  .AB(s33),
                  .X(s34),
                  .round_done(don24)
              ); 
           keccak kp24 (
                               .clk(clk),
                               .rst(reset),
                               .round_start(don24),
                               .AB(s35),
                               .X(s36),
                               .round_done(don25)
                           );
    keccak kp25 (
                                 .clk(clk),
                                 .rst(reset),
                                 .round_start(don25),
                                 .AB(s37),
                                 .X(s38),
                                 .round_done(don26)
                             );          
     


//---------------

keccak kp1 (
    .clk(clk),
    .rst(reset),
    .round_start(don5),
    .AB(strr),
    .X(str3),
    .round_done(don1)
);

keccak kp2 (
    .clk(clk),
    .rst(reset),
    .round_start(don1),
    .AB(strrr),
    .X(str4),
    .round_done(don2)
);

keccak kp3 (
    .clk(clk),
    .rst(reset),
    .round_start(don2),
    .AB(strrrr),
    .X(str5),
    .round_done(don3)
);
//--------------------------------------------------------------
keccak kp5 (
    .clk(clk),
    .rst(reset),
    .round_start(don3),
    .AB(strEx1),
    .X(str2Ex1),
    .round_done(don6)
);
keccak kp6 (
    .clk(clk),
    .rst(reset),
    .round_start(don6),
    .AB(strEx2),
    .X(str2Ex2),
    .round_done(don7)
);
keccak kp7 (
    .clk(clk),
    .rst(reset),
    .round_start(don7),
    .AB(strEx3),
    .X(str2Ex3),
    .round_done(don8)
);
//-----------------------------------------------------------

pad10_1 #(.x(r), .m(msg_len)) pd (
    .p(pad)
);

endmodule