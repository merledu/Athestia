`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2024 12:58:22
// Design Name: 
// Module Name: Top_Power2round
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


module Top_SimpleBitPack #(
    parameter int W_WIDTH = 10  // Width of the coefficients in w
) (
    input logic clk,
    input logic rst,
    input logic btn,
    output logic led
);

    logic [W_WIDTH-1:0] w [255:0];   // Input array w of 256 elements
    logic [(256 * W_WIDTH) - 1:0] z; // Output bitstream array

    // Instantiate the SimpleBitPack module
    SimpleBitPack #(
        .W_WIDTH(W_WIDTH)
    ) u_simple_bit_pack (
        .w(w),
        .z(z)
    );

    // Known good output for comparison
    logic [(256 * W_WIDTH) - 1:0] known_good_output = 2560'h14f97a149bdd0a566850229dd3b7b8409236f98a12de53832f515b68d6d58f304bd4b2d32e298f1ea17774ab9523329241e4d195c1d13ef10504bbe533a73da83d653536f6ee758e2e80fe931862f0e7f7972afb2759716bfe2d9f6ceb478c4438365a98c4ff962e548a59752bf3577b53543a4741bd3a3d4b4cde0b26346cbd3a94f788f5ae3d32f4a73e6970035ea3260e5429a4db511b3d083ad595749ee592fca18cf83b55acf6a4097f62b1bb1e1fe6d069f71a2338ad3263f97285ece7f166bc8520b9db3df17634ab97731c8e4d693c5be8ad4c457d9cee35a9ab959975cfa871ebf4a65ee4ff208449557a9eca15c50ac980b8cd5681b43a4ab2fe6b2384d1b7e9353f96534d6829d017e0a6ba3d195856e858844281aaa85ba9f7beb6c32420e7260a18416e5ca329f71fe9401efd3a27703cfad7e34dcb4d8acb13;
//    logic [(256 * W_WIDTH) - 1:0] known_good_output = 2560'hC4EB23632DD35F8EB4F3DC289F4C7B503FADC4A728F9705861829C983890B0FADDEEA716EAA0690A212165B9614668F9AF8205E74A093594FE5D4FA46DD348E1ACBFAACE92D0A0755E3202B254257328A795E25611C813F7BA99FD07AA1F3E5D566AE6A68D73BF65155322B6F8F15A793721CCE5D2AD8FC5CF67682E14AF0599FFB3A165C8FCC92B4CE68BDC1A5B47F8786ECACFD825A933D568ED3E063F2A4BB952755F560EB426CD4436E6950839C9BA80D5C09A5CFD28CB8F56B23FDEA534EB2CD1C9B823352D8F74E06D1D0E8D5ED55DFCD4A65E299518BFE713A6196E0D10E32D1B3A7D8B6FFC5965C9EBE5CBDE39CBC61A4C3FBA0389D6BB9BDD4D940F76A9CCCEF952E143C44F8745734679090CA48CE552ADDE85C7A63B8B4C2CAF5C123CB56356D945CBCE07944B629BE48D02EE0ED7748A1419A2977426E85E5C53;    
   
    // Initialize the input array with the provided values
    initial begin
        // Populate the array with the provided values
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

        // Continue initializing the rest of the array as necessary
        // ... (initialize all values as you provided)
    end

    // LED and button interaction
    always @(posedge clk) begin
        if (rst) begin
            led <= 1'b0;  // Reset LED state
        end else if (btn) begin
            // Check the output bitstream against the known good value
            if (z == known_good_output) begin
                led <= 1'b1;  // Set LED if outputs match the known good value
            end else begin
                led <= 1'b0;  // Reset LED if not
            end
        end
    end

endmodule
