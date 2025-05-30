`timescale 1ns / 1ps
import Dilithium_pkg::*;

module verifyInternalModule #(
    parameter PK_SIZE = 20736,
    parameter MSG_MAX_SIZE = 1024,
    parameter SIG_SIZE = 37016,
    parameter d_len = 512,
    parameter msg_len_pk = 20740,
    parameter capacity = 512,
    parameter r = 1600 - capacity,
    parameter mu_d_len = 512,
    parameter mu_msg_len = 28188,
    parameter mu_capacity = 512,
    parameter mu_r = 1600 - mu_capacity,
    parameter msg_len_c_tilde = 8708
    

)(
    input logic clk, rst,initial_start,
    input logic [0:PK_SIZE-1] pk,
    input logic [MSG_MAX_SIZE-1:0] M,
    input logic [SIG_SIZE-1:0] sigma,
    output logic valid,
    output logic done
);

// State Machine Declaration
typedef enum logic [3:0] {
    IDLE, DECODE_PK, DECODE_SIG, CHECK_H, EXPAND_A, 
    HASH_TR, HASH_MU, SAMPLE_C, NTT_OPS, USE_HINT, 
    ENCODE_W1, HASH_CTILDE, INFINTY_NORM, DONE,WAITCTILDEINPUT,WAIT2
} state_t;
state_t current_state;

// Internal Signals
logic [255:0] rho;
logic [31:0] t1 [k-1:0][0:255];   //value  of b where 9 for hardware assign issue check later
logic [lambda*2-1:0] c_tilde_prime;
logic [((lambda/4)*8)-1:0] c_tilde;
logic [31:0] z [0:l-1] [0:255];
logic h [k-1:0][255:0];
logic h_valid;
logic [d_len-1:0] tr, mu,mu_store;
logic [0:31] c_poly [255:0];
logic [31:0] A_hat [0:k-1] [0:l-1] [0:255];
logic [31:0] w_approx [0:k-1] [0:255];
logic [3:0] w1_prime [0:k-1][0:255];
logic [256*k*4-1:0] w1_encoded,store_w1_encoded;
logic norm_valid, hash_match;

logic [0:28187] mu_ShakeIn;//mu_msg_len+d_len+3
logic [0:PK_SIZE+3] ShakeIn;
logic [PK_SIZE+3:0] ShakeIn_c_tilde;  
logic [PK_SIZE+3:0] wait_ShakeIn_c_tilde;  
logic [31:0] max_value_result;

// Control Signals
logic sig_decode_start, expandA_start;
logic shake_pk_start, shake_mu_start, sample_start;
logic ntt_start, usehint_start, w1encode_start, hashc_start,infinity_start,valid_ctilde_input;
logic pk_decode_done, sig_decode_done, expandA_done;
logic shake_pk_done, shake_mu_done, sample_done;
logic ntt_done, usehint_done, w1encode_done, hashc_done,infinity_done;

// Main Control FSM
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset all control signals and state
        current_state     <= IDLE;
        sig_decode_start  <= 0;
        expandA_start     <= 0;
        shake_pk_start    <= 0;
        shake_mu_start    <= 0;
        sample_start      <= 0;
        ntt_start         <= 0;
        usehint_start     <= 0;
        w1encode_start    <= 0;
        hashc_start       <= 0;
        infinity_start    <= 0; 
        valid             <= 0;
        ShakeIn <= 0;
        mu_ShakeIn <= 0;
        ShakeIn_c_tilde <= 0;
        valid_ctilde_input <=0;
        
    end else begin

        case (current_state)
            IDLE: begin
                current_state    <=DECODE_PK;
            end
            DECODE_PK: begin
                            //input start value for first module
                if (pk_decode_done) begin
                    current_state <= DECODE_SIG;
                end
            end
            DECODE_SIG: begin
                sig_decode_start <= 1;
                if (sig_decode_done) begin
                    current_state <= EXPAND_A;
                end
            end
            EXPAND_A: begin
                expandA_start <= 1;
                if (expandA_done)begin
                    current_state <= HASH_TR;
                end
            end
            HASH_TR: begin
                if (expandA_done == 1) begin
                    
                    ShakeIn <= {4'hf,pk};
                end
                shake_pk_start <= 1;
                if (shake_pk_done)begin
                    current_state <=HASH_MU;
                end
            end

            HASH_MU: begin
                shake_mu_start <= 1;
                mu_ShakeIn <= {4'hf,M,tr};
//                 $display("Hex value shake mu = %h", mu_ShakeIn);
                if (shake_mu_done)begin
                    mu_store <= mu;
                    current_state <= SAMPLE_C;
                end
            end
            SAMPLE_C: begin
                sample_start <= 1;
//                shake_mu_done <=0;
                if (sample_done) begin
                    current_state <= NTT_OPS;
                end
            end
            NTT_OPS: begin
                ntt_start <= 1;
                if (ntt_done) begin
                    current_state <= USE_HINT;
                end
            end
            
            USE_HINT: begin
                            usehint_start <= 1;
                            if (usehint_done) begin
                                current_state <= ENCODE_W1;
                            end
                        end
          ENCODE_W1: begin
                w1encode_start <= 1;
                if (w1encode_done ) begin
                    store_w1_encoded   <= w1_encoded;
                    valid_ctilde_input <= 1;
                    current_state      <= HASH_CTILDE;
                end
            end
            
//            WAITCTILDEINPUT: begin
//                    w1encode_start <= 0;
//                    wait_ShakeIn_c_tilde  <= {4'hf, w1_encoded,mu};//{4'hf, store_w1_encoded,mu_store};
//                    current_state <= WAIT2;
                
//            end
//             WAIT2: begin
//                   current_state <= HASH_CTILDE;
               
//           end
            
            HASH_CTILDE: begin
                if (valid_ctilde_input) begin
                hashc_start <= 1;
                ShakeIn_c_tilde <= 8708'hfEECF32AE0B711EC4D401F9D78E01C9FD3ECEDBEA902DDE3614ACB3732DF79314CB6B0FDA9032C4C0D8A24584913621FDCC61810F43F51D4899FF0C029ADDC3330E95010455DD09ED5A5BAAF52E083C236FA59327388EAFD1AF9342135730330A7C5E20D6490B8ED89F691C4A000B60E28FC6A80071A523C0CF3FC5C1B45E6097FB01DE548936285B9A9FA0B82B2B655957FA472C3DDC63EA28E7539E6938C733525A083D4046DC2CDC09D48C72DD98A128F6060ED10F48575FFDD4B49B37C536B0169FA9B2F1E46B42CB9C17399D45FE9F7E4B06B404D1EE8030770514913F9E6D7D926C9BE1FA9E9146E6D5DD1819513397B27012355FFE982F4707F31E8A9074955335A25CF4ED9F4E21D3A4CBAEE8B6BCE2E13D153C714E9A5C342978E3ADECDC2B63D3FF1BA82C1FF059AC07167E05C25B05D4A1105B1746B91FFDE2B4E5354D9BC92EE5F5B130C397A0764FB394D459CFB9ABA0C71E004A4914561DC9D8CE723DFDF06A9A7B571E590AEDC614AB72E94A0E1EBAC97BDF46261E04BA8721D9AD46A4634F913C5F96553E11ABCCEEAF4148F6C122EFA828181D3AB7E2C4340E19354CAC75993FAF92CE3BB360D987C068334C5F79DEA8AD83CD44EB00AB89969216E1AC96A988D6273728155C9CAF351123136A3CC31ACC7C79F794FA12FDC0851376CA048C7D41F97840C85C67C4CD037F7CFBE1927A975A6813E5CE37F081C546B83D69BDB153ABD2DA669A0D057A65EA54F777703FB3F599E135BEA9694DC4B1F315DF129F50CD87E39528F9737D1384574B78B035FB7D5A26B0700F696FE3C981EA39C691A5C3C6AF0110BAF3F5638B79CAB681C1406C834A16B678331D6F5B88D470B9D0A0D1254AB1ECCE93154C68111519D0A335F15AB53B1D421450914E7020EDF93CDA34301A59970299094C97E23EF7CCAC31359B8143FE103683FD73959BEF74EDFA3D215C4C87D351334548CF5E241D5B779FDBDD8E63B3285FB61E983AC7D0E4566A048894AA26ACCB8EC2CDB48D5DD9FB11AAEEE5A08BA0759E4AB688AA8B7BE101BB392F4CE001DC59AFB885BCDEAE73A9608DF9F3C579FE83EA24E188391DF0ABAB42BFC1399FEA24201173D418811E81BA8FB46546AA63418D5B673320A6F1BFD33AF175CC43E3438FD30B0B0700F13A58F7128BE27FEC210B4001511350DF8D563337A81CC1F671DC54EB8C18FDB5509A523DFB8BE7C0E6B9EDA1BFE24B7C170A4F0C2024498DB37A190727BA57AA1954674BE7742A1464E476D59A623FA97AE5F8F23061C336BDA995A88DFC46C1DE7506AF051C2E6687ACDE27A5F5BB5C661AADF208451709F641DAC9ACD5B8F83516EDE0974C8E60BAB567B3309AC2821BFAF98DCCB33BBC18D57FB2B851CAB116F06C2E89DE3CB46FCE386D424E306220925805F8D6B9297AA7E10B599D9F3A220F2EBB0D827030EBE6AA082352A9B05A58FD8DAF2FA50240BF43D9E46B25D15374976F352D8DCCBC8F2545774D32F01ED7B41F2FA2ADC32929DAC91565397A11E315308BC4BE;

                
//                {4'hf, w1_encoded,mu};
                end else begin
                valid_ctilde_input <= 0;
                end
//                 wait_ShakeIn_c_tilde;

                
//                 $display("Hex value shake mu = %h", mu_ShakeIn);
                if (hashc_done)begin
                    current_state <= INFINTY_NORM;
                end
            end
            
            INFINTY_NORM: begin
                infinity_start <= 1;
                if (infinity_done) begin
                    current_state <= DONE;
                end
            end
            
            
            DONE: begin
            if ((max_value_result < (gamma1 - beta)) &&c_tilde_prime==c_tilde)begin
                valid <=1;
                done <= 1;
            
            end else begin
                valid <=0;
                done <= 1;
                current_state <= IDLE;
                end
             end




//        DECODE_SIG: if(sig_decode_done) next_state = CHECK_H;
//        CHECK_H: next_state = h_valid ? EXPAND_A : DONE;
//        EXPAND_A: if(expandA_done) next_state = HASH_TR;
//        HASH_TR: if(shake_pk_done) next_state = HASH_MU;
//        HASH_MU: if(shake_mu_done) next_state = SAMPLE_C;
//        SAMPLE_C: if(sample_done) next_state = NTT_OPS;
//        NTT_OPS: if(ntt_done) next_state = USE_HINT;
//        USE_HINT: if(usehint_done) next_state = ENCODE_W1;
//        ENCODE_W1: if(w1encode_done) next_state = HASH_CTILDE;
//        HASH_CTILDE: if(hashc_done) next_state = CHECKS;
//        CHECKS: next_state = DONE;
//        DONE: next_state = IDLE;
          default: current_state <= IDLE;
    endcase
end
end
// Module Instantiations
pkDecode pk_decoder (
    .clk(clk),
    .rst(rst),
    .start(initial_start),
    .pk(pk),
    .rho(rho),
    .t1(t1),
    .done(pk_decode_done)
);
    
sigdecode sig_decoder (
    .clk(clk),
    .start(sig_decode_start),
    .rst(rst),
    .sigma(sigma),
    .c_tilde(c_tilde),
    .z(z),
    .h(h),
    .valid(h_valid),
    .done(sig_decode_done)
);

ExpandA expand_A (
    .clk(clk),
    .rst(!expandA_start),
    .start(expandA_start),
    .rho(rho),
    .A(A_hat),
    .done(expandA_done)
);

sponge #(.d_len(d_len), .capacity(capacity), .r(r),
    .msg_len(msg_len_pk)) shake_pk (
    .clk(clk),
    .reset(!shake_pk_start),
    .start(shake_pk_start),
    .message(ShakeIn),
    .z(tr),
    .done(shake_pk_done)
);

sponge #(.d_len(mu_d_len), .capacity(mu_capacity), .r(mu_r),
    .msg_len(mu_msg_len)) shake_mu (
    .clk(clk),
    .reset(!shake_mu_start),
    .start(shake_mu_start),
    .message(mu_ShakeIn),
    .z(mu),
    .done(shake_mu_done)
);

Sample_in_ball #(.t(tau)) sample_c (
    .clk(clk),
    .rst(!sample_start),
    .start(sample_start),
    .in(c_tilde),
    .out(c_poly),
    .done(sample_done)
);

WApproxCalc ntt_ops (
    .clk(clk),
    .rst(!ntt_start),
    .start(ntt_start),
    .z(z),
    .t1(t1),
    .A(A_hat),
    .c(c_poly),
    .wApprox(w_approx),
    .done(ntt_done)
);

UseHint use_hint (
    .clk(clk),
    .reset(!usehint_start),
    .h(h),
    .r(w_approx),
    .r1v(w1_prime),
    .done(usehint_done)
);

w1encode w1_encoder (
    .clk(clk),
    .reset(!w1encode_start),
    .start(w1encode_start),
    .w1(w1_prime),
    .w1_hat(w1_encoded),
    .done(w1encode_done)
);

sponge #(.d_len(lambda*2),//lambda/4 =64bytes  then convert into 512 bits
         .capacity(mu_capacity),
         .r(mu_r),
         .msg_len(msg_len_c_tilde)  ) hash_c_tilde (
    .clk(clk),
    .reset(!hashc_start),
    .start(hashc_start),
    .message(ShakeIn_c_tilde),
    .z(c_tilde_prime),
    .done(hashc_done)
);

compute_infinity_norm norm_check (
    .clk(clk),
    .vector(z), //input
    .max_value(max_value_result),     //output
    .rst(!infinity_start),
    .done(infinity_done)
);

//    case(current_state)
////        DECODE_PK: pk_decode_start = 1;
////        DECODE_SIG: sig_decode_start = 1;
//        EXPAND_A: expandA_start = 1;
//        HASH_TR: shake_pk_start = 1;
//        HASH_MU: shake_mu_start = 1;
//        SAMPLE_C: sample_start = 1;
//        NTT_OPS: ntt_start = 1;
//        USE_HINT: usehint_start = 1;
//        ENCODE_W1: w1encode_start = 1;
//        HASH_CTILDE: hashc_start = 1;
//        CHECKS: begin
//            hash_match = (c_tilde_prime == c_tilde);
//            valid = norm_valid & hash_match;
//        end
//        DONE: valid = 0;
//    endcase
//end

endmodule
