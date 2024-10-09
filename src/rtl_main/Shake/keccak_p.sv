
module keccak(
    input  logic clk,
    input  logic rst,
    //input  logic rc,
    input logic [1599:0] AB,
    //input  logic [63:0] A [0:4][0:4],
    output logic [1599:0] X,
    logic round_done 
    );
    
   logic [63:0] A[0:4][0:4];
   always_comb begin
   
            A[0][0] = AB[63:0];
            A[1][0] = AB[127:64];
            A[2][0] = AB[191:128];
            A[3][0] = AB[255:192];
            A[4][0] = AB[319:256];
   
            A[0][1] = AB[383:320];
            A[1][1] = AB[447:384];
            A[2][1] = AB[511:448];
            A[3][1] = AB[575:512];
            A[4][1] = AB[639:578];
   
             A[0][2] = AB[703:640];
            A[1][2] = AB[767:704];
            A[2][2] = AB[831:768];
            A[3][2] = AB[895:832];
            A[4][2] = AB[959:896];
              
            A[0][3] = AB[1023:960];
            A[1][3] = AB[1087:1024];
            A[2][3] = AB[1151:1088];
            A[3][3] = AB[1215:1152];
            A[4][3] = AB[1279:1216];
   
            A[0][4] = AB[1343:1280];
            A[1][4] = AB[1407:1344];
            A[2][4] = AB[1471:1408];
            A[3][4] = AB[1535:1472];
            A[4][4] = AB[1599:1536];
   end
   logic [63:0] X_temp [0:4][0:4];
   logic [63:0] RC [0:23];
   logic [63:0] A_temp [0:4][0:4];
//   logic [63:0] X_temp [0:4][0:4];
   logic [63:0] rc_temp;
//   logic rst_temp;
//    logic [63:0] X_temp0 [0:4][0:4];
    logic [63:0] X_temp1 [0:4][0:4];
    logic [63:0] X_temp2 [0:4][0:4];
    logic [63:0] X_temp3 [0:4][0:4];
    logic [63:0] X_temp4 [0:4][0:4];
    logic [63:0] X_temp5 [0:4][0:4];
    logic [63:0] X_temp6 [0:4][0:4];
    logic [63:0] X_temp7 [0:4][0:4];
    logic [63:0] X_temp8 [0:4][0:4];
    logic [63:0] X_temp9 [0:4][0:4];
    logic [63:0] X_temp10 [0:4][0:4];
    logic [63:0] X_temp11 [0:4][0:4];
    logic [63:0] X_temp12 [0:4][0:4];
    logic [63:0] X_temp13 [0:4][0:4];
    logic [63:0] X_temp14 [0:4][0:4];
    logic [63:0] X_temp15 [0:4][0:4];
    logic [63:0] X_temp16 [0:4][0:4];
    logic [63:0] X_temp17 [0:4][0:4];
    logic [63:0] X_temp18 [0:4][0:4];
    logic [63:0] X_temp19 [0:4][0:4];
    logic [63:0] X_temp20 [0:4][0:4];
    logic [63:0] X_temp21 [0:4][0:4];
    logic [63:0] X_temp22 [0:4][0:4];
    logic [63:0] X_temp23 [0:4][0:4];
    logic [63:0] X_temp24 [0:4][0:4];
    
   typedef enum logic [4 : 0] {
        Idle, Round_1,  Round_2,  Round_3,  Round_4,  Round_5,  Round_6,  Round_7,  Round_8,
        Round_9,  Round_10, Round_11, Round_12, Round_13, Round_14, Round_15, Round_16,
        Round_17, Round_18, Round_19, Round_20, Round_21, Round_22, Round_23, Round_24, DONE
    } state_type;
    
    state_type state, next_state;
    
    initial begin
        RC[0]  = 64'h0000000000000001;     RC[1]  = 64'h0000000000008082;     RC[2]  = 64'h800000000000808a;
        RC[3]  = 64'h8000000080008000;     RC[4]  = 64'h000000000000808b;     RC[5]  = 64'h0000000080000001;
        RC[6]  = 64'h8000000080008081;     RC[7]  = 64'h8000000000008009;     RC[8]  = 64'h000000000000008a;
        RC[9]  = 64'h0000000000000088;     RC[10] = 64'h0000000080008009;     RC[11] = 64'h000000008000000a;
        RC[12] = 64'h000000008000808b;     RC[13] = 64'h800000000000008b;     RC[14] = 64'h8000000000008089;
        RC[15] = 64'h8000000000008003;     RC[16] = 64'h8000000000008002;     RC[17] = 64'h8000000000000080;
        RC[18] = 64'h000000000000800a;     RC[19] = 64'h800000008000000a;     RC[20] = 64'h8000000080008081;
        RC[21] = 64'h8000000000008080;     RC[22] = 64'h0000000080000001;     RC[23] = 64'h8000000080008008;     
    end
    
    always_ff @(posedge clk or posedge rst) begin
            if (rst)
                state <= Idle;
            else
                state <= next_state;
        end
    
    always_comb begin
//        next_state = state; // Default next state is the current state
//        rst_temp = rst;     // Pass the reset signal
//        A_temp = A;
//        X_temp = X;         // Pass the input matrix A
        
        
           case (state)
               Idle: begin
                   round_done = 0;
                   A_temp = '{default:64'b0};
                   rc_temp = 64'h0;    // Default RC value  
                   next_state = Round_1;                  
               end 
               Round_1: begin
                   A_temp = A;
                   rc_temp = RC[0];
                   X_temp1 = X_temp;
                   
                   next_state = Round_2;                  
               end
               Round_2: begin
                   A_temp = X_temp1;
                   rc_temp = RC[1];
                   X_temp2 = X_temp;
                   
                   next_state = Round_3;                  
               end
               Round_3: begin
                   A_temp = X_temp2;
                   rc_temp = RC[2];
                   X_temp3 = X_temp; 
                  
                   next_state = Round_4;                  
               end
               Round_4: begin
                   A_temp = X_temp3;
                   rc_temp = RC[3];
                   X_temp4 = X_temp;
                   
                   next_state = Round_5;                  
               end
               Round_5: begin
                   A_temp = X_temp4;
                   rc_temp = RC[4];
                   X_temp5 = X_temp;
                   
                   next_state = Round_6;                  
               end
               Round_6: begin
                   A_temp = X_temp5;
                   rc_temp = RC[5];
                   X_temp6 = X_temp;
                   
                   next_state = Round_7;                  
               end
               Round_7: begin
                   A_temp = X_temp6;
                   rc_temp = RC[6];
                   X_temp7 = X_temp;
                   
                   next_state = Round_8;                  
               end
               Round_8: begin
                   A_temp = X_temp7;
                   rc_temp = RC[7];
                   X_temp8 = X_temp;
                   
                   next_state = Round_9;                  
               end
               Round_9: begin
                   A_temp = X_temp8;
                   rc_temp = RC[8];
                   X_temp9 = X_temp;
                   
                   next_state = Round_10;                  
               end
               Round_10: begin
                   A_temp = X_temp9;
                   rc_temp = RC[9];
                   X_temp10 = X_temp;
                   
                   next_state = Round_11;                  
               end
               Round_11: begin
                   A_temp = X_temp10;
                   rc_temp = RC[10];
                   X_temp11 = X_temp;
                   
                   next_state = Round_12;                  
               end
               Round_12: begin
                   A_temp = X_temp11;
                   rc_temp = RC[11];
                   X_temp12 = X_temp;
                   
                   next_state = Round_13;                  
               end
               Round_13: begin
                   A_temp = X_temp12;
                   rc_temp = RC[12];
                   X_temp13 = X_temp;
                   
                   next_state = Round_14;                  
               end
               Round_14: begin
                   A_temp = X_temp13;
                   rc_temp = RC[13];
                   X_temp14 = X_temp;
                   
                   next_state = Round_15;                  
               end
               Round_15: begin
                   A_temp = X_temp14;
                   rc_temp = RC[14];
                   X_temp15 = X_temp;
                  
                   next_state = Round_16;                  
               end
               Round_16: begin
                   A_temp = X_temp15;
                   rc_temp = RC[15];
                   X_temp16 = X_temp;
                  
                   next_state = Round_17;                  
               end
               Round_17: begin
                   A_temp = X_temp16;
                   rc_temp = RC[16];
                   X_temp17 = X_temp;
                   
                   next_state = Round_18;                  
               end
               Round_18: begin
                   A_temp = X_temp17;
                   rc_temp = RC[17];
                   X_temp18 = X_temp;
                   
                   next_state = Round_19;                  
               end
               Round_19: begin
                   A_temp = X_temp18;
                   rc_temp = RC[18];
                   X_temp19 = X_temp;
                   
                   next_state = Round_20;                  
               end
               Round_20: begin
                   A_temp = X_temp19;
                   rc_temp = RC[19];
                   X_temp20 = X_temp;
                   
                   next_state = Round_21;                  
               end
               Round_21: begin
                   A_temp = X_temp20;
                   rc_temp = RC[20];
                   X_temp21 = X_temp;
                   
                   next_state = Round_22;                  
               end
               Round_22: begin
                   A_temp = X_temp21;
                   rc_temp = RC[21];
                   X_temp22 = X_temp;
                   
                   next_state = Round_23;                  
               end
               Round_23: begin
                   A_temp = X_temp22;
                   rc_temp = RC[22];
                   X_temp23 = X_temp;
                   
                   next_state = Round_24;                  
               end
                Round_24: begin
                   A_temp = X_temp23;
                   rc_temp = RC[23];
                   X_temp24 = X_temp;
                   
                   next_state = DONE;                 
               end  
               DONE: begin
                   round_done = 1'b1; 
               end                                                             
           endcase
       end
        Rnd u_fn_0 (
            .round(rc_temp),
            .A(A_temp),
            .A_final(X_temp)
        );
        
//COLUMN_1
        assign  X[63:0]    = X_temp24[0][0];
        assign  X[127:64]  = X_temp24[1][0];
        assign  X[191:128] = X_temp24[2][0];
        assign  X[255:192] = X_temp24[3][0];
        assign  X[319:256] = X_temp24[4][0];
              
        //COLUMN_2
        assign  X[383:320] = X_temp24[0][1];
        assign  X[447:384] = X_temp24[1][1];
        assign  X[511:448] = X_temp24[2][1];
        assign  X[575:512] = X_temp24[3][1];
        assign  X[639:576] = X_temp24[4][1];
             
        //COLUMN_3
        assign  X[703:640] = X_temp24[0][2];
        assign  X[767:704] = X_temp24[1][2];
        assign  X[831:768] = X_temp24[2][2];
        assign  X[895:832] = X_temp24[3][2];
        assign  X[959:896] = X_temp24[4][2];
           
        //COLUMN_4
        assign  X[1023:960] = X_temp24[0][3];
        assign  X[1087:1024] = X_temp24[1][3];
        assign  X[1151:1088] = X_temp24[2][3];
        assign  X[1215:1152] = X_temp24[3][3];
        assign  X[1279:1216] = X_temp24[4][3];
            
        //COLUMN_5
        assign  X[1343:1280] = X_temp24[0][4];
        assign  X[1407:1344] = X_temp24[1][4];
        assign  X[1471:1408] = X_temp24[2][4];
        assign  X[1535:1472] = X_temp24[3][4];
        assign  X[1599:1536] = X_temp24[4][4];
        
        
endmodule  

//        assign X=X_temp24;     
//        fn u_fn_1 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h0000000000008082),
//            .A(X_temp0),
//            .X(X_temp1)
//        );
//        fn u_fn_2 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h800000000000808A),
//            .A(X_temp1),
//            .X(X_temp2)
//        );
//        fn u_fn_3 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000080008000),
//            .A(X_temp2),
//            .X(X_temp3)
//        );
//        fn u_fn_4 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h000000000000808B),
//            .A(X_temp3),
//            .X(X_temp4)
//        );
//        fn u_fn_5 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h0000000080000001),
//            .A(X_temp4),
//            .X(X_temp5)
//        );
//        fn u_fn_6 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000080008081),
//            .A(X_temp5),
//            .X(X_temp6)
//        );       
//        fn u_fn_7 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000000008009),
//            .A(X_temp6),
//            .X(X_temp7)
//        );
//        fn u_fn_8 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h000000000000008A),
//            .A(X_temp7),
//            .X(X_temp8)
//        );
//        fn u_fn_9 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h0000000000000088),
//            .A(X_temp8),
//            .X(X_temp9)
//        );
//        fn u_fn_10 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h0000000080008009),
//            .A(X_temp9),
//            .X(X_temp10)
//        );
//        fn u_fn_11 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h000000008000000A),
//            .A(X_temp10),
//            .X(X_temp11)
//        );
//        fn u_fn_12 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h000000008000808B),
//            .A(X_temp11),
//            .X(X_temp12)
//        );       
//        fn u_fn_13 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h800000000000008B),
//            .A(X_temp12),
//            .X(X_temp13)
//        );
//        fn u_fn_14 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000000008089),
//            .A(X_temp13),
//            .X(X_temp14)
//        );
//        fn u_fn_15 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000000008003),
//            .A(X_temp14),
//            .X(X_temp15)
//        );
//        fn u_fn_16 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000000008002),
//            .A(X_temp15),
//            .X(X_temp16)
//        );
//        fn u_fn_17 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000000000080),
//            .A(X_temp16),
//            .X(X_temp17)
//        );
//        fn u_fn_18 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h000000000000800A),
//            .A(X_temp17),
//            .X(X_temp18)
//        );       
//        fn u_fn_19 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h800000008000000A),
//            .A(X_temp18),
//            .X(X_temp19)
//        );
//        fn u_fn_20 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000080008081),
//            .A(X_temp19),
//            .X(X_temp20)
//        );
//        fn u_fn_21 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000000008080),
//            .A(X_temp20),
//            .X(X_temp21)
//        );
//        fn u_fn_22 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h0000000080000001),
//            .A(X_temp21),
//            .X(X_temp22)
//        );
//        fn u_fn_23 (
//            .clk(clk),
//            .rst(rst),
//            .rc(64'h8000000080008008),
//            .A(X_temp22),
//            .X(X)
//        );

        
       
//       assign X=B