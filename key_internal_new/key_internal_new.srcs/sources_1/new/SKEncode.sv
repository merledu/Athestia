module skEncode #(
    parameter int cols_l = 7,
    parameter int rows_k = 8,
    parameter int n = 2,
    parameter int d = 13
)(
    input logic clk,
    input logic rst,
    input logic [255:0] rho,
    input logic [255:0] K,
    input logic [511:0] tr,
    input logic signed [2:0] s1[0:cols_l-1][0:255],
    input logic signed [2:0] s2[0:rows_k-1][0:255],
    input logic signed [12:0] t0[0:rows_k-1][0:255],
    output logic [39167:0] sk = 0,
    output logic done
);

    // FSM states
    typedef enum logic [2:0] {
        IDLE,
        LOAD_ROW,
        BITPACK,
        STORE_OUTPUT,
        FINALIZE
    } state_t;

    state_t state, next_state;

    // Internal signals
    logic signed [2:0] m1[255:0];
    logic signed [2:0] m2[255:0];
    logic signed [12:0] m0[255:0];

    logic [5375:0] sk1;
    logic [6143:0] sk2;
    logic [26623:0] sk3;

    logic [(3*256)-1:0] o1;
    logic [(3*256)-1:0] o2;
    logic [(13*256)-1:0] o3;

    logic bp_start;

    integer i;

    // Instantiate BitPack modules
    BitPack_new #(.a(n), .b(n)) bp1 (
    .start(bp_start), 
    .w(m1), 
    .outputt(o1));
    BitPack_new #(.a(n), .b(n)) bp2 (.start(bp_start), .w(m2), .outputt(o2));
    BitPack_new #(.a(4095), .b(4096), .b_len(13)) bp3 (.start(bp_start), .w(m0), .outputt(o3));

    // FSM transition
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            i <= 0;
            sk <= '0;
            done <= 0;
            bp_start <= 0;
        end else begin
            state <= next_state;
        end
    end

    // FSM logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (!done)
                    next_state = LOAD_ROW;
            end

            LOAD_ROW: begin
                next_state = BITPACK;
            end

            BITPACK: begin
                next_state = STORE_OUTPUT;
            end

            STORE_OUTPUT: begin
                if (i < rows_k - 1)
                    next_state = LOAD_ROW;
                else
                    next_state = FINALIZE;
            end

            FINALIZE: begin                
            end
        endcase
    end

    // FSM outputs and behavior
    always_ff @(posedge clk) begin
        case (state)
            IDLE: begin
                i <= 0;
                bp_start <= 0;
                done <= 0;
            end

            LOAD_ROW: begin
                if (i < cols_l) m1 <= s1[i];
               
                m2 <= s2[i];
                m0 <= t0[i];
                bp_start <= 1;
            end

            BITPACK: begin
                bp_start <= 0;
            end

            STORE_OUTPUT: begin
                sk1[i * 768   +: 768]   <= o1;
                sk2[i * 768   +: 768]   <= o2;
                sk3[i * 3328  +: 3328]  <= o3;
                i <= i + 1;
            end

            FINALIZE: begin
                sk <= {//sk3[0*3328 +: 3328],
//                               sk3[1*3328 +: 3328], 
//                               sk3[2*3328 +: 3328], 
//                               sk3[3*3328 +: 3328], 
//                               sk3[4*3328 +: 3328], 
//                               sk3[5*3328 +: 3328], 
//                               sk3[6*3328 +: 3328]
//                               , sk3[7*3328 +: 3328],                 
//                sk2[0*768 +: 768], 
//                               sk2[1*768 +: 768], 
//                               sk2[2*768 +: 768], 
//                               sk2[3*768 +: 768], 
//                               sk2[4*768 +: 768], 
//                               sk2[5*768 +: 768], 
//                               sk2[6*768 +: 768],
//                              sk2[7*768 +: 768], 
//                   sk1[0*768 +: 768], 
//                   sk1[1*768 +: 768], 
//                   sk1[2*768 +: 768], 
//                   sk1[3*768 +: 768], 
//                   sk1[4*768 +: 768], 
//                   sk1[5*768 +: 768], 
//                   sk1[6*768 +: 768],
                   sk3,sk2,sk1,tr, K, rho};
                done <= 1;
            end
        endcase
    end

endmodule
