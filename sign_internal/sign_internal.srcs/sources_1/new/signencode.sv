module signencode (
    input logic [511:0] c_h,
    input logic signed [19:0] z [0:6] [0:255],
    input logic h [0:7] [0:255],
    input logic clk, rst,
    output logic done,
    output logic [37015:0] sigma
);

    logic [2:0] count;
    logic [15:0] offset; // Needs only up to 37015
    logic signed [19:0] w [255:0];
    logic [5119:0] outputt;  // 5129 bits
    logic bp_start;

    // Instantiate bitpack combinational module
    bitpack #(.a(524287), .b(524288)) bp1 (
        .start(1'b1),
        .w(w),
        .outputt(outputt)
    );

    always_ff @(posedge clk or negedge rst) begin
        if (rst) begin
            count <= 0;
            offset <= 512;  // Start at the bottom of the sigma[36504:37015] block
            sigma[511:0] <= c_h;  // Reverse index assignment of c_h
            done <= 0;
                
        end 
        else if (!done) begin
            w <= z[count];
            sigma[offset +: 5120] <= outputt;  // Ascending part-select
            offset <= offset + 5120;  // Move forward in sigma
            count <= count + 1;
            $display("sigma: %h",sigma);
//        $display(sigma);            
            if (count == 7)
            sigma[offset +: 5120] <= outputt;
//            count <= 'x;
//                sigma[offset +: 5120] <= outputt;  // Ascending part-select
//                offset <= offset + 5120;
                done <= 1;  // Final cycle
        end
//        $display(sigma);
    end


endmodule