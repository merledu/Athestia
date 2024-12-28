`timescale 1ns / 1ps

import Dilithium_pkg::*;           // Import necessary constants like q

module MakeHint(
    input  logic [31:0] r, // Width explicitly defined
    input  logic [31:0] z, // Width explicitly defined
    output logic hint      // Boolean output
);

    // Signals for Decompose
    logic [31:0] decompose_r_input;    // Input to the Decompose module
    logic unsigned [31:0] r1, v1;      // HighBits (outputs from Decompose)
    logic unsigned [31:0] r0_unused;   // LowBits output from Decompose (unused)

    // Temporary variables for storing high bits from Decompose
    logic unsigned [31:0] r1_temp;
    logic unsigned [31:0] v1_temp;

    // Instantiate Decompose (single instance)
    Decompose decompose_inst (
        .r  (decompose_r_input), // Input to Decompose
        .r1 (r1),                // High bits output
        .r0 (r0_unused)          // Low bits output (not used)
    );

    // Combinational logic to implement MakeHint
    always_comb begin
        // First pass: Pass 'r' to Decompose and store high bits
        decompose_r_input = r;
        r1_temp = r1;  // Store the high bits of 'r'

        // Print the high bits of 'r' for debugging
        $display("Decompose Output for r = %d: r1 = %d", r, r1);

        // Second pass: Pass 'r + z' to Decompose and store high bits
        decompose_r_input = r + z;
        v1_temp = r1;  // Store the high bits of 'r + z'

        // Print the high bits of 'r + z' for debugging
        $display("Decompose Output for r + z = %d: r1 = %d", r + z, r1);

        // Compute the hint: Check if high bits are different
        hint = (r1_temp != v1_temp);
    end

endmodule































//module MakeHint(
//    input logic clk,
//    input logic reset,
//    input logic start,
//    input logic [31:0] r,
//    input logic [31:0] z,
//    output logic hint,
//    output logic ready
//);

//    localparam int width = 32;
//    localparam int r1_width = 32;  // Adjust based on expected bit range from Decompose

//    logic [width-1:0] r_plus_z;
//    logic [r1_width-1:0] decomposed_r1;
//    logic [r1_width-1:0] r1, v1;
//    logic [1:0] step;

//    // Assuming Decompose correctly implemented
//    Decompose #(.width(width), .r1_width(r1_width)) decompose_inst (
//        .r(step ? r_plus_z : r),
//        .r1(decomposed_r1)
//    );

//    always @(posedge clk) begin
//        if (reset) begin
//            r1 <= 0;
//            v1 <= 0;
//            ready <= 0;
//            hint <= 0;
//            step <= 0;
//            $display("[%0t] Reset applied.", $time);
//        end else if (start && step == 0) begin
//            r_plus_z <= r + z;
//            step <= 1;
//            ready <= 0;
//            $display("[%0t] Start triggered: r=%d, z=%d, r+z=%d", $time, r, z, r + z);
//        end else if (step == 1) begin
//            r1 <= decomposed_r1;
//            step <= 2;
//            $display("[%0t] Step 1: High Bits of r = %d", $time, decomposed_r1);
//        end else if (step == 2) begin
//            v1 <= decomposed_r1;
//            hint <= (r1 != v1);
//            ready <= 1;
//            step <= 0;
//            $display("[%0t] Step 2: High Bits of r+z = %d, Hint = %d", $time, decomposed_r1, hint);
//        end
//    end
//endmodule





















//module MakeHint(
//    input logic clk,
//    input logic reset,
//    input logic [31:0] r,
//    input logic [31:0] z,
//    output logic hint
//);
//    logic [31:0] r_plus_z;
//    logic unsigned [31:0] r1_initial, r1_after_addition;
//    logic [31:0] decompose_input;
//    logic unsigned [31:0] r1;
//    logic unsigned [31:0] r0_unused;  // r0 is not used

//    // Decompose module instantiation
//    Decompose #(.width(32), .r1_width(32), .r0_width(32)) decompose_instance (
//        .r(decompose_input),
//        .r1(r1),
//        .r0(r0_unused)
//    );

//    logic [1:0] counter;

//    always_comb begin
//        r_plus_z = (r + z) % q;  // Compute r + z under modulus
//    end

//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            counter <= 0;
//            r1_initial <= 0;
//            r1_after_addition <= 0;
//            hint <= 0;  // Explicitly reset hint
//            decompose_input <= 0;
//        end else begin
//            counter <= counter + 1;
//            case (counter)
//                2'b00: begin
//                    decompose_input <= r;  // Load r into decompose
//                end
//                2'b01: begin
//                    r1_initial <= r1;     // Store initial r1
//                end
//                2'b10: begin
//                    decompose_input <= r_plus_z;  // Load r + z
//                end
//                2'b11: begin
//                    r1_after_addition <= r1;      // Store r1 after addition
//                    hint <= (r1_initial != r1_after_addition);  // Set hint
//                    counter <= 0;  // Reset counter for a new cycle
//                end
//            endcase
//        end
//    end
//endmodule

















//module MakeHint(
//    input logic clk,                   // Clock input
//    input logic reset,                 // Reset input
//    input logic [31:0] r,              // Assuming width of r is 32 bits
//    input logic [15:0] z,              // Assuming width of z is 16 bits
//    output logic hint                  // Output hint bit
//);

//    // Internal signals
//    logic [31:0] r_plus_z;
//    logic unsigned [31:0] r1_initial, r1_after_addition;
//    logic [31:0] decompose_input;
//    logic unsigned [31:0] r1;
//    logic unsigned [31:0] r0_unused;      // r0 is not used

//    // Decompose module instantiation
//    Decompose #(
//        .width(32),
//        .r1_width(32),
//        .r0_width(32)
//    ) decompose_instance (
//        .r(decompose_input),
//        .r1(r1),
//        .r0(r0_unused)
//    );

//    // Counter for managing decompose input toggling
//    logic [1:0] counter;

//    // Compute r + z ensuring no overflow beyond the range of r
//    always_comb begin
//        r_plus_z = (r + z) % q;  // Calculate r + z under modulus
//    end

//    // Control logic for single Decompose instance using counter
//    always_ff @(posedge clk, posedge reset) begin
//        if (reset) begin
//            counter <= 0;
//        end else begin
//            counter <= counter + 1;
//            case (counter)
//                2'b00: begin
//                    decompose_input <= r;  // Load r into decompose on first count
//                end
//                2'b01: begin
//                    r1_initial <= r1;     // Store initial r1 after first decompose
//                end
//                2'b10: begin
//                    decompose_input <= r_plus_z;  // Load r + z on third count
//                end
//                2'b11: begin
//                    r1_after_addition <= r1;      // Store r1 after addition for comparison
//                    counter <= 0;                 // Reset counter to start new cycle
//                end
//            endcase
//        end
//    end

////    // Generate hint based on comparison of high bits
////    always_comb begin
////        hint = (r1_initial != r1_after_addition);
////    end
////endmodule

//    // Generate hint based on comparison of high bits
//    always_ff @(posedge clk) begin
//        if (reset) begin
//            hint <= 0;
//        end else begin
//            hint <= (r1_initial != r1_after_addition);
//        end
//    end
//endmodule
































//module MakeHint(
//    input logic clk,               // Clock input
//    input logic rst_n,             // Asynchronous reset (active low)
//    input logic [31:0] r,          // Input r, 32-bit width
//    input logic [15:0] z,          // Input z, 16-bit width
//    output logic hint              // Output hint bit
//);

//    localparam int WIDTH = 32;     // Use the larger width for internal operations

//    logic [WIDTH-1:0] r1, v1;      // High bits of r and r+z
//    logic [WIDTH-1:0] r_plus_z;    // r + z
//    logic [WIDTH-1:0] r0_dummy;    // Dummy variable for low bits not used
//    logic [WIDTH-1:0] input_decompose;  // Input to the Decompose module
//    logic process_r;               // Control signal to process r or r+z

//    // Extend z to match the width of r
//    logic [WIDTH-1:0] z_extended;
//    assign z_extended = z;

//    // Calculate r + z modulo q
//    assign r_plus_z = (r + z_extended) % q;

//    // Control logic to alternate between processing r and r + z
//    always_ff @(posedge clk or negedge rst_n) begin
//        if (!rst_n) begin
//            process_r <= 1; // Start by processing r
//        end else begin
//            process_r <= ~process_r; // Toggle to process the next input
//        end
//    end

//    // Select the input for Decompose based on the current process step
//    always_comb begin
//        input_decompose = process_r ? r : r_plus_z;
//    end

//    // Single Decompose instance for both operations
//    Decompose #(.width(WIDTH), .r1_width(WIDTH), .r0_width(WIDTH)) decompose_instance (
//        .r(input_decompose),
//        .r1(r1),
//        .r0(r0_dummy)
//    );

//    // Capture and compare high bits to set hint
//    always_ff @(posedge clk) begin
//        if (process_r) begin
//            v1 <= r1;  // Capture high bits of r+z when process_r is 0
//        end else begin
//            hint <= (r1 != v1);  // Compare high bits when process_r is 1
//        end
//    end

//endmodule
