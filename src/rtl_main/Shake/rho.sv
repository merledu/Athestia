// module rho (
//   input logic start,
//   input logic rst,
//   input logic clk,
//   input  logic [63:0] A[4:0][4:0],  
//   output logic [63:0] A_prime[4:0][4:0],  
//   output logic valid

// );


//   logic [2:0] x;
//   logic [2:0] y;
//   logic [4:0] t;
//   logic [63:0] offset;
//   logic [2:0] x_reg, y_reg;
//   logic [4:0] t_reg;
//   logic [63:0] offset_reg;


//   initial begin
//     x_reg = 3'd1;
//     y_reg = 3'd0;
//     t_reg = 5'd0;
//     A_prime[0][0] = A[0][0];
//   end

//   always_ff @(posedge clk or posedge rst) begin
//     if (start && t_reg < 24) begin
//       offset_reg <= ((t_reg + 1) * (t_reg + 2)) >> 1;
//       for (int z = 0; z < 64; z++) begin
//         A_prime[x_reg][y_reg][z] <= A[x_reg][y_reg][(z - offset_reg) % 64];
//       end
//       x_reg <= y_reg;
//       y_reg <= (2 * x_reg + 3 * y_reg) % 5;
//       if (t_reg == 23) begin
//         valid <= 1'd1;
//       end
//       t_reg <= t_reg + 1;
//     end
    
//   end

// endmodule

module rho#(parameter W = 64) (
    input logic [W-1:0] A [0:4][0:4], // Input state array A (5x5 matrix of W-bit values)
    output logic [W-1:0] A_prime [0:4][0:4], 
    input logic clk,rst
);
    // integer t, z;       // Loop variables
    // int x, y, new_x, new_y;
    // int temp; // Used for the modulo operations

    // Initialize A_prime[0][0] = A[0][0] for all z
    always_ff @( posedge clk or negedge rst ) begin
        // for (z = 0; z < W; z++) begin
        //     A_prime[0][0][z] = A[0][0][z];
        // end

        //A_prime[0][2] = {A[0][2][61:63], A[0][2][0:60]};
        // A_prime[0][2] = '{A[0][2][60], A[0][2][59], A[0][2][58], A[0][2][57], A[0][2][56], A[0][2][55], A[0][2][54], A[0][2][53], A[0][2][52], A[0][2][51], A[0][2][50], A[0][2][49], A[0][2][48], A[0][2][47], A[0][2][46], A[0][2][45], A[0][2][44], A[0][2][43], A[0][2][42], A[0][2][41], A[0][2][40], A[0][2][39], A[0][2][38], A[0][2][37], A[0][2][36], A[0][2][35], A[0][2][34], A[0][2][33], A[0][2][32], A[0][2][31], A[0][2][30], A[0][2][29], A[0][2][28], A[0][2][27], A[0][2][26], A[0][2][25], A[0][2][24], A[0][2][23], A[0][2][22], A[0][2][21], A[0][2][20], A[0][2][19], A[0][2][18], A[0][2][17], A[0][2][16], A[0][2][15], A[0][2][14], A[0][2][13], A[0][2][12], A[0][2][11], A[0][2][10], A[0][2][9], A[0][2][8], A[0][2][7], A[0][2][6], A[0][2][5], A[0][2][4], A[0][2][3], A[0][2][2], A[0][2][1], A[0][2][0], A[0][2][63], A[0][2][62],A[0][2][61]};
      //  if (start) begin
        A_prime[0][0] = A[0][0];
        A_prime[1][0] = {A[1][0][62:0],A[1][0][63]};
        A_prime[0][2] = {A[0][2][60:0],A[0][2][63:61]};
        A_prime[2][1] = {A[2][1][57:0],A[2][1][63:58]};
        A_prime[1][2] = {A[1][2][53:0],A[1][2][63:54]};
        A_prime[2][3] = {A[2][3][48:0],A[2][3][63:49]};
        A_prime[3][3] = {A[3][3][42:0],A[3][3][63:43]};
        A_prime[3][0] = {A[3][0][35:0],A[3][0][63:36]};
        A_prime[0][1] = {A[0][1][27:0],A[0][1][63:28]};
        A_prime[1][3] = {A[1][3][18:0],A[1][3][63:19]};
        A_prime[3][1] = {A[3][1][8:0],A[3][1][63:9]};
        A_prime[1][4] = {A[1][4][61:0],A[1][4][63:62]};
        A_prime[4][4] = {A[4][4][49:0],A[4][4][63:50]};
        A_prime[4][0] = {A[4][0][36:0],A[4][0][63:37]};
        A_prime[0][3] = {A[0][3][22:0],A[0][3][63:23]};
        A_prime[3][4] = {A[3][4][7:0],A[3][4][63:8]};
        A_prime[4][3] = {A[4][3][55:0],A[4][3][63:56]};
        A_prime[3][2] = {A[3][2][38:0],A[3][2][63:39]};
        A_prime[2][2] = {A[2][2][20:0],A[3][2][63:21]};
        A_prime[2][0] = {A[2][0][1:0],A[2][0][63:2]};
        A_prime[0][4] = {A[0][4][45:0],A[0][4][63:46]};
        A_prime[4][2] = {A[4][2][24:0],A[4][2][63:25]};
        A_prime[2][4] = {A[2][4][2:0],A[2][4][63:3]};
        A_prime[4][1] = {A[4][1][43:0],A[4][1][63:44]};
        A_prime[1][1] = {A[1][1][19:0],A[1][1][63:20]};
        // valid = 1;
        // end else begin
        // A_prime[0][0] = 0;
        // A_prime[1][0] = 0;
        // A_prime[0][2] = 0;
        // A_prime[2][1] = 0;
        // A_prime[1][2] = 0;
        // A_prime[2][3] = 0;
        // A_prime[3][3] = 0;
        // A_prime[3][0] = 0;
        // A_prime[0][1] = 0;
        // A_prime[1][3] = 0;
        // A_prime[3][1] = 0;
        // A_prime[1][4] = 0;
        // A_prime[4][4] = 0;
        // A_prime[4][0] = 0;
        // A_prime[0][3] = 0;
        // A_prime[3][4] = 0;
        // A_prime[4][3] = 0;
        // A_prime[3][2] = 0;
        // A_prime[2][2] = 0;
        // A_prime[2][0] = 0;
        // A_prime[0][4] = 0;
        // A_prime[4][2] = 0;
        // A_prime[2][4] = 0;
        // A_prime[4][1] = 0;
        // A_prime[1][1] = 0;
        // end

        
    end

endmodule
