`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2024 20:50:43
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// ******************************************************************************************//
//module tb;
//    import Dilithium_pkg::*;
//    initial begin
//        $display("q = %d", q);
//        $display("zeta = %d", zeta);
//        $display("d = %d", d);
//        $display("tau = %d", tau);
//        $display("lambda = %d", lambda);
//        $display("gamma1 = %d", gamma1);
//        $display("gamma2 = %d", gamma2);
//        $display("k = %d", k);
//        $display("l = %d", l);
//        $display("eta = %d", eta);
//        $display("beta = %d", beta);
//        $display("omega = %d", omega);
//    end
//endmodule




// ******************************************************************************************//
//module tb;
//    logic signed [22:0] t;

//    logic signed [9:0]  t1;
//    logic signed [12:0] t0;

//    Power2round uut (
//        .t(t),
//        .t1(t1),
//        .t0(t0)
//    );

//    initial begin
//        $display("Time = %0t | t = %0d | t1 = %0d | t0 = %0d", $time, t, t1, t0);
//        t = 23'd7011276;
//        #10;
        
//        $finish;
//    end
//endmodule




// ******************************************************************************************//
//module tb;
//    parameter int ALPHA = 3;

//    logic [ALPHA-1:0] x;
//    logic [ALPHA-1:0] y;

//    IntegerToBits #(.ALPHA(ALPHA)) uut (
//        .x(x),
//        .y(y)
//    );

//    initial begin
//        x = 4;  // Binary representation: 0000001111111111 in 16 bits
//        #10;
//        // Loop through each bit of y and display as an array of 0s and 1s
//        for (int i = 0; i < ALPHA; i = i + 1) begin
//            $write("%0d", y[i]);
//            if (i < ALPHA - 1)
//                $write(", ");
//        end
//        $finish;
//    end
//endmodule




// ******************************************************************************************//
//module tb;
//    parameter int Y = 12;                         // Length of input bit array
//    localparam int Z_WIDTH = ((Y + 7) / 8) * 8;  // Output bit array width

//    logic [Y-1:0] y;                              // Input bit array
//    logic [Z_WIDTH-1:0] z;                        // Output byte array

//    BitsToBytes #(
//        .Y(Y)
//    ) uut (
//        .y(y),
//        .z(z)
//    );

//    initial begin
//        y = 12'b101101011001;  // Input bit string (little-endian representation)
//        #10;
//        $display("Input y (binary): %b", y);
//        $display("Output z (hexadecimal): %0h", z);
        
//        for (int i = 0; i < Z_WIDTH / 8; i++) begin  // Print individual bytes of z for verification
//            $display("Byte %0d: %0d (decimal)", i, z[i * 8 +: 8]);
//        end
//        $finish;
//    end
//endmodule




// ******************************************************************************************//
//module tb;
//    parameter int MAX_WIDTH = 3; // Maximum width of x
    
//    logic [MAX_WIDTH-1:0] x;      // Input integer
//    logic [$clog2(MAX_WIDTH):0] bit_length; // Output bit length

//    Bitlen #(
//        .MAX_WIDTH(MAX_WIDTH)
//    ) uut (
//        .x(x),
//        .bit_length(bit_length)
//    );

//    initial begin
//        x = 4; 
//        #10;
//        $display("Input x: %d, Bit length: %d", x, bit_length); // Expected: 6
//        $finish;
//    end
//endmodule




// ******************************************************************************************//
module tb;
    parameter int W_WIDTH = 10;    // Width of the coefficients in w
    parameter int B_WIDTH = 10;    // Width of the integer b

    logic [W_WIDTH-1:0] w [255:0];  // Input array w of 256 elements
    logic [B_WIDTH-1:0] b;          // Input integer b
    
//    logic [(256 * W_WIDTH + B_WIDTH) - 1:0] z;  // Output bitstream array
    logic [((256 * W_WIDTH + B_WIDTH)-10) - 1:0] z;  // Output bitstream array


    SimpleBitPack #(
        .W_WIDTH(W_WIDTH),
        .B_WIDTH(B_WIDTH)
    ) uut (
        .w(w),
        .b(b),
        .z(z)
    );

    initial begin
        w[0] = 787;   w[1] = 690;   w[2] = 216;   w[3] = 813;
        w[4] = 845;   w[5] = 504;   w[6] = 941;   w[7] = 243;
        w[8] = 880;   w[9] = 649;   w[10] = 979;  w[11] = 123;
        w[12] = 320;  w[13] = 1018; w[14] = 881;  w[15] = 167;
        w[16] = 163;  w[17] = 919; w[18] = 22;   w[19] = 97;
        w[20] = 522;  w[21] = 457; w[22] = 526;  w[23] = 144;
        w[24] = 707;  w[25] = 941; w[26] = 891;  w[27] = 679;
        w[28] = 91;   w[29] = 682; w[30] = 26;   w[31] = 266;
        w[32] = 132;  w[33] = 534; w[34] = 366;  w[35] = 353;
        w[36] = 281;  w[37] = 655; w[38] = 619;  w[39] = 898;
        w[40] = 23;   w[41] = 628; w[42] = 642;  w[43] = 309;
        w[44] = 595;  w[45] = 997; w[46] = 851;  w[47] = 932;
        w[48] = 439;  w[49] = 308; w[50] = 568;  w[51] = 428;
        w[52] = 766;  w[53] = 684; w[54] = 932;  w[55] = 720;
        w[56] = 641;  w[57] = 853; w[58] = 908;  w[59] = 514;
        w[60] = 713;  w[61] = 322; w[62] = 348;  w[63] = 808;
        w[64] = 670;  w[65] = 350; w[66] = 149;  w[67] = 529;
        w[68] = 800;  w[69] = 319; w[70] = 494;  w[71] = 665;
        w[72] = 1012; w[73] = 122; w[74] = 647;  w[75] = 830;
        w[76] = 373;  w[77] = 358; w[78] = 697;  w[79] = 678;
        w[80] = 565;  w[81] = 827; w[82] = 985;  w[83] = 277;
        w[84] = 332;  w[85] = 555; w[86] = 446;  w[87] = 241;
        w[88] = 361;  w[89] = 915; w[90] = 456;  w[91] = 460;
        w[92] = 919;  w[93] = 298; w[94] = 867;  w[95] = 965;
        w[96] = 829;  w[97] = 630; w[98] = 523;  w[99] = 532;
        w[100] = 700; w[101] = 89;  w[102] = 639; w[103] = 947;
        w[104] = 645; w[105] = 604; w[106] = 575; w[107] = 201;
        w[108] = 173; w[109] = 206; w[110] = 418; w[111] = 988;
        w[112] = 105; w[113] = 436; w[114] = 510; w[115] = 120;
        w[116] = 443; w[117] = 172; w[118] = 1014; w[119] = 37;
        w[120] = 676; w[121] = 829; w[122] = 346; w[123] = 237;
        w[124] = 248; w[125] = 99;  w[126] = 970; w[127] = 587;
        w[128] = 741; w[129] = 295; w[130] = 343; w[131] = 854;
        w[132] = 58;  w[133] = 834; w[134] = 435; w[135] = 324;
        w[136] = 219; w[137] = 617; w[138] = 322; w[139] = 57;
        w[140] = 806; w[141] = 936; w[142] = 53;  w[143] = 448;
        w[144] = 617; w[145] = 463; w[146] = 842; w[147] = 203;
        w[148] = 573; w[149] = 363; w[150] = 143; w[151] = 990;
        w[152] = 660; w[153] = 846; w[154] = 715; w[155] = 209;
        w[156] = 806; w[157] = 898; w[158] = 205; w[159] = 301;
        w[160] = 573; w[161] = 846; w[162] = 27;  w[163] = 285;
        w[164] = 58;  w[165] = 213; w[166] = 949; w[167] = 349;
        w[168] = 1011; w[169] = 330; w[170] = 407; w[171] = 553;
        w[172] = 596; w[173] = 395; w[174] = 1017; w[175] = 787;
        w[176] = 664; w[177] = 406; w[178] = 899; w[179] = 272;
        w[180] = 908; w[181] = 721; w[182] = 718; w[183] = 637;
        w[184] = 557; w[185] = 767; w[186] = 790; w[187] = 357;
        w[188] = 807; w[189] = 702; w[190] = 370; w[191] = 990;
        w[192] = 231; w[193] = 188; w[194] = 390; w[195] = 588;
        w[196] = 254; w[197] = 928; w[198] = 226; w[199] = 470;
        w[200] = 750; w[201] = 445; w[202] = 851; w[203] = 404;
        w[204] = 61;  w[205] = 874; w[206] = 627; w[207] = 206;
        w[208] = 997; w[209] = 302; w[210] = 80;  w[211] = 964;
        w[212] = 318; w[213] = 116; w[214] = 348; w[215] = 838;
        w[216] = 484; w[217] = 144; w[218] = 809; w[219] = 140;
        w[220] = 917; w[221] = 298; w[222] = 887; w[223] = 645;
        w[224] = 798; w[225] = 611; w[226] = 738; w[227] = 844;
        w[228] = 178; w[229] = 757; w[230] = 772; w[231] = 572;
        w[232] = 725; w[233] = 565; w[234] = 438; w[235] = 325;
        w[236] = 815; w[237] = 224; w[238] = 485; w[239] = 75;
        w[240] = 394; w[241] = 446; w[242] = 291; w[243] = 258;
        w[244] = 952; w[245] = 237; w[246] = 477; w[247] = 138;
        w[248] = 80;  w[249] = 410; w[250] = 165; w[251] = 884;
        w[252] = 155; w[253] = 645; w[254] = 919; w[255] = 83;

        b = 1023;  // Example input integer b

        #10; // Wait for the processing to complete

       // Display results before converting to bytes
        $display("Input w: %p", w);
        $display("Input b: %d", b);
        $display("Packed z_bits: %b", uut.z_bits);  // Display the packed z_bits before byte conversion

        // Display the final packed byte array
        $display("Output z (hexadecimal): %0h", z);
        
        $finish;
    end
endmodule




// ******************************************************************************************//
//module tb;
//    parameter int WIDTH = 512;  // 128 hex digits = 128 * 4 = 512 bits

//    logic [WIDTH-1:0] in_data;   // Input data (512 bits)
//    logic [WIDTH-1:0] out_data;  // Output data (reversed)

//    // Instantiate the Reverse module
//    Reverse #(
//        .WIDTH(WIDTH)
//    ) uut (
//        .in_data(in_data),
//        .out_data(out_data)
//    );

//    initial begin
//        // Example Hex Input: 128 hex digits = 512 bits
//        in_data = 512'h14f97a149bdd0a566850229dd3b7b8409236f98a12de53832f515b68d6d58f304bd4b2d32e298f1ea17774ab9523329241e4d195c1d13ef10504bbe533a73da83d653536f6ee758e2e80fe931862f0e7f7972afb2759716bfe2d9f6ceb478c4438365a98c4ff962e548a59752bf3577b53543a4741bd3a3d4b4cde0b26346cbd3a94f788f5ae3d32f4a73e6970035ea3260e5429a4db511b3d083ad595749ee592fca18cf83b55acf6a4097f62b1bb1e1fe6d069f71a2338ad3263f97285ece7f166bc8520b9db3df17634ab97731c8e4d693c5be8ad4c457d9cee35a9ab959975cfa871ebf4a65ee4ff208449557a9eca15c50ac980b8cd5681b43a4ab2fe6b2384d1b7e9353f96534d6829d017e0a6ba3d195856e858844281aaa85ba9f7beb6c32420e7260a18416e5ca329f71fe9401efd3a27703cfad7e34dcb4d8acb13;

//        #10;  // Wait for the process to complete

//        // Display the input and reversed output as hexadecimal
//        $display("Input Data (Hex): %0h", in_data);
//        $display("Reversed Data (Hex): %0h", out_data);
        
//        $finish;
//    end
//endmodule




// ******************************************************************************************//




// ******************************************************************************************//




// ******************************************************************************************//