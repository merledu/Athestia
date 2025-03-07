`timescale 1ns / 1ps

module SimpleBitPack #(
    parameter int W_WIDTH = 10  // Width of the coefficients in w
//    parameter int B_WIDTH = 8   // Width of the integer b
)(
    input logic [W_WIDTH-1:0] w [255:0],  // Input array w of 256 elements
//    input logic [B_WIDTH-1:0] b,          // Input integer b
    output logic [(256 * W_WIDTH) - 1:0] z  // Output packed bitstream z
);
    logic [(256 * W_WIDTH) - 1:0] z_bits;  // Final packed bits array

    always_comb begin
        z_bits = '0;  // Initialize the final bit array to zero
        
//        for (int j = 0; j < 256; j++) begin
//            $display("w[%0d] = %0d", j, w[j]);
//        end

        for (int j = 0; j < 256; j++) begin
//           z_bits[(j * W_WIDTH) +: W_WIDTH] = w[j];
           z_bits[(j * W_WIDTH) +: W_WIDTH] = w[255 - j];
        end
    end
    assign z = z_bits;
    
endmodule



































//         Pack bits from each element in w into z_bits
//        z_bits[0 +: (W_WIDTH * 256)] = {w[255], w[254], w[253], w[252], w[251], w[250], w[249], w[248], w[247], w[246], 
//                                        w[245], w[244], w[243], w[242], w[241], w[240], w[239], w[238], w[237], w[236], 
//                                        w[235], w[234], w[233], w[232], w[231], w[230], w[229], w[228], w[227], w[226], 
//                                        w[225], w[224], w[223], w[222], w[221], w[220], w[219], w[218], w[217], w[216], 
//                                        w[215], w[214], w[213], w[212], w[211], w[210], w[209], w[208], w[207], w[206], 
//                                        w[205], w[204], w[203], w[202], w[201], w[200], w[199], w[198], w[197], w[196], 
//                                        w[195], w[194], w[193], w[192], w[191], w[190], w[189], w[188], w[187], w[186], 
//                                        w[185], w[184], w[183], w[182], w[181], w[180], w[179], w[178], w[177], w[176], 
//                                        w[175], w[174], w[173], w[172], w[171], w[170], w[169], w[168], w[167], w[166], 
//                                        w[165], w[164], w[163], w[162], w[161], w[160], w[159], w[158], w[157], w[156], 
//                                        w[155], w[154], w[153], w[152], w[151], w[150], w[149], w[148], w[147], w[146], 
//                                        w[145], w[144], w[143], w[142], w[141], w[140], w[139], w[138], w[137], w[136], 
//                                        w[135], w[134], w[133], w[132], w[131], w[130], w[129], w[128], w[127], w[126], 
//                                        w[125], w[124], w[123], w[122], w[121], w[120], w[119], w[118], w[117], w[116], 
//                                        w[115], w[114], w[113], w[112], w[111], w[110], w[109], w[108], w[107], w[106], 
//                                        w[105], w[104], w[103], w[102], w[101], w[100], w[99], w[98], w[97], w[96], 
//                                        w[95], w[94], w[93], w[92], w[91], w[90], w[89], w[88], w[87], w[86], 
//                                        w[85], w[84], w[83], w[82], w[81], w[80], w[79], w[78], w[77], w[76], 
//                                        w[75], w[74], w[73], w[72], w[71], w[70], w[69], w[68], w[67], w[66], 
//                                        w[65], w[64], w[63], w[62], w[61], w[60], w[59], w[58], w[57], w[56], 
//                                        w[55], w[54], w[53], w[52], w[51], w[50], w[49], w[48], w[47], w[46], 
//                                        w[45], w[44], w[43], w[42], w[41], w[40], w[39], w[38], w[37], w[36], 
//                                        w[35], w[34], w[33], w[32], w[31], w[30], w[29], w[28], w[27], w[26], 
//                                        w[25], w[24], w[23], w[22], w[21], w[20], w[19], w[18], w[17], w[16], 
//                                        w[15], w[14], w[13], w[12], w[11], w[10], w[9], w[8], w[7], w[6], 
//                                        w[5], w[4], w[3], w[2], w[1], w[0]};
//    end
    
//    assign z = z_bits;
    
//endmodule