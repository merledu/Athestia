`timescale 1ns / 1ps


module NTT (
    input  logic         clk,
    input  logic         rst,
    input  logic         start,
    input  logic signed [31:0]  w_in [0:255],
    output logic signed [31:0]  w_out [0:255],
    output logic         done
);



function automatic logic signed [63:0] modmul(
    input logic signed [63:0] a,
    input logic signed [63:0] b,
    input logic signed [63:0] q
);
    logic signed [127:0] prod;
    prod = a * b;
    modmul = ((prod % q)+q)%q;
endfunction

function automatic logic signed [63:0] modadd(
    input logic signed [63:0] a,
    input logic signed [63:0] b,
    input logic signed [63:0] q
);
    logic signed [63:0] res;
    res = a + b;
    if (res >= q)
        modadd = res - q;
    else
        modadd = res;
endfunction

function automatic logic signed [63:0] modsub(
    input logic signed [63:0] a,
    input logic signed [63:0] b,
    input logic signed [63:0] q
);
    logic signed [63:0] res;
    res = a - b;
    if (res < 0)
        modsub = res + q;
    else
        modsub = res;
endfunction





    typedef enum logic [5:0] {
        IDLE, COPY, OUTER_LOOP_INIT, MIDDLE_LOOP_INIT, INNER_LOOP, CALC_UPDATE, UPDATE_INDEX, OUTER_LOOP_UPDATE, DONE
    } state_t;

    state_t state;
//    logic [15:0]  zetas [1:255];
    logic [63:0] j, start_idx, m;
    logic [63:0] len,z;
    logic [63:0] t ,check;
    logic signed [63:0]  w [0:255];
    logic [63:0] Q = 8380417;
    
    logic signed [63:0] zetas [0:255] = '{
            0, 4808194, 3765607, 3761513, 5178923, 5496691, 5234739, 5178987,
            7778734, 3542485, 2682288, 2129892, 3764867, 7375178, 557458, 7159240,
            5010068, 4317364, 2663378, 6705802, 4855975, 7946292, 676590, 7044481,
            5152541, 1714295, 2453983, 1460718, 7737789, 4795319, 2815639, 2283733,
            3602218, 3182878, 2740543, 4793971, 5269599, 2101410, 3704823, 1159875,
            394148, 928749, 1095468, 4874037, 2071829, 4361428, 3241972, 2156050,
            3415069, 1759347, 7562881, 4805951, 3756790, 6444618, 6663429, 4430364,
            5483103, 3192354, 556856, 3870317, 2917338, 1853806, 3345963, 1858416,
            3073009, 1277625, 5744944, 3852015, 4183372, 5157610, 5258977, 8106357,
            2508980, 2028118, 1937570, 4564692, 2811291, 5396636, 7270901, 4158088,
            1528066, 482649, 1148858, 5418153, 7814814, 169688, 2462444, 5046034,
            4213992, 4892034, 1987814, 5183169, 1736313, 235407, 5130263, 3258457,
            5801164, 1787943, 5989328, 6125690, 3482206, 4197502, 7080401, 6018354,
            7062739, 2461387, 3035980, 621164, 3901472, 7153756, 2925816, 3374250,
            1356448, 5604662, 2683270, 5601629, 4912752, 2312838, 7727142, 7921254,
            348812, 8052569, 1011223, 6026202, 4561790, 6458164, 6143691, 1744507,
            1753, 6444997, 5720892, 6924527, 2660408, 6600190, 8321269, 2772600,
            1182243, 87208, 636927, 4415111, 4423672, 6084020, 5095502, 4663471,
            8352605, 822541, 1009365, 5926272, 6400920, 1596822, 4423473, 4620952,
            6695264, 4969849, 2678278, 4611469, 4829411, 635956, 8129971, 5925040,
            4234153, 6607829, 2192938, 6653329, 2387513, 4768667, 8111961, 5199961,
            3747250, 2296099, 1239911, 4541938, 3195676, 2642980, 1254190, 8368000,
            2998219, 141835, 8291116, 2513018, 7025525, 613238, 7070156, 6161950,
            7921677, 6458423, 4040196, 4908348, 2039144, 6500539, 7561656, 6201452,
            6757063, 2105286, 6006015, 6346610, 586241, 7200804, 527981, 5637006,
            6903432, 1994046, 2491325, 6987258, 507927, 7192532, 7655613, 6545891,
            5346675, 8041997, 2647994, 3009748, 5767564, 4148469, 749577, 4357667,
            3980599, 2569011, 6764887, 1723229, 1665318, 2028038, 1163598, 5011144,
            3994671, 8368538, 7009900, 3020393, 3363542, 214880, 545376, 7609976,
            3105558, 7277073, 508145, 7826699, 860144, 3430436, 140244, 6866265,
            6195333, 3123762, 2358373, 6187330, 5365997, 6663603, 2926054, 7987710,
            8077412, 3531229, 4405932, 4606686, 1900052, 7598542, 1054478, 7648983
        };


    // FSM Control Logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state      <= IDLE;
            len        <= 63'd128;
            m          <= 63'd0;
            j          <= 63'd0;
            start_idx  <= 63'd0;
            done       <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        done  <= 1'b0;
//                        for (int i = 0; i < 256; i++) begin
//                            w[i] = w_in[i];
//                        end
                        len        <= 63'd128;
                        m          <= 63'd0;
                        start_idx  <= 63'd0;
                        state      <= OUTER_LOOP_INIT;
                    end
                end

                OUTER_LOOP_INIT: begin
                    if (len >= 1)
                        state <= MIDDLE_LOOP_INIT;
                    else
                        state <= DONE;
                end

                MIDDLE_LOOP_INIT: begin
                    if (start_idx < 256) begin
                        m      <= m + 1;
                        z      <= zetas[m+1]; // prefetch z
                        j      <= start_idx;
                        state  <= INNER_LOOP;
                    end else begin
                        len        <= len / 2;
                        start_idx  <= 63'd0;
                        state      <= OUTER_LOOP_INIT;
                    end
                end

//                INNER_LOOP: begin
//                    if (j < start_idx + len) begin
////                        // Compute t = (z * w[j + len]) % q
////                    t = w[128];//(z * w[j+len])%Q;
                    
////                    // w[j + len] = (w[j] - t) mod q
////                     w[j + len] <= (w[j] - t) % Q;
                    
////                    // w[j] = (w[j] + t) % q
////                    w[j] <= (w[j] + t) % Q;

//                        j <= j + 1;
//                        state <= INNER_LOOP;
                        
//                    end else begin
//                        start_idx <= start_idx + (len *2); // start += 2*len
//                        state     <= MIDDLE_LOOP_INIT;
//                    end
//                end

                    INNER_LOOP: begin
                    if (j < start_idx + len) begin
                        t = modmul(z, w[j + len], Q);
                     

                        w[j + len] <= modsub(w[j], t, Q);
                        w[j]       <= modadd(w[j], t, Q);

                        j <= j + 1;
                        state <= INNER_LOOP;
                    end else begin
                        start_idx <= start_idx + (len * 2); // start += 2*len
                        state     <= MIDDLE_LOOP_INIT;
                    end
                end

                DONE: begin
                    done <= 1'b1;
                    for (int i = 0; i < 256; i++) begin
                        w_out[i] = w[i];
                    end
//                    state <= DONE; // stay here
                end
            endcase
        end
    end

//    // Modular arithmetic functions
//    function automatic logic [15:0] mod_q_add(input logic [15:0] a, b);
//        logic [16:0] tmp;
//        tmp = a + b;
//        if (tmp >= 8380417)
//            mod_q_add = tmp - 8380417;
//        else
//            mod_q_add = tmp;
//    endfunction

//    function automatic logic [15:0] mod_q_sub(input logic [15:0] a, b);
//        logic signed [16:0] tmp;
//        tmp = a - b;
//        if (tmp < 0)
//            mod_q_sub = tmp + 8380417;
//        else
//            mod_q_sub = tmp;
//    endfunction

//    function automatic logic [15:0] mod_q_mul(input logic [15:0] a, b);
//        logic [31:0] tmp;
//        tmp = a * b;
//        mod_q_mul = tmp % 8380417;
//    endfunction

always_comb begin

if (state == IDLE) begin
        for (int i = 0; i < 256; i++) begin
            w[i] = w_in[i]; // Blocking assignment
        end
    end
//    if (INNER_LOOP==state) begin                     // Compute t = (z * w[j + len]) % q
//        if (len+j <256) begin
//            check = w[j+len];
//            t = ((z * w[j+len])%Q);
            
//            // w[j + len] = (w[j] - t) mod q
//            w[j + len] = (((w[j]) - t)%Q);
            
//            // w[j] = (w[j] + t) % q
//            w[j] = (((w[j]) + t)%Q);
//        end
//    end

end
endmodule
