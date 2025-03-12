  import Dilithium_pkg::*;
    module skEncode #(
        parameter int cols_l = Dilithium_pkg.l,       // s1 rows: indices 0 to 6
        parameter int rows_k = Dilithium_pkg.k,       // s2 and t0 rows: indices 0 to 7
        parameter int n = 2,     
        parameter int d = Dilithium_pkg.d   
    ) (
        input logic clk,
        input logic rst,
        input logic [255:0] rho,     // Input for rho (256-bit)
        input logic [255:0] K,       // Input for K (256-bit)
        input logic [511:0] tr,      // Input for tr (512-bit)
        // Array of 7 polynomials for s1 (each with 256 coefficients)
        input logic signed [$clog2(n+n):0] s1[cols_l-1:0][255:0],
        // Array of 8 polynomials for s2 (each with 256 coefficients)
        input logic signed [$clog2(n+n):0] s2[rows_k-1:0][255:0],
        // Array of 8 polynomials for t0 (each with 256 coefficients)
        input logic signed [$clog2(((1 << (d-1)) - 1) + (1 << (d-1)))-1:0] t0[rows_k-1:0][255:0],
        
        output logic [39167:0] sk=0, // Output sk (39168 bits)
        output logic done
    );
    
      // Internal signals for BitPack done signals
      logic done1;
      logic done2;
      logic done3;
    
      // Internal Buffers
      logic signed [$clog2(n+n):0] m1[255:0];
      logic signed [$clog2(n+n):0] m2[255:0];
      logic signed [$clog2(((1 << (d-1)) - 1) + (1 << (d-1)))-1:0] m0[255:0];
    
      // Packed Outputs
      logic [5375:0] sk1;
      logic [6143:0] sk2;
      logic [26623:0] sk3;
      //integer file;
          
    
      // Bit Packed Outputs
      logic [(($clog2(n+n)+1)*256)-1:0] o1;
      logic [(($clog2(n+n)+1)*256)-1:0] o2;
      logic [($clog2(((1 << (d-1)) - 1) + (1 << (d-1)))*256)-1:0] o3;
    
      integer i = 0; // Counter for processing rows
      
      // Instantiate BitPack Modules
      BitPack #(
        .a(n), 
        .b(n), 
        .b_len($clog2(n+n)+1)
      ) bp1 (
        .w(m1),
        .outputt(o1),
        .done(done1)
      );
    
      BitPack #(
        .a(n), 
        .b(n), 
        .b_len($clog2(n+n)+1)
      ) bp2 (
        .w(m2),
        .outputt(o2),
        .done(done2)
      );
    
      BitPack #(
        .a((1 << (d-1)) - 1),
        .b(1 << (d-1)),
        .b_len($clog2(((1 << (d-1)) - 1) + (1 << (d-1))))
      ) bp3 (
        .w(m0),
        .outputt(o3),
        .done(done3)
      );
       // Open the file for writing at simulation start
//       initial begin
//         file = $fopen("output.txt", "w");
//         i    = 0;  // Initialize the row counter
//         done = 0;
//       end
    
      always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
          i    <= 0;
          done <= 0;
          // Optionally, reset sk and the packed registers here
        end else begin
          // Process s1 (only for i = 0 to 6)
          i <=0;
          if (i < cols_l) begin
            m1 <= s1[i]; // Use index i directly
            sk1[i * 768 +: 768] <= o1;
          end
    
          // Process s2 and t0 (for i = 0 to 7)
          if (i < rows_k) begin
            m2 <= s2[i]; // Use index i directly
            sk2[i * 768 +: 768] <= o2;
            
            m0 <= t0[i]; // Use index i directly
            sk3[i * 3328 +: 3328] <= o3;
          end
    
          // Move to the next row
          if (i < rows_k) begin
            i <= i + 1;
          end
    
          // When finished processing, set done and concatenate outputs.
          // Here, since s2 and t0 are 8 rows, we wait until i reaches 8.
          if (i == rows_k) begin 
            done <= 1;
            sk   <= {sk3,sk2, sk1, tr, K,rho};
         //   sk <={}
            $display("sk1 : %0d", sk3);
           //  $fdisplay(file, "Concatenated sk: %h", sk);
          end
        end
      end
    
    endmodule
