module BitExtender(
    input logic [13:0] in_value,
    input bit is_signed,
    output logic [23:0] out_value
);
    function automatic logic [23:0] extend_bits(
        input logic [13:0] value,
        input int target_width,
        input bit is_signed
    );
        logic [23:0] extended_value;
        int i;

        extended_value[13:0] = value; // Assign initial 4-bit value

        if (is_signed) begin
            for (i = 14; i < target_width; i++)  // Start from bit 4
                extended_value[i] = value[13];   // Sign extend from MSB (bit 3)
        end else begin
            for (i = 14; i < target_width; i++) 
                extended_value[i] = 1'b0;       // Zero extend
        end
        
        return extended_value;
    endfunction

    assign out_value = extend_bits(in_value, 24, is_signed); // Fix target_width
endmodule
