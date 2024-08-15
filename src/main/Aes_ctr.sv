module Aes_ctr(
    /* verilator lint_off UNUSEDSIGNAL */
    input logic clk,
    input logic reset
);
    /* verilator lint_off WIDTHEXPAND */
    /* verilator lint_off VARHIDDEN */
    
    reg [7:0] src [0:7];  // 4-element array to hold 8-bit values
    reg [31:0] result;
    reg [31:0] v [0:1];
    reg [1:0] num;
    //reg [31:0] a [0:1];
    reg [31:0] b;
    reg [31:0] swap;
    reg [31:0] dst [0:7];
    reg [31:0] st [0:3];
    reg [31:0] enc;
    reg [63:0] a[0:7];
    

    initial begin
        src[0] = 8'h01;
        src[1] = 8'h02;
        src[2] = 8'h03;
        src[3] = 8'h04;
        src[4] = 8'h05;
        src[5] = 8'h06;
        src[6] = 8'h07;
        src[7] = 8'h08;
        v[0] = 0;
        v[1] = 0;
        st[0]=0;
        
        st[1]=0;
        st[2]=0;
        st[3]=0;
        swap = 32'h04;
        enc=32'h04;
         a[0]=0;
         a[1]=1;
         a[2]=2;
         a[3]=3;
         a[4]=4;
         a[5]=5;
         a[6]=6;
         a[7]=7;

        
        num=2;
         /* verilator lint_off IGNOREDRETURN */

        if (reset == 0) begin

           br_aes_ct64_bitslice_Sbox(a);
        end
    end

    function [31:0] brdecl32(input [7:0]  src_in [0:3]);  //not confirmed src_in size of list
        begin
            result = src_in[0] |
                       (src_in[1] << 8) |
                       (src_in[2] << 16) |
                       (src_in[3] << 24);
            return result;           
        end
    endfunction
  
    function [31:0] br_range_dec32le(output [31:0] v [0:1], input [7:0]  src_in [0:7], input [1:0] num );
        begin
            reg[0:0] i ;
            
          //  for (i = 0; i < 2; i = i + 1) begin
          //if ( num != 0 && reset==0) begin
               // reg[32:0] a;
              //  reg[32:0] b= i*4+4;
              v[0]=brdecl32(src_in[0:3]);
              v[1]=brdecl32(src_in[4:7]);
              return v;
                
            //  i=i+1;
             //num= num-1;

        end
    endfunction

    function [31:0]  br_swap32(input[31:0] x);
    begin 
    reg [31:0] cons = 32'h00FF00FF;
    reg [31:0] rslt;
    x = ((x & cons) << 8) | ((x >> 8) & cons);
    rslt= (x << 16) | (x >> 16);
    return rslt;
    end  
	
    endfunction

    function [31:0] brencl32( output [31:0] dst [0:3] , input[31:0] x);
    begin
        dst[0] = x;
	    dst[1] = x >> 8;
	    dst[2] = x >> 16;
	    dst[3] = x >> 24;
        
    end
    endfunction  

    function br_range_enc32le(output [31:0] dst [0:7],input[31:0] x);
    begin
        brencl32(dst[0:3],x);
        brencl32(dst[4:7],x+1);
        end    
    endfunction 
    function br_aes_ct64_bitslice_Sbox(input [63:0] q[0:7] );
    begin
    reg [63:0] x0, x1, x2, x3, x4, x5, x6, x7;
	reg [63:0] y1, y2, y3, y4, y5, y6, y7, y8, y9;
	reg [63:0] y10, y11, y12, y13, y14, y15, y16, y17, y18, y19;
	reg [63:0] y20, y21;
	reg [63:0] z0, z1, z2, z3, z4, z5, z6, z7, z8, z9;
	reg [63:0] z10, z11, z12, z13, z14, z15, z16, z17;
	reg [63:0] t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;
	reg [63:0] t10, t11, t12, t13, t14, t15, t16, t17, t18, t19;
	reg [63:0] t20, t21, t22, t23, t24, t25, t26, t27, t28, t29;
	reg [63:0] t30, t31, t32, t33, t34, t35, t36, t37, t38, t39;
	reg [63:0] t40, t41, t42, t43, t44, t45, t46, t47, t48, t49;
	reg [63:0] t50, t51, t52, t53, t54, t55, t56, t57, t58, t59;
	reg [63:0] t60, t61, t62, t63, t64, t65, t66, t67;
	reg[63:0] s0, s1, s2, s3, s4, s5, s6, s7;

	x0 = q[7];
	x1 = q[6];
	x2 = q[5];
	x3 = q[4];
	x4 = q[3];
	x5 = q[2];
	x6 = q[1];
	x7 = q[0];

	//** Top linear transformation.*/
	y14 = x3 ^ x5;
	y13 = x0 ^ x6;
	y9 = x0 ^ x3;
	y8 = x0 ^ x5;
	t0 = x1 ^ x2;
	y1 = t0 ^ x7;
	y4 = y1 ^ x3;
	y12 = y13 ^ y14;
	y2 = y1 ^ x0;
	y5 = y1 ^ x6;
	y3 = y5 ^ y8;
	t1 = x4 ^ y12;
	y15 = t1 ^ x5;
	y20 = t1 ^ x1;
	y6 = y15 ^ x7;
	y10 = y15 ^ t0;
	y11 = y20 ^ y9;
	y7 = x7 ^ y11;
	y17 = y10 ^ y11;
	y19 = y10 ^ y8;
	y16 = t0 ^ y11;
	y21 = y13 ^ y16;
	y18 = x0 ^ y16;

	/*
	 * Non-linear section.
	 */
	t2 = y12 & y15;
	t3 = y3 & y6;
	t4 = t3 ^ t2;
	t5 = y4 & x7;
	t6 = t5 ^ t2;
	t7 = y13 & y16;
	t8 = y5 & y1;
	t9 = t8 ^ t7;
	t10 = y2 & y7;
	t11 = t10 ^ t7;
	t12 = y9 & y11;
	t13 = y14 & y17;
	t14 = t13 ^ t12;
	t15 = y8 & y10;
	t16 = t15 ^ t12;
	t17 = t4 ^ t14;
	t18 = t6 ^ t16;
	t19 = t9 ^ t14;
	t20 = t11 ^ t16;
	t21 = t17 ^ y20;
	t22 = t18 ^ y19;
	t23 = t19 ^ y21;
	t24 = t20 ^ y18;

	t25 = t21 ^ t22;
	t26 = t21 & t23;
	t27 = t24 ^ t26;
	t28 = t25 & t27;
	t29 = t28 ^ t22;
	t30 = t23 ^ t24;
	t31 = t22 ^ t26;
	t32 = t31 & t30;
	t33 = t32 ^ t24;
	t34 = t23 ^ t33;
	t35 = t27 ^ t33;
	t36 = t24 & t35;
	t37 = t36 ^ t34;
	t38 = t27 ^ t36;
	t39 = t29 & t38;
	t40 = t25 ^ t39;

	t41 = t40 ^ t37;
	t42 = t29 ^ t33;
	t43 = t29 ^ t40;
	t44 = t33 ^ t37;
	t45 = t42 ^ t41;
	z0 = t44 & y15;
	z1 = t37 & y6;
	z2 = t33 & x7;
	z3 = t43 & y16;
	z4 = t40 & y1;
	z5 = t29 & y7;
	z6 = t42 & y11;
	z7 = t45 & y17;
	z8 = t41 & y10;
	z9 = t44 & y12;
	z10 = t37 & y3;
	z11 = t33 & y4;
	z12 = t43 & y13;
	z13 = t40 & y5;
	z14 = t29 & y2;
	z15 = t42 & y9;
	z16 = t45 & y14;
	z17 = t41 & y8;

	/*
	 * Bottom linear transformation.
	 */
	t46 = z15 ^ z16;
	t47 = z10 ^ z11;
	t48 = z5 ^ z13;
	t49 = z9 ^ z10;
	t50 = z2 ^ z12;
	t51 = z2 ^ z5;
	t52 = z7 ^ z8;
	t53 = z0 ^ z3;
	t54 = z6 ^ z7;
	t55 = z16 ^ z17;
	t56 = z12 ^ t48;
	t57 = t50 ^ t53;
	t58 = z4 ^ t46;
	t59 = z3 ^ t54;
	t60 = t46 ^ t57;
	t61 = z14 ^ t57;
	t62 = t52 ^ t58;
	t63 = t49 ^ t58;
	t64 = z4 ^ t59;
	t65 = t61 ^ t62;
	t66 = z1 ^ t63;
	s0 = t59 ^ t63;
    t62= ~t62;
	s6 = t56 ^ t62;
    t60 = ~t60;
	s7 = t48 ^ t60;
	t67 = t64 ^ t65;
	s3 = t53 ^ t66;
	s4 = t51 ^ t66;
	s5 = t47 ^ t65;
	s1 = t64 ^ s3;
    t67= ~t67;
	s2 = t55 ^ t67;

	q[7] = s0;
	q[6] = s1;
	q[5] = s2;
	q[4] = s3;
	q[3] = s4;
	q[2] = s5;
	q[1] = s6;
	q[0] = s7;

    
    end    
    endfunction       
    
      


       


  
endmodule
