import Dilithium_pkg::*;

module sigEncode #( 
    parameter int L = 7,  // Number of polynomials in z
    parameter int K = 8,  // Number of polynomials in h
    parameter int W = 75  // HintBitPack parameter
)(
    input logic clk, rst, start,
    input logic [511:0] c_h, // 64-byte (512-bit) input
    input logic signed [31:0] z[L-1:0][255:0], // 7 polynomials with 256 coefficients
    input logic [255:0] h[K-1:0], // 8 polynomials with 256 coefficients (binary)
    output logic [8*4627-1:0] sigma, // Output signature (4627 bytes)
    output logic done
);

logic [7:0] hintbitpack_output[W + K - 1:0]; // HintBitPack outputs
//logic [(W+K)*8-1:0] hint_contiguous;

localparam int b_len        = $clog2(gamma1 - 1 + gamma1) - 1; // For gamma1=524288, b_len = 19.
localparam int BP_OUT_BITS  = (b_len + 1) * 256; // 20 * 256 = 5120 bits per BitPack output.
localparam int SIG_WIDTH    = ((W+K)*8) + (L*BP_OUT_BITS) + 512;
localparam int HINT_OUT_WIDTH = (W + K) * 8;        // (75+8)=83 bytes * 8 = 664 bits.

logic [BP_OUT_BITS-1:0] bp_out [L-1:0];  // BitPack outputs
logic [BP_OUT_BITS*L-1:0] full_bp_string; 
logic [BP_OUT_BITS*L-1:0] reversed_bp_string; 
logic [BP_OUT_BITS*L-1:0] swap_bp_string; 

// Instantiate BitPack modules
generate
    genvar i;
    for (i = 0; i < L; i++) begin : bitpack_inst
        BitPack #(.a(gamma1 - 1), .b(gamma1)) bitpack_inst (
            .w(z[i]),
            .outt(bp_out[i]),
            .done()
        );
    end
endgenerate

// Instantiate Swap20Bits module to swap bits after reversing
Swap20Bits #(.WIDTH(BP_OUT_BITS*L)) sw (
    .in(reversed_bp_string),
    .out(swap_bp_string)
);

// Instantiate HintBitPack module
HintBitPack #(.K(K), .W(W)) hintbitpack_inst (
    .clk(clk),
    .rst(rst),
    .startpin(start),
    .h(h),
    .endpin(done),
    .y(hintbitpack_output)
);

// -------------------------------------------------------------------------
// Pack reversed HintBitPack output array into a contiguous vector.
    //-------------------------------------------------------------------------
// Flatten the HintBitPack output array into a single vector.
// The expected order is: the most significant byte is hintbitpack_output[0],
// down to hintbitpack_output[W+K-1] as the least significant.
logic [HINT_OUT_WIDTH-1:0] hint_flat;
integer x;
    always_comb begin
    for (x = 0; x < (W + K); x++) begin
        hint_flat[(x*8) +: 8] = hintbitpack_output[x];
    end
end
// -------------------------------------------------------------------------
// Concatenate all BitPack outputs into full_bp_string.
integer j;
always_comb begin : concat_bitpack
    full_bp_string = '0;
    for (j = 0; j < L; j++) begin
        full_bp_string = { full_bp_string, bp_out[j] };
    end
end

// -------------------------------------------------------------------------
// Reverse full_bp_string by bytes.
integer k;
always_comb begin : reverse_bitpack
    for (k = 0; k < (BP_OUT_BITS*L)/8; k++) begin
        reversed_bp_string[k*8 +: 8] = full_bp_string[(BP_OUT_BITS*L - (k+1)*8) +: 8];
    end
end

// -------------------------------------------------------------------------
// Final concatenation: Build sigma as { hint, BitPack, c_h }
always_comb begin
    sigma = { hint_flat, swap_bp_string, c_h };
end

endmodule

























//gpt4 signencode analysis

//`timescale 1ns/1ps
//import Dilithium_pkg::*;

//// (Optional) Byte-reversal functions (not used in the final version)
//// If needed, you can keep these for debugging, but they are not called below.
///*
//function automatic logic [663:0] reverse_664b(
//    input logic [663:0] in_data
//);
//    localparam int NUM_BYTES = 664 / 8;
//    logic [663:0] out_data;
//    integer i;
//    begin
//        for (i = 0; i < NUM_BYTES; i++) begin
//            out_data[(NUM_BYTES-1-i)*8 +: 8] = in_data[i*8 +: 8];
//        end
//        return out_data;
//    end
//endfunction

//function automatic logic [5119:0] reverse_5120b(
//    input logic [5119:0] in_data
//);
//    localparam int NUM_BYTES = 5120 / 8;
//    logic [5119:0] out_data;
//    integer i;
//    begin
//        for (i = 0; i < NUM_BYTES; i++) begin
//            out_data[(NUM_BYTES-1-i)*8 +: 8] = in_data[i*8 +: 8];
//        end
//        return out_data;
//    end
//endfunction
//*/

//module SigEncode(
//    input  logic                clk,
//    input  logic                rst,
//    input  logic                start,
//    input  logic [511:0]        c_h,      // 64 bytes = 512 bits
//    // z: vector of l (7) polynomials; each polynomial has 256 signed 32-bit coefficients.
//    input  logic signed [31:0]  z [l-1:0][255:0],
//    // h_in: vector of k (8) polynomials; each polynomial is given as 256 1-bit values.
//    input  logic                h_in [k-1:0][255:0],
//    output logic                done,
//    // Final signature output as a contiguous byte string (4627 bytes = 37016 bits)
//    output logic [37016-1:0]    sigma
//);

//    //-------------------------------------------------------------------------
//    // FSM states
//    //-------------------------------------------------------------------------
//    typedef enum logic [2:0] {
//        IDLE, 
//        PROCESS_BITPACK, 
//        START_HINT, 
//        WAIT_HINT, 
//        CONCATENATE, 
//        DONE_STATE
//    } state_t;
//    state_t state;

//    // hint_start is driven as a continuous signal in the START_HINT state.
//    logic hint_start;
//    assign hint_start = (state == START_HINT);

//    //-------------------------------------------------------------------------
//    // Derived local parameters (using package parameters)
//    //-------------------------------------------------------------------------
//    localparam int C_H_BYTES    = lambda / 4;        // For lambda=256, 64 bytes.
//    localparam int b_len        = $clog2(gamma1 - 1 + gamma1) - 1; // For gamma1=524288, b_len = 19.
//    localparam int BP_OUT_BITS  = (b_len + 1) * 256; // 20 * 256 = 5120 bits per BitPack output.
//    localparam int BP_OUT_BYTES = BP_OUT_BITS / 8;     // = 640 bytes.
//    localparam int HINT_BYTES   = omega + k;         // = 75 + 8 = 83 bytes.
//    localparam int SIG_SIZE_BYTES = C_H_BYTES + l * BP_OUT_BYTES + HINT_BYTES; // = 4627 bytes.

//    //-------------------------------------------------------------------------
//    // Instantiate BitPack submodules for each polynomial in z.
//    // Each BitPack instance uses a = gamma1 - 1 and b = gamma1.
//    //-------------------------------------------------------------------------
//    logic [BP_OUT_BITS-1:0] bp_out [l-1:0];
//    logic                   bp_done [l-1:0]; // Not used for FSM control.

//    genvar i;
//    generate
//        for (i = 0; i < l; i = i + 1) begin : BITPACK_INST
//            BitPack #(
//                .a(gamma1 - 1),
//                .b(gamma1),
//                .b_len(b_len)
//            ) bp_inst (
//                .w(z[i]),
//                .outt(bp_out[i]),
//                .done(bp_done[i])
//            );
//        end
//    endgenerate

//    //-------------------------------------------------------------------------
//    // Pack the h_in input.
//    // The HintBitPack module expects each polynomial as a 256-bit word.
//    //-------------------------------------------------------------------------
//    logic [255:0] h_packed [k-1:0];
//    integer m, n;
//    always_comb begin
//        for (m = 0; m < k; m = m + 1) begin
//            h_packed[m] = '0;
//            for (n = 0; n < 256; n = n + 1) begin
//                h_packed[m][n] = h_in[m][n];
//            end
//        end
//    end

//    //-------------------------------------------------------------------------
//    // Instantiate HintBitPack module.
//    // It produces an output array of HINT_BYTES (83) bytes.
//    //-------------------------------------------------------------------------
//    logic                hint_end;
//    logic [7:0]          hint_out [HINT_BYTES-1: 0];

//    HintBitPack #(
//        .K(k),
//        .W(omega),
//        .COEFF_WIDTH(256)
//    ) hint_inst (
//        .clk(clk),
//        .rst(rst),
//        .startpin(hint_start),
//        .endpin(hint_end),
//        .h(h_packed),
//        .y(hint_out)
//    );

//    //-------------------------------------------------------------------------
//    // Flatten the hint_out array into a contiguous vector.
//    //-------------------------------------------------------------------------
//    logic [HINT_BYTES*8-1:0] hint_flat;
//    integer j;
//    always_comb begin
//        for (j = 0; j < HINT_BYTES; j = j + 1) begin
//            hint_flat[j*8 +: 8] = hint_out[j];
//        end
//    end

//    //-------------------------------------------------------------------------
//    // sigma_reg will hold the assembled signature.
//    //-------------------------------------------------------------------------
//    logic [37016-1:0] sigma_reg;

//    //-------------------------------------------------------------------------
//    // FSM: The final signature is built with the following order:
//    //   [MSB] hintbitpack output (83 bytes) || bitpack outputs (7×640 bytes, ordered so that
//    //   the first polynomial's BitPack output is at the MSB end) || c_h (64 bytes) [LSB].
//    // Note: In this updated version we do not reverse any submodule outputs.
//    //-------------------------------------------------------------------------
//    always_ff @(posedge clk or posedge rst) begin
//        if (rst) begin
//            state     <= IDLE;
//            sigma_reg <= '0;
//            done      <= 0;
//            sigma     <= '0;
//        end else begin
//            case (state)
//                IDLE: begin
//                    done <= 0;
//                    if (start)
//                        state <= PROCESS_BITPACK;
//                    else
//                        state <= IDLE;
//                end

//                PROCESS_BITPACK: begin
//                    // BitPack outputs are combinational.
//                    done  <= 0;
//                    state <= START_HINT;
//                end

//                START_HINT: begin
//                    done  <= 0;
//                    state <= WAIT_HINT;
//                end

//                WAIT_HINT: begin
//                    done <= 0;
//                    if (hint_end)
//                        state <= CONCATENATE;
//                    else
//                        state <= WAIT_HINT;
//                end

//                CONCATENATE: begin
//                    // Concatenate in order: hint_flat || bp_out[6] ... bp_out[0] || c_h.
//                    sigma_reg <= { 
//                        hint_flat,                           // 83 bytes from HintBitPack (MSB)
//                        bp_out[6], bp_out[5], bp_out[4], 
//                        bp_out[3], bp_out[2], bp_out[1], bp_out[0], // 7×640 bytes from BitPack modules
//                        c_h                                  // 64 bytes (LSB)
//                    };
//                    done  <= 0;
//                    state <= DONE_STATE;
//                end

//                DONE_STATE: begin
//                    sigma <= sigma_reg;
//                    done  <= 1;
//                    // Remain in DONE_STATE until reset.
//                end

//                default: begin
//                    state <= IDLE;
//                    done  <= 0;
//                end
//            endcase
//        end
//    end

//endmodule















//import Dilithium_pkg::*;

//module signEncode #(
//    parameter int L = 7,        // Number of polynomials in z
//    parameter int K = 8,        // Number of polynomials in h
//    parameter int W = 75,       // HintBitPack parameter
//    parameter int GAMMA1 = 524288, // Dilithium parameter
//    parameter int COEFF_WIDTH = 256 // Coefficients width
//) (
//    input  logic clk,
//    input  logic rst,
//    input  logic startpin,
//    output logic donepin,
//    input  logic [511:0] c_h,             // Input signature (64 bytes)
//    input  logic signed [31:0] z[L-1:0][COEFF_WIDTH-1:0], // Vector of L polynomials (z)
//    input  logic [255:0] h[K-1:0],        // Hint vector of K polynomials (h)
//    output logic [4627 * 8 - 1:0] sigma_out // Output signature (4627 bytes)
//);

//    // Internal signals for z and h processed outputs
//    logic [(COEFF_WIDTH * L * ($clog2(GAMMA1+GAMMA1)) - 1):0] z_encoded; // Encoded z
//    logic [L-1:0] z_done_array; // Track done signals for each BitPack instance
//    logic z_done; // Final done signal for z processing

//    logic [7:0] h_encoded[W + K - 1:0];                                // Encoded h
//    logic [((W + K) * 8) - 1:0] h_flattened;                          // Flattened h_encoded
//    logic h_done;


//    logic [4627 * 8 - 1:0] temp_sigma;

//    // *BitPack Instances for z*
//    generate
//        genvar i;
//        for (i = 0; i < L; i++) begin : BitPackInstances
//            BitPack #(
//                .a(GAMMA1-1),
//                .b(GAMMA1),
//                .b_len($clog2(GAMMA1+GAMMA1)-1)
//            ) BitPack_u (
//                .w(z[i]),
//                .outt(z_encoded[(i * (COEFF_WIDTH * $clog2(GAMMA1+GAMMA1))) +: ($clog2(GAMMA1+GAMMA1))]),
//                .done(z_done_array[i]) // Each instance writes to its own done signal
//            );
//        end
//    endgenerate

//    // Combine z_done_array into z_done
//    assign z_done = &z_done_array;

//    // *Handling h input discrepancy for HintBitPack*
//    logic [255:0] h_formatted[K-1:0];
//    always_comb begin
//        for (int i = 0; i < K; i++) begin
//            h_formatted[i] = h[i]; // Direct mapping since h matches required format
//        end
//    end
    
//    always_comb begin
//        for (int k = 0; k < (W + K); k++) begin
//            h_flattened[(k * 8) +: 8] = h_encoded[W+K-1-k]; // Ensure correct byte mapping
//            $display("DEBUG: h_flattened[%0d] = %h", k, h_flattened[(k * 8) +: 8]); // Debug each value
//        end
//    end
//    // *HintBitPack Instance*
//    HintBitPack #(
//        .K(K),
//        .W(W),
//        .COEFF_WIDTH(COEFF_WIDTH)
//    ) HintBitPack_u (
//        .clk(clk),
//        .rst(rst),
//        .startpin(startpin),
//        .h(h_formatted),
//        .y(h_encoded),
//        .endpin(h_done)
//    );

//   logic signed [31:0] temp_z [L-1:0][COEFF_WIDTH-1:0]; // Vector of L polynomials (z)

//    always_comb begin
//        for (int i = 0; i < COEFF_WIDTH; i++) begin
//            temp_z[i] = z[i]; // Assign z[i] into a properly recognized integer
            
//            z_encoded[(i * $clog2(GAMMA1+GAMMA1)) +: $clog2(GAMMA1+GAMMA1)] = GAMMA1 - temp_z;
//            $display("DEBUG: Fixed z_encoded[%0d] = %h", i, z_encoded[(i * $clog2(GAMMA1+GAMMA1)) +: $clog2(GAMMA1+GAMMA1)]);
//        end
//    end
        
//    // *Final concatenation and sigma creation*
//    always_ff @(posedge clk or posedge rst) begin
//        if (rst) begin
//            sigma_out <= 0;
//            donepin <= 0;
//        end else if (startpin) begin
//            if (z_done && h_done) begin
//////                $display("DEBUG: z_encoded = %h", z_encoded);
//////                $display("DEBUG: h_flattened = %h", h_flattened);
//////                $display("DEBUG: c_h = %h", c_h);
////    // Debugging individual components before final concatenation
////                $display("DEBUG: Before concat -> c_h: %h, h_flattened: %h, z_encoded: %h", c_h, h_flattened, z_encoded);
////                $display("DEBUG: Before concat -> c_h: %h, h_flattened: %h, z_encoded: %h");                sigma_out <= {h_flattened, z_encoded, c_h};


////// Individual Size Debugging
////                $display("DEBUG: Widths -> c_h: %0d, z_encoded: %0d, h_flattened: %0d", $bits(c_h), $bits(z_encoded), $bits(h_flattened));
////                $display("DEBUG: Before concat -> c_h: %h", c_h);
////                $display("DEBUG: Before concat -> h_flattened: %h", h_flattened);
////                $display("DEBUG: Before concat -> z_encoded: %h", z_encoded);
//                // Flatten Before Printing
//                temp_sigma = {h_flattened, z_encoded, c_h};
////                $display("DEBUG: Sigma Output = %h", temp_sigma);
    
//                // Assign Corrected Concatenation
//                sigma_out <= temp_sigma;

////                sigma_out <= {h_flattened, c_h, z_encoded};
//                donepin <= 1;
//            end
//        end else begin
//            donepin <= 0;
//        end
//    end
//endmodule






























//`timescale 1ns/1ps
//import Dilithium_pkg::*;

//module signEncode (
//    input  logic             clk,
//    input  logic             rst,
//    input  logic             start,
//    output logic             done,
//    input  logic [511:0]     c_h,     // 64 bytes
//    input  logic signed [31:0] z [l-1:0][255:0],
//    input  logic [255:0]     h [k-1:0],
//    output logic [37015:0]   sig      // 4627 bytes = 37016 bits
//);

//  localparam int b_len       = $clog2(524287 + 524288) - 1; 
//  localparam int BP_OUT_BITS = (b_len + 1)*256;  // e.g. 20*256 = 5120 bits
//  localparam int BP_BYTES    = BP_OUT_BITS / 8;     // e.g. 640 bytes
//  localparam int CH_BYTES    = 64;
//  localparam int HINT_BYTES  = 83;
//  localparam int TOTAL_BYTES = CH_BYTES + (l * BP_BYTES) + HINT_BYTES; // 4627

//  logic [$clog2(TOTAL_BYTES+1)-1:0] byte_counter;
//  logic processing;
//  reg [7:0] sig_array [0:TOTAL_BYTES-1];

//  // For debugging: track poly_sel and bp_index
//  wire [$clog2(l)-1:0] poly_sel = (byte_counter >= CH_BYTES && byte_counter < (CH_BYTES + l * BP_BYTES))
//                                   ? ((byte_counter - CH_BYTES) / BP_BYTES)
//                                   : 0;
//  wire [9:0]           bp_index = (byte_counter >= CH_BYTES && byte_counter < (CH_BYTES + l * BP_BYTES))
//                                   ? ((byte_counter - CH_BYTES) % BP_BYTES)
//                                   : 0;

//  // BitPack instance
//  wire [BP_OUT_BITS-1:0] bitpack_output;
//  BitPack #(
//    .a(gamma1 - 1),
//    .b(gamma1),
//    .b_len(b_len)
//  ) bp_inst (
//    .w(z[poly_sel]),
//    .outt(bitpack_output),
//    .done()
//  );

//  // HintBitPack instance
//  wire hint_start = (byte_counter == CH_BYTES + l * BP_BYTES);
//  wire hint_end;
//  wire [7:0] hint_out [0:HINT_BYTES-1];

//  HintBitPack #(
//    .K(k),
//    .W(75),
//    .COEFF_WIDTH(256)
//  ) hint_inst (
//    .clk(clk),
//    .rst(rst),
//    .startpin(hint_start),
//    .h(h),
//    .endpin(hint_end),
//    .y(hint_out)
//  );

//  // Main logic: update counters and drive processing
//  always_ff @(posedge clk or posedge rst) begin
//    if (rst) begin
//      processing   <= 1'b0;
//      done         <= 1'b0;
//      byte_counter <= 0;
//      for (int i = 0; i < TOTAL_BYTES; i++) begin
//        sig_array[i] <= 8'h00;
//      end
//    end
//    else begin
//      if (byte_counter == TOTAL_BYTES)
//        done <= 1'b1;
//      else
//        done <= 1'b0;

//      if (start)
//        processing <= 1'b1;
//      else if (byte_counter == TOTAL_BYTES)
//        processing <= 1'b0;

//      if (processing && !done) begin
//        if (byte_counter == (CH_BYTES + l * BP_BYTES)) begin
//          if (hint_end)
//            byte_counter <= byte_counter + 1;
//          else
//            byte_counter <= byte_counter; // hold
//        end
//        else if (byte_counter < TOTAL_BYTES - 1)
//          byte_counter <= byte_counter + 1;
//        else
//          byte_counter <= TOTAL_BYTES;
//      end
//    end
//  end

//  // Byte copying logic: write to sig_array based on region
//  always_ff @(posedge clk) begin
//    if (processing && !done) begin
//      if (byte_counter < CH_BYTES) begin
//        // Region 1: copy from c_h
//        sig_array[byte_counter] <= c_h[byte_counter*8 +: 8];
//      end
//      else if (byte_counter < CH_BYTES + l * BP_BYTES) begin
//        // Region 2: copy from BitPack output
//        sig_array[byte_counter] <= bitpack_output[bp_index*8 +: 8];
//      end
//      else if (byte_counter < TOTAL_BYTES) begin
//        // Region 3: copy from HintBitPack output
//        sig_array[byte_counter] <= hint_out[byte_counter - (CH_BYTES + l * BP_BYTES)];
//      end
//    end
//  end

//  // Pack sig_array into output vector sig
//  always_comb begin
//    for (int j = 0; j < TOTAL_BYTES; j++) begin
//      sig[j*8 +: 8] = sig_array[j];
//    end
//  end

//  // Debug prints at key milestones:
//  // 1) After appending c_h
//  always_ff @(posedge clk) begin
//    if (processing && !done && byte_counter == CH_BYTES) begin
//      $display("==== After c_h appended (64 bytes) at T=%0t ns ====", $time);
//      printPartialSig(CH_BYTES);
//    end
//  end

//  // 2) After finishing each polynomial?s BitPack output
//  always_ff @(posedge clk) begin
//    if (processing && !done) begin
//      for (int p = 0; p < l; p++) begin
//        if (byte_counter == CH_BYTES + (p+1)*BP_BYTES) begin
//          $display("==== After finishing BitPack for polynomial %0d at T=%0t ns ====", p, $time);
//          printPartialSig(CH_BYTES + (p+1)*BP_BYTES);
//        end
//      end
//    end
//  end

//  // 3) After finishing HintBitPack (final signature)
//  always_ff @(posedge clk) begin
//    if (processing && !done && (byte_counter == TOTAL_BYTES)) begin
//      $display("==== After finishing HintBitPack (final signature) at T=%0t ns ====", $time);
//      printPartialSig(TOTAL_BYTES);
//    end
//  end

//  // Helper task to print a partial signature in hex
//  task automatic printPartialSig(input int length);
//    begin
//      $display("Partial signature (first %0d bytes):", length);
//      for (int i = 0; i < length; i++) begin
//        $write("%02x", sig_array[i]);
//      end
//      $display("");
//    end
//  endtask

//  // Optional: Print debug info each clock cycle
//  always_ff @(posedge clk) begin
//    if (processing && !done) begin
//      $display("T=%0t ns | byte_counter=%0d | poly_sel=%0d | bp_index=%0d | hint_end=%b | done=%b",
//               $time, byte_counter, poly_sel, bp_index, hint_end, done);
//    end
//  end

//endmodule












//module sigEncode (
//    input logic clk,
//    input logic rst,
//    input logic start,             // Signal to start the encoding process
//    output logic done,             // Signal to indicate process completion
    
//    input logic [511:0] c_h,       // 64-byte input (c_h)
//    input logic signed [31:0] z [l-1:0][255:0],  // Array of polynomials z
//    input logic [255:0] h [k-1:0], // Array of 8 polynomials with coefficients 1 or 0
//    output logic [37015:0] sigma   // Output byte string (4627 bytes)
//);

//    // Internal signals
//    localparam int b_len = $clog2(524287 + 524288)-1;
////    logic [36351:0] bitpack_output; // Output of BitPack
//    logic [((b_len + 1) * 256 * l) - 1:0] bitpack_output; // Expanded output array for all instances
//    logic [7:0] hintbitpack_output [omega+k-1:0];          // Output of HintBitPack as unpacked array
//    //logic [37015:0] hintbitpack_output;  
//    logic bitpack_done [l-1:0];                           // Array of done signals for each BitPack instance
//    logic hintbitpack_done;           // Done signals for submodules
    
//    // Instantiate BitPack for each polynomial z
//    genvar i;
//    generate
//        for (i = 0; i < l; i++) begin : bitpack_instances
//            BitPack #(
//                .a(gamma1-1),
//                .b(gamma1),
//                .b_len(b_len)
//            ) bitpack_inst (
//                .w(z[i]),                                  // Input polynomial z[i]
//                .outt(bitpack_output[i * ((b_len + 1) * 256) +: ((b_len + 1) * 256)]), // Sliced output
//                .done(bitpack_done[i])                     // Done signal for each instance
//            );
//        end
//    endgenerate
    
//    // Convert h to HintBitPack format and instantiate
//    logic [255:0] h_converted[k-1:0]; // Converted h to match submodule input requirements
//    always_comb begin
//        for (int j = 0; j < k; j++) begin
//            h_converted[j] = h[j]; // Direct mapping, adjust if conversion is needed
//        end
//    end
    
    
//    HintBitPack #(
//        .K(k),
//        .W(omega),
//        .COEFF_WIDTH(256)
//    ) hintbitpack_inst (
//        .clk(clk),
//        .rst(rst),
//        .startpin(start),
//        .h(h_converted),
//        .endpin(hintbitpack_done),
//        .y(hintbitpack_output)  // Output from HintBitPack
//    );
    
//// Pack hintbitpack_output
//    logic [((omega + k) * 8) - 1:0] hintbitpack_packed_output;
//    integer idx;
//    always_comb begin
//        for (idx = 0; idx < omega + k; idx++) begin
//            hintbitpack_packed_output[idx*8 +: 8] = hintbitpack_output[idx];
//        end
//    end
    
//    // Combine outputs into sigma
//    always_comb begin
//        if (rst) begin
//            sigma <= 0;
//            done <= 0;
//        end else {
//            // Reduction AND to check all done signals from BitPack instances
//            logic all_done == &bitpack_done;
//            if (all_done && hintbitpack_done) begin
//                sigma <= {c_h, bitpack_output, hintbitpack_packed_output};  // Concatenate all outputs after packing
//                done <= 1'b1;
//            end else begin
//                done <= 1'b0;
//            end
//        end
//    end