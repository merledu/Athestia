//module Top_MakeHint(
//    input logic clk,              // Clock input
//    input logic rst,              // Reset input
//    input logic btn,              // Button input to trigger processing
//    output logic led              // LED output for hint indication
//);
//    localparam integer q = Dilithium_pkg::q;

//    // Parameters for MakeHint
//    localparam int WIDTH_R = 32;  // Define WIDTH_R
//    localparam int WIDTH_Z = 16;  // Define WIDTH_Z
//    localparam expected_hint = 1'b0;  // Expected hint for the inputs

//    // Input values for MakeHint
//    logic [WIDTH_R-1:0] r = 1234567;  // Initial value for r
//    logic [WIDTH_Z-1:0] z = 123456;   // Initial value for z

//    // Output from MakeHint
//    logic hint;

//    // Instance of MakeHint
//    MakeHint makehint_instance (
//        .clk(clk),
//        .reset(rst),
//        .r(r),
//        .z(z),
//        .hint(hint)
//    );

//    // Control LED based on hint output
//    always @(posedge clk) begin
//        if (rst) begin
//            led <= 1'b0;  // Reset LED on reset
//        end else if (btn) begin
//            led <= (hint == expected_hint);  // Set LED if hint matches expected value
//        end
//    end
//endmodule