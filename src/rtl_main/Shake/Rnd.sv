module Rnd (
    input  logic clk,
    input  logic rst,
    // input  logic start,                
    // output  logic valid,   
    input logic [32:0] round,             
    input  logic [63:0] A[4:0][4:0],   
    output logic [63:0] A_final[4:0][4:0] 
);

    
    logic [63:0] A_theta_prime[4:0][4:0];
    logic [63:0] A_rho_prime[4:0][4:0];
    logic [63:0] A_pi_prime[4:0][4:0];
    logic [63:0] A_X_prime[4:0][4:0];
    // logic valid_theta, valid_rho, valid_pi, valid_X;

    
    theta theta_inst (
        .clk(clk),
        .rst(rst),
        .A(A),                         
        .A_prime(A_theta_prime)       
        // .start(start),                 
        // .valid(valid_theta)            
    );

    
    rho rho_inst (
        .clk(clk),
        .rst(rst),
        .A(A_theta_prime), 
        .A_prime(A_rho_prime)
        // .start(valid_theta),  
        // .valid(valid_rho)     
    );

    // always_comb begin
    //    A_rho_prime[0][0] = A_theta_prime[0][0]; 
    // end

    pi pi_inst (
        .clk(clk),
        .rst(rst),
        .A(A_rho_prime), 
        .A_prime(A_pi_prime)
        // .start(valid_rho),
        // .valid(valid_pi)  
    );

    X X_inst (
        .clk(clk),
        .reset(rst),
        .A(A_pi_prime), 
        .Ab(A_X_prime)
        // .start(valid_pi),
        // .valid(valid_X)  
    );

    Iota Iota_inst (
        .clk(clk),
        .reset(rst),
        .round(round),
        .A(A_X_prime), 
        .Ab(A_final)
        // .start(valid_X),
        // .valid(valid)  
    );


    


    // valid = valid_X




endmodule

