


module BitPack #(

    parameter int w_len=32,
    parameter int a = 256,
    parameter int b = 8,
    parameter b_len = $clog2(a + b)
)(
    input logic [w_len:0] w[255:0],
    output logic [(b_len * 256) - 1:0] outputt   // Array of 256 integers
   //output logic [7:0] byte_array [((b_len*256)/8)-1:0]
 // Flattened output
     // 255-byte array output
);

integer i;
integer j;
logic signed [31:0] z [255:0];

// Process the input and create the output bit-string
always_comb begin
    // Process z array
    for (i = 0; i < 256; i++) begin
        z[i] = b - w[i];
    end

    // Concatenate z into outputt
    for (j = 0; j < 256; j++) begin
        outputt[j * b_len +: b_len] = z[j];
    end

    // Convert the outputt into a 255-length byte array
//    for (i = 0; i < (b_len*256)/8; i++) begin
//        byte_array[i] = outputt[i * 8 +: 8]; 
//        $display("output[%d:%d]:%b : %b",i*8,(i*8)+8, outputt[i * 8 +: 8],byte_array[i]);   // Extract 8 bits at a time to form a byte
//    end

    
   $display("byte_array : %0b", outputt);
end

endmodule
