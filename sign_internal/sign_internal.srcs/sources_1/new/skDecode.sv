`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////

module skDecode(
    
    input logic [8*(32 + 32 + 64 + 32 * (((Dilithium_pkg::l + Dilithium_pkg::k) * ($clog2(2 * Dilithium_pkg::eta)+1)) 
                                      + (Dilithium_pkg::d * Dilithium_pkg::k))) - 1 : 0] sk,
    output logic [255:0] rho,
    output logic [255:0] K,
    output logic [511:0] tr,
    input clk,rst,
    output logic [3:0] s1 [0:Dilithium_pkg::l-1][0:255],
    output logic [3:0] s2 [0:Dilithium_pkg::k-1][0:255],
    output logic [13:0] t0 [0:Dilithium_pkg::k-1][0:255],
    output logic done
    
    );
    
    
    assign rho = sk[255:0];
    assign K = sk[511:256];
    assign tr = sk[1023:512];
    
    localparam int bitlen_eta = 32 * ($clog2(2 * Dilithium_pkg::eta) + 1);                                       
    
    logic [(bitlen_eta * 8) - 1:0] y [0:Dilithium_pkg::l-1];
    logic [(bitlen_eta * 8) - 1:0] z [0:Dilithium_pkg::k-1];
    logic [3327:0] wt0 [0:Dilithium_pkg::k-1];
    
    int offset;
    logic [(($clog2(Dilithium_pkg::eta+Dilithium_pkg::eta)+1) * 256) - 1:0] v;
    logic [3:0] w[0:255];
    
    logic [3327:0] v1;
    logic [13:0] w1[0:255];
    
    BitUnpack #(.a(Dilithium_pkg::eta),.b(Dilithium_pkg::eta),.w_len(4)) BP1 (
            .v(v),        
            .w(w)
        );
        
//    BitUnpack #(.a((2^(Dilithium_pkg::d-1))-1),.b((2^(Dilithium_pkg::d-1))-1),.w_len(6)) BP2 (
    BitUnpack #(.a(($pow(2,(Dilithium_pkg::d-1))-1)),.b(($pow(2,(Dilithium_pkg::d-1)))),.w_len(14)) BP2 (

            .v(v1),        
            .w(w1)
        );
    logic [31:0] count;
    logic count_track;
    
    always_comb begin
        $display(v1);
        offset = 1024;
        
        for (int i = 0; i < Dilithium_pkg::l; i++) begin
            y[i] = sk[offset +: (bitlen_eta * 8)];
            offset = offset + (bitlen_eta * 8);  
        end
        
        for (int j = 0; j < Dilithium_pkg::k; j++) begin
            z[j] = sk[offset +: (bitlen_eta * 8)];
            offset = offset + (bitlen_eta * 8);  
        end
        
        for (int k = 0; k < Dilithium_pkg::k; k++) begin
            wt0[k] = sk[offset +: (32*Dilithium_pkg::d*8)];
            offset = offset + (32*Dilithium_pkg::d*8);  
        end
        
//        $display(offset);
        if (~count_track)begin
            v = y[count];
            s1[count] = w; 
        end else if (count_track) begin
            v = z[count];
            s2[count] = w;
            
            v1 = wt0[count];
            t0[count] = w1;
        end
        
    end
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            count_track <= 0;
            done <= 0;
        end else if (!done) begin
            if (count_track == 0) begin
                // Counting phase for 0 to Dilithium_pkg::l - 1
                if (count < Dilithium_pkg::l - 1) begin
                    count <= count + 1;
                end else begin
                    count <= 0;
                    count_track <= 1; // Move to k-phase
                end
            end else if (count_track == 1) begin
                // Counting phase for 0 to Dilithium_pkg::k - 1
                if (count < Dilithium_pkg::k - 1) begin
                    count <= count + 1;
                end else begin
                    done <= 1; // Stop counting
                end
            end
        end
    end
endmodule
