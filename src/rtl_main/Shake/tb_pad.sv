module tb_pad10_1;

  localparam int x = 1088;
  logic [32:0] m;
  logic [x-1:0] p;

  pad10_1 #(x) uut (
    .m(m),
    .p(p)
  );

  initial begin

    m = 33'hD;

    #10;

    $display("Test case m = 0: p = %b", p);

    
    $finish;
  end

endmodule
