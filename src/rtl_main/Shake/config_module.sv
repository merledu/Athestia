
/* verilator lint_off MULTITOP */
module config_module(
`define capacity 256
`define  rate    1600-`capacity
`define len_bitstring  1600
`define w  `len_bitstring/25 
`define l  $clog2(`w) 


);

endmodule
