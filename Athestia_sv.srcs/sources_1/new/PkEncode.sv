//`timescale 1ns / 1ps

//import Dilithium_pkg::*;  // Import constants from the Dilithium package


////*****************************fsm optimize code (shifter and if combinational)..but floorplanning warning**************
//module PkEncode (
//    input logic clk, reset,
//    input logic [255:0] rho,
//    input logic [9:0] t1[7:0][255:0],
//    output logic [20735:0] pk,
//    output logic valid
//);
//    logic [2559:0] packed_out;  // Output from the SimpleBitPack instance
//    logic [20735:0] temp_pk;
//    logic [20735:0] next_temp_pk;
//    int i, next_i;
//    logic next_valid; // To handle valid signal combinatorially
//    enum {IDLE, PACK, CONCAT, DONE} state, next_state;

//    // Instantiate SimpleBitPack once
//    SimpleBitPack #(
//        .W_WIDTH(10)
//    ) pack_t1 (
//        .w(t1[i]),  // Sequential access based on index i
//        .z(packed_out)
//    );

//    // Combinational logic for FSM transitions and output computation
//    always_comb begin
//        next_i = i;  // Default to carrying over current index
//        next_temp_pk = temp_pk;  // Default to carrying over current temp_pk
//        next_valid = valid; // Default valid handling

//        case (state)
//            IDLE: begin
//                next_temp_pk = rho;
//                next_state = PACK;
//                next_valid = 0;
//            end
//            PACK: begin
//                if (i < 8) begin
//                    next_state = CONCAT;
//                    next_valid = 0;
//                end else begin
//                    next_state = DONE;
//                    next_valid = 1; // Prepare to set valid high if moving to DONE
//                end
//            end
//            CONCAT: begin
//                if (i < 8) begin
//                    // Compute position using shifts and addition to replace direct multiplication
//                    automatic int position = (i << 11) + (i << 9); // i * 2048 + i * 512 = i * 2560
////                    automatic int position = {i,11'b00000000000} + {i, 9'b000000000}; // i * 2048 + i * 512 = i * 2560
//                    next_temp_pk[256 + position +: 2560] = packed_out;
//                    next_i = i + 1;
////                    next_i = {i[31:1],1'b1};
//                    next_state = PACK;
//                    next_valid = 0;
//                end else begin
//                    next_state = DONE;
//                    next_valid = 1;
//                end
//            end
//            DONE: begin
//                next_state = IDLE;
//                next_valid = 0; // Reset valid after transitioning from DONE
//            end
//            default: begin
//                next_state = IDLE;
//                next_valid = 0; // Reset valid in any undefined state
//            end
//        endcase
//    end

//    // Sequential logic for state and output registration
//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            state <= IDLE;
//            i <= 0;
//            temp_pk <= 0;
//            valid <= 0;
//            pk <= 0;
//        end else begin
//            state <= next_state;
//            i <= next_i;
//            temp_pk <= next_temp_pk;
//            valid <= next_valid; // Assign valid based on combinational logic outcome
//            if (next_state == DONE) begin
//                pk <= next_temp_pk; // Set pk only when transitioning to DONE
//            end else begin
//                pk <= 0;
//            end
//        end
//    end
//endmodule





























//*****************************fsm optimize code (shifter)..but floorplanning warning**************
//module PkEncode (
//    input logic clk, reset,
//    input logic [255:0] rho,
//    input logic [9:0] t1[7:0][255:0],
//    output logic [20735:0] pk,
//    output logic valid
//);
//    logic [2559:0] packed_out;  // Output from the SimpleBitPack instance
//    logic [20735:0] temp_pk;
//    logic [20735:0] next_temp_pk;
//    int i, next_i;
//    enum {IDLE, PACK, CONCAT, DONE} state, next_state;

//    // Instantiate SimpleBitPack once
//    SimpleBitPack #(
//        .W_WIDTH(10)
//    ) pack_t1 (
//        .w(t1[i]),  // Sequential access based on index i
//        .z(packed_out)
//    );

//    // Combinational logic for FSM transitions and output computation
//    always_comb begin
//        next_i = i;  // Default to carrying over current index
//        next_temp_pk = temp_pk;  // Default to carrying over current temp_pk

//        case (state)
//            IDLE: begin
//                next_temp_pk = rho;
//                next_state = PACK;
//            end
//            PACK: begin
//                if (i < 8) begin
//                    next_state = CONCAT;
//                end else begin
//                    next_state = DONE;
//                end
//            end
//            CONCAT: begin
//                if (i < 8) begin
//                    // Compute position using shifts and addition to replace direct multiplication
//                    automatic int position = (i << 11) + (i << 9); // i * 2048 + i * 512 = i * 2560
//                    next_temp_pk[256 + position +: 2560] = packed_out; // Assign packed_out to the computed position
//                    next_i = i + 1;
//                    next_state = PACK;
//                end else begin
//                    next_state = DONE;
//                end
//            end
//            DONE: begin
//                next_state = IDLE;
//            end
//            default: begin
//                next_state = IDLE; // Reset to a known state
//            end
//        endcase
//    end

//    // Sequential logic for state and output registration
//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            state <= IDLE;
//            i <= 0;
//            temp_pk <= 0;
//            valid <= 0;
//        end else begin
//            state <= next_state;
//            i <= next_i;
//            temp_pk <= next_temp_pk;
//            if (state == DONE) begin
//                pk <= temp_pk;
//                valid <= 1;
//            end else begin
//                pk <= 0;
//                valid <= 0; // Ensure valid is only high when truly done
//            end
//        end
//    end
//endmodule




































//*****************************counter optimize code (shifters)..but floorplanning warning**************
//module PkEncode (
//    input logic clk, reset,
//    input logic [255:0] rho,
//    input logic [9:0] t1[7:0][255:0],
//    output logic [20735:0] pk,
//    output logic valid
//);
//    logic [2559:0] packed_out;  // Output from the SimpleBitPack instance
//    logic [20735:0] temp_pk;
//    int count = 0;  // Use a counter to track the packing index
//    logic pack_done;  // Signal to indicate packing is complete

//    // Instantiate SimpleBitPack once
//    SimpleBitPack #(.W_WIDTH(10)) pack_t1 (
//        .w(t1[count]),
//        .z(packed_out)
//    );

//    // Combinational logic to update pack_done
//    always_comb begin
//        pack_done = (count >= 8);
//    end

//    // Optimize state machine logic using counter
//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            count <= 0;
//            temp_pk <= 0;
//            valid <= 0;
//        end else if (!pack_done) begin
//            // Declare position at the beginning of the block
//            int position = (count << 11) + (count << 9); // count * 2048 + count * 512 = count * 2560

//            if (count == 0) begin
//                temp_pk <= {rho};  // Initialize temp_pk with rho
//            end
//            temp_pk[256 + position +: 2560] <= packed_out; // Assign packed_out to the computed position
//            count <= count + 1;
//        end else begin
//            pk <= temp_pk;
//            valid <= 1;
//            count <= 0;  // Reset the counter for next operation
//        end
//    end
//endmodule











//*****************************fsm, no logic in always_ff*************************
//module PkEncode (
//    input logic clk, reset,
//    input logic [255:0] rho,
//    input logic [9:0] t1[7:0][255:0],
//    output logic [20735:0] pk,
//    output logic valid
//);
//    logic [2559:0] packed_out;  // Output from the SimpleBitPack instance
//    logic [20735:0] temp_pk;
//    logic [20735:0] next_temp_pk;
//    int i, next_i;
//    enum {IDLE, PACK, CONCAT, DONE} state, next_state;

//    // Instantiate SimpleBitPack once
//    SimpleBitPack #(
//        .W_WIDTH(10)
//    ) pack_t1 (
//        .w(t1[i]),  // Sequential access based on index i
//        .z(packed_out)
//    );

//    // Combinational logic for FSM transitions and output computation
//    always_comb begin
////        next_state = state; // Default to carrying over current state
//        next_i = i;  // Default to carrying over current index
//        next_temp_pk = temp_pk;  // Default to carrying over current temp_pk

//        case (state)
//            IDLE: begin
//                next_temp_pk = rho;
//                next_state = PACK;
//            end
//            PACK: begin
//                if (i < 8) begin
//                    next_state = CONCAT;
//                end else begin
//                    next_state = DONE;
//                end
//            end
//            CONCAT: begin
//                if (i < 8) begin
//                    next_temp_pk[256 + i*2560 +: 2560] = packed_out;
//                    next_i = i + 1;
//                    next_state = PACK;
//                end else begin
//                    next_state = DONE;
//                end
//            end
//            DONE: begin
//                next_state = IDLE;
//            end
//            default: begin
//                next_state = IDLE; // Reset to a known state
//            end
//        endcase
//    end

//    // Sequential logic for state and output registration
//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            state <= IDLE;
//            i <= 0;
//            temp_pk <= 0;
//            valid <= 0;
//        end else begin
//            state <= next_state;
//            i <= next_i;
//            temp_pk <= next_temp_pk;
//            if (state == DONE) begin
//                pk <= temp_pk;
//                valid <= 1;
//            end else begin
//                pk <= 0;
//                valid <= 0; // Ensure valid is only high when truly done
//            end
//        end
//    end
//endmodule



























//*****************************counter..but floorplanning warning**************
//module PkEncode (
//    input logic clk, reset,
//    input logic [255:0] rho,
//    input logic [9:0] t1[7:0][255:0],
//    output logic [20735:0] pk,
//    output logic valid
//);
//    logic [2559:0] packed_out;  // Output from the SimpleBitPack instance
//    logic [20735:0] temp_pk;
//    int count = 0;  // Use a counter to track the packing index
//    logic pack_done;  // Signal to indicate packing is complete

//    // Instantiate SimpleBitPack once
//    SimpleBitPack #(
//        .W_WIDTH(10)
//    ) pack_t1 (
//        .w(t1[count]),          // Sequential access based on counter
//        .z(packed_out)
//    );

//    // Combinational logic to update pack_done
//    always_comb begin
//        pack_done = (count >= 8);
//    end

//    // State machine logic using counter
//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            count <= 0;
//            temp_pk <= 0;
//            valid <= 0;
//        end else begin
//            if (count == 0) begin
//                temp_pk <= {rho};  // Initialize temp_pk with rho and padding
//            end
//            if (!pack_done) begin
//                temp_pk[256 + count * 2560 +: 2560] <= packed_out;
//                count <= count + 1;
//            end else begin
//                pk <= temp_pk;
//                valid <= 1;
//                count <= 0;  // Reset the counter for next operation
//            end
//        end
//    end
//endmodule

































//****************************************** fsm ...but floorplanning warning***************************
//module PkEncode (
//    input logic clk, reset,
//    input logic [255:0] rho,
//    input logic [9:0] t1[7:0][255:0],
//    output logic [20735:0] pk,
//    output logic valid
//);
//    logic [2559:0] packed_out;  // Output from the SimpleBitPack instance
//    logic [20735:0] temp_pk;
//    int i = 0;
//    enum {IDLE, PACK, CONCAT, DONE} state;
//    // Instantiate SimpleBitPack once
//    SimpleBitPack #(
//        .W_WIDTH(10)
//    ) pack_t1 (
//        .w(t1[i]),              // Sequential access based on index i
//        .z(packed_out)
//    );
//    // State machine to manage packing and concatenation
//    always_ff @(posedge clk) begin
//        if (reset) begin
//            state <= IDLE;
//            i <= 0;
//            temp_pk <= 0;
//            valid <= 0;
//        end else begin
//            case (state)
//                IDLE: begin
//                    temp_pk <= rho;
//                    state <= PACK;
//                end
//                PACK: begin
//                    if (i < 8) begin
//                        state <= CONCAT;
//                    end else begin
//                        state <= DONE;
//                    end
//                end
//                CONCAT: begin
//                    if (i >= 8) begin
//                        state <= DONE;
//                    end else begin
//                        temp_pk[256 + i*2560 +: 2560] <= packed_out;
//                        i <= i + 1;
//                        state <= PACK;
//                    end
//                end
////                    temp_pk[256 + i*2560 +: 2560] <= packed_out;
////                    i <= i + 1;
////                    state <= (i < 7) ? PACK : DONE;
////                end
//                DONE: begin
//                    pk <= temp_pk;
//                    valid <= 1;
//                    state <= IDLE;
//                end
//            endcase
//        end
//    end
//endmodule
































//******************************************without fsm ...but floorplanning warning***************************
//module PkEncode (
//    input logic [255:0] rho,                              // 32 bytes input as bits
//    input logic [9:0] t1[7:0][255:0],                     // 8 polynomials of 256 coefficients (10 bits each)
//    output logic [20735:0] pk                             // Output public key, 2592 bytes (20736 bits)
//);
//    logic [2559:0] packed_out[7:0];  // Outputs from the SimpleBitPack instances
//    logic [20735: 0] temp_pk;               // Temporary PK construction
//    int offset;                    // Variable to manage the offset dynamically
//    // Instantiate SimpleBitPack for each polynomial
//    genvar i;
//    generate
//        for (i = 0; i < 8; i++) begin : pack_polynomials
//            SimpleBitPack #(
//                .W_WIDTH(10)
////                .B_WIDTH(10)
//            ) pack_t1 (
//                .w(t1[i]),                       // Input current polynomial
////                .b(10'b1111111111),                    // Constant value b = 1023
//                .z(packed_out[i])                // Packed output of 1 polynomial
//            );
//        end
//    endgenerate

//    // Combinational logic to concatenate packed outputs with rho
//    always_comb begin
//        temp_pk = rho;  // Start with rho
////        $display("Initial rho: %0h", rho);
//        offset = 256;  // Start offset after rho, right outside the loop to ensure it's reset each time
    
//        for (int j = 0; j < 8; j++) begin
////            $display("Packing t1[%0d]: %p", j, t1[j]);
////            $display("Output from SimpleBitPack for t1[%0d]: %0h", j, packed_out[j]);
//            temp_pk[offset +: 2560] = packed_out[j];  // Concatenate at the correct position
////            $display("Intermediate PK after adding t1[%0d]: %0h", j, temp_pk);
//            offset += 2560;  // Move the offset for the next polynomial
//        end
    
//        pk = temp_pk;  // Assign the concatenated result to pk
//        $display("Final PK: %0h", pk);
//    end
//endmodule


//        for (int j = 0; j < 8; j++) begin
////            $display("Packing t1[%0d]:", j);
//            for (int k = 0; k < 256; k++) begin
//                $display("poly_in[%0d] = %0d", k, t1[j][k]);
//            end
//            $display("Output from SimpleBitPack for t1[%0d]: %0h", j, packed_out[j]);
//            temp_pk[offset +: 2560] = packed_out[j];  // Concatenate at the correct position
////            $display("Intermediate PK after adding t1[%0d]: %0h", j, temp_pk);
//            offset += 2560;  // Move the offset for the next polynomial
//        end

    
//        pk = temp_pk;  // Assign the concatenated result to pk
////        $display("Final PK: %0h", pk);
//    end
//endmodule






















//module PkEncode (
//    input  logic [255:0] rho,                 // 32 bytes input, in bits is 256 bits
//    input  logic [9:0] t1[7:0][255:0],        // 8 polynomials of 256 coefficients (10 bits each)
//    output logic [20735:0] pk                 // Output is 2592 bytes, which equals 20736 bits
//);
//    // Local variables for internal use
//    logic [2559:0] packed_out[7:0]; // Each entry packs 256 coefficients from t1

//    // Combinational logic to pack each polynomial
//    genvar i, j;
//    generate
//        for (i = 0; i < 8; i++) begin : pack_polynomials
//            for (j = 0; j < 256; j++) begin : pack_coefficients
//                assign packed_out[i][(j*10)+:10] = t1[i][j];
//                assign packed_out[i][((255-j)*10)+:10] = t1[i][j];
//            end
//        end
//    endgenerate

//    // Concatenate all packed polynomials to rho
//    assign pk = {rho, packed_out[7], packed_out[6], packed_out[5], packed_out[4], packed_out[3], packed_out[2], packed_out[1], packed_out[0]};

//endmodule






















//module PkEncode (
//    input  logic [255:0] rho,                   // 32 bytes input..in bits is 256 bits
//    input  logic [9:0] t1[7:0][255:0],          // 8 polynomials of 256 coefficients (10 bits each)
//    output logic [2591 * 8 : 0] pk              // 2592 bytes output = 20736 bits
//);

//    // Intermediate variables
//    logic [9:0] poly_in[255:0];                 // Polynomial input (10 bits × 256 coefficients)
//    logic [2559:0] packed_out;                  // Packed polynomial output (10 bits × 256 coefficients)
//    logic [2591 * 8 : 0] temp_pk;               // Temporary PK construction

//    // Instantiate simpleBitPack once
//    SimpleBitPack #(
//        .W_WIDTH(10),                           // Number of coefficients
//        .B_WIDTH(10)                            // Bit-width of each coefficient
//    ) pack_t1 (
//        .w(poly_in),                            // Input polynomial coefficients
//        .b(10'd1023),                           // Constant value b
//        .z(packed_out)                          // Packed output
//    );

//    // Process to encode t1 into pk
//    always_comb begin
////        integer i;
//        integer i, j;

////        temp_pk = {rho, {20736-256{1'b0}}};     // Initialize PK with rho and zeros
//        temp_pk = '0;     // Initialize PK with rho and zeros
//        temp_pk = {rho};

//        $display("Initial PK with rho and zeros: %h", temp_pk); // Display initial value

//        for (i = 0; i < 8; i = i + 1) begin
//            // Reverse values from t1[i] into poly_in
//            for (j = 0; j < 256; j = j + 1) begin
//                poly_in[j] = t1[i][255 - j];
//            end

//            // Display reversed values for debugging
//            $display("Processing reversed polynomial t1[%0d]:", i);
            
//            for (j = 0; j < 256; j = j + 1) begin
//                $display("poly_in[%0d] = %0d", j, poly_in[j]);
//            end
            
//            // Call to SimpleBitPack is implicitly done when packed_out is updated
//            $display("Packed output for t1[%0d]: %h", i, packed_out); // Display packed output


//            temp_pk = {temp_pk, packed_out};    // Append packed polynomial to PK
////            $display("Updated PK after t1[%0d]: %h", i, temp_pk); // Display PK after appending
//        end
////        $display("Packed output for t1[%0d]: %h", i, packed_out); // Display packed output

//        pk = temp_pk;                           // Assign final PK
////        $display("Final PK: %h", pk);           // Display final PK
//    end
//endmodule


































//module PkEncode (
//    input logic [255:0] rho,             // 32 bytes = 256 bits
//    input logic [9:0] t1[7:0][255:0],// 8 polynomials, 256 coefficients, 10 bits each
//    output logic [2592*8-1:0] pk        // 2592 bytes = 20736 bits
//);

//    // Intermediate variables
//    logic [20480-1:0] t1_encoded;       // 20480 bits for t1 encoding (8 * 256 * 10)
//    logic [2559:0] packed_data;         // Temporary storage for packed polynomial (256 coefficients × 10 bits)
//    logic [9:0] b = 1023;               // Example intermediate value

//    // Declare temp_poly as a packed array, not unpacked
//    logic [9:0] temp_poly [255:0];      // Corrected: packed array of 256 elements, each 10 bits wide

//    // Index for sequential processing
//    integer i;

//    // Single instance of SimpleBitPack
//    SimpleBitPack #(
//        .W_WIDTH(10),               // Number of coefficients
//        .B_WIDTH(10)                // Bit-width of each coefficient
//    ) pack_t1 (
//        .w(temp_poly),              // Input polynomial coefficients (packed type)
//        .b(b),
//        .z(packed_data)             // Packed output
//    );

//    // Sequentially encode t1 using the single SimpleBitPack instance
//    always_comb begin
////        pk[0 +: 256] = rho;  // First 256 bits of z_bits are rho

//        // Initialize t1_encoded
//        t1_encoded = '0;

//        // Process each polynomial in sequence
//        for (i = 0; i < 8; i++) begin
//            // Assign the current polynomial to the temporary packed variable
//            temp_poly = t1[i];  // Correctly assign packed `t1[i]` to packed `temp_poly`

//            // Capture the packed output into t1_encoded
//            t1_encoded[i*2560 +: 2560] = packed_data;
//        end

//        // Combine rho and t1_encoded into pk
//        pk = {t1_encoded, rho};
////        pk = {t1_encoded};

//    end

//endmodule



