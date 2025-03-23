// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Thu Dec 19 18:34:40 2024
// Host        : DESKTOP-BTCAB43 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               E:/decompose_2/decompose_2.sim/sim_1/synth/func/xsim/Decompose_tb_func_synth.v
// Design      : Decompose
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* GAMMA = "261888" *) (* q = "8380417" *) (* r0_width = "32" *) 
(* r1_width = "32" *) (* width = "32" *) 
(* NotValidForBitStream *)
module Decompose
   (r,
    r1,
    r0);
  input [31:0]r;
  output [31:0]r1;
  output [31:0]r0;

  wire [13:1]data0;
  wire [18:10]p_0_in;
  wire [9:0]p_0_in__0;
  wire [31:0]r;
  wire [31:0]r0;
  wire [9:9]r0_OBUF;
  wire \r0_OBUF[31]_inst_i_2_n_0 ;
  wire \r0_OBUF[31]_inst_i_3_n_0 ;
  wire \r0_OBUF[31]_inst_i_4_n_0 ;
  wire \r0_OBUF[31]_inst_i_5_n_0 ;
  wire \r0_OBUF[31]_inst_i_6_n_0 ;
  wire \r0_OBUF[31]_inst_i_8_n_0 ;
  wire [31:0]r1;
  wire [13:1]r11;
  wire [0:0]r110_in;
  wire [23:1]r13;
  wire [14:0]r1_OBUF;
  wire \r1_OBUF[0]_inst_i_100_n_0 ;
  wire \r1_OBUF[0]_inst_i_101_n_0 ;
  wire \r1_OBUF[0]_inst_i_102_n_0 ;
  wire \r1_OBUF[0]_inst_i_103_n_0 ;
  wire \r1_OBUF[0]_inst_i_104_n_0 ;
  wire \r1_OBUF[0]_inst_i_105_n_0 ;
  wire \r1_OBUF[0]_inst_i_106_n_0 ;
  wire \r1_OBUF[0]_inst_i_107_n_0 ;
  wire \r1_OBUF[0]_inst_i_108_n_0 ;
  wire \r1_OBUF[0]_inst_i_108_n_1 ;
  wire \r1_OBUF[0]_inst_i_108_n_2 ;
  wire \r1_OBUF[0]_inst_i_108_n_3 ;
  wire \r1_OBUF[0]_inst_i_108_n_4 ;
  wire \r1_OBUF[0]_inst_i_108_n_5 ;
  wire \r1_OBUF[0]_inst_i_108_n_6 ;
  wire \r1_OBUF[0]_inst_i_109_n_0 ;
  wire \r1_OBUF[0]_inst_i_10_n_0 ;
  wire \r1_OBUF[0]_inst_i_110_n_0 ;
  wire \r1_OBUF[0]_inst_i_111_n_0 ;
  wire \r1_OBUF[0]_inst_i_112_n_0 ;
  wire \r1_OBUF[0]_inst_i_113_n_0 ;
  wire \r1_OBUF[0]_inst_i_114_n_0 ;
  wire \r1_OBUF[0]_inst_i_115_n_0 ;
  wire \r1_OBUF[0]_inst_i_116_n_0 ;
  wire \r1_OBUF[0]_inst_i_117_n_0 ;
  wire \r1_OBUF[0]_inst_i_118_n_0 ;
  wire \r1_OBUF[0]_inst_i_118_n_1 ;
  wire \r1_OBUF[0]_inst_i_118_n_2 ;
  wire \r1_OBUF[0]_inst_i_118_n_3 ;
  wire \r1_OBUF[0]_inst_i_118_n_4 ;
  wire \r1_OBUF[0]_inst_i_118_n_5 ;
  wire \r1_OBUF[0]_inst_i_118_n_6 ;
  wire \r1_OBUF[0]_inst_i_118_n_7 ;
  wire \r1_OBUF[0]_inst_i_119_n_0 ;
  wire \r1_OBUF[0]_inst_i_11_n_0 ;
  wire \r1_OBUF[0]_inst_i_120_n_0 ;
  wire \r1_OBUF[0]_inst_i_121_n_0 ;
  wire \r1_OBUF[0]_inst_i_121_n_1 ;
  wire \r1_OBUF[0]_inst_i_121_n_2 ;
  wire \r1_OBUF[0]_inst_i_121_n_3 ;
  wire \r1_OBUF[0]_inst_i_121_n_4 ;
  wire \r1_OBUF[0]_inst_i_121_n_5 ;
  wire \r1_OBUF[0]_inst_i_121_n_6 ;
  wire \r1_OBUF[0]_inst_i_121_n_7 ;
  wire \r1_OBUF[0]_inst_i_122_n_0 ;
  wire \r1_OBUF[0]_inst_i_123_n_0 ;
  wire \r1_OBUF[0]_inst_i_123_n_1 ;
  wire \r1_OBUF[0]_inst_i_123_n_2 ;
  wire \r1_OBUF[0]_inst_i_123_n_3 ;
  wire \r1_OBUF[0]_inst_i_123_n_4 ;
  wire \r1_OBUF[0]_inst_i_123_n_5 ;
  wire \r1_OBUF[0]_inst_i_123_n_6 ;
  wire \r1_OBUF[0]_inst_i_123_n_7 ;
  wire \r1_OBUF[0]_inst_i_124_n_0 ;
  wire \r1_OBUF[0]_inst_i_125_n_0 ;
  wire \r1_OBUF[0]_inst_i_126_n_0 ;
  wire \r1_OBUF[0]_inst_i_127_n_0 ;
  wire \r1_OBUF[0]_inst_i_128_n_0 ;
  wire \r1_OBUF[0]_inst_i_129_n_0 ;
  wire \r1_OBUF[0]_inst_i_12_n_0 ;
  wire \r1_OBUF[0]_inst_i_130_n_0 ;
  wire \r1_OBUF[0]_inst_i_131_n_0 ;
  wire \r1_OBUF[0]_inst_i_132_n_0 ;
  wire \r1_OBUF[0]_inst_i_133_n_0 ;
  wire \r1_OBUF[0]_inst_i_134_n_0 ;
  wire \r1_OBUF[0]_inst_i_135_n_0 ;
  wire \r1_OBUF[0]_inst_i_136_n_0 ;
  wire \r1_OBUF[0]_inst_i_137_n_0 ;
  wire \r1_OBUF[0]_inst_i_137_n_1 ;
  wire \r1_OBUF[0]_inst_i_137_n_2 ;
  wire \r1_OBUF[0]_inst_i_137_n_3 ;
  wire \r1_OBUF[0]_inst_i_138_n_0 ;
  wire \r1_OBUF[0]_inst_i_139_n_0 ;
  wire \r1_OBUF[0]_inst_i_13_n_0 ;
  wire \r1_OBUF[0]_inst_i_140_n_0 ;
  wire \r1_OBUF[0]_inst_i_141_n_0 ;
  wire \r1_OBUF[0]_inst_i_142_n_0 ;
  wire \r1_OBUF[0]_inst_i_142_n_1 ;
  wire \r1_OBUF[0]_inst_i_142_n_2 ;
  wire \r1_OBUF[0]_inst_i_142_n_3 ;
  wire \r1_OBUF[0]_inst_i_143_n_0 ;
  wire \r1_OBUF[0]_inst_i_144_n_0 ;
  wire \r1_OBUF[0]_inst_i_145_n_0 ;
  wire \r1_OBUF[0]_inst_i_146_n_0 ;
  wire \r1_OBUF[0]_inst_i_147_n_0 ;
  wire \r1_OBUF[0]_inst_i_148_n_0 ;
  wire \r1_OBUF[0]_inst_i_149_n_0 ;
  wire \r1_OBUF[0]_inst_i_14_n_0 ;
  wire \r1_OBUF[0]_inst_i_150_n_0 ;
  wire \r1_OBUF[0]_inst_i_151_n_0 ;
  wire \r1_OBUF[0]_inst_i_152_n_0 ;
  wire \r1_OBUF[0]_inst_i_153_n_0 ;
  wire \r1_OBUF[0]_inst_i_154_n_0 ;
  wire \r1_OBUF[0]_inst_i_155_n_0 ;
  wire \r1_OBUF[0]_inst_i_156_n_0 ;
  wire \r1_OBUF[0]_inst_i_157_n_0 ;
  wire \r1_OBUF[0]_inst_i_158_n_0 ;
  wire \r1_OBUF[0]_inst_i_159_n_0 ;
  wire \r1_OBUF[0]_inst_i_15_n_0 ;
  wire \r1_OBUF[0]_inst_i_160_n_0 ;
  wire \r1_OBUF[0]_inst_i_161_n_0 ;
  wire \r1_OBUF[0]_inst_i_161_n_1 ;
  wire \r1_OBUF[0]_inst_i_161_n_2 ;
  wire \r1_OBUF[0]_inst_i_161_n_3 ;
  wire \r1_OBUF[0]_inst_i_161_n_4 ;
  wire \r1_OBUF[0]_inst_i_161_n_5 ;
  wire \r1_OBUF[0]_inst_i_161_n_6 ;
  wire \r1_OBUF[0]_inst_i_162_n_0 ;
  wire \r1_OBUF[0]_inst_i_162_n_1 ;
  wire \r1_OBUF[0]_inst_i_162_n_2 ;
  wire \r1_OBUF[0]_inst_i_162_n_3 ;
  wire \r1_OBUF[0]_inst_i_162_n_4 ;
  wire \r1_OBUF[0]_inst_i_162_n_5 ;
  wire \r1_OBUF[0]_inst_i_162_n_6 ;
  wire \r1_OBUF[0]_inst_i_162_n_7 ;
  wire \r1_OBUF[0]_inst_i_163_n_0 ;
  wire \r1_OBUF[0]_inst_i_164_n_0 ;
  wire \r1_OBUF[0]_inst_i_165_n_0 ;
  wire \r1_OBUF[0]_inst_i_166_n_0 ;
  wire \r1_OBUF[0]_inst_i_167_n_0 ;
  wire \r1_OBUF[0]_inst_i_168_n_0 ;
  wire \r1_OBUF[0]_inst_i_169_n_0 ;
  wire \r1_OBUF[0]_inst_i_16_n_0 ;
  wire \r1_OBUF[0]_inst_i_16_n_1 ;
  wire \r1_OBUF[0]_inst_i_16_n_2 ;
  wire \r1_OBUF[0]_inst_i_16_n_3 ;
  wire \r1_OBUF[0]_inst_i_16_n_4 ;
  wire \r1_OBUF[0]_inst_i_16_n_5 ;
  wire \r1_OBUF[0]_inst_i_16_n_6 ;
  wire \r1_OBUF[0]_inst_i_16_n_7 ;
  wire \r1_OBUF[0]_inst_i_170_n_0 ;
  wire \r1_OBUF[0]_inst_i_171_n_0 ;
  wire \r1_OBUF[0]_inst_i_171_n_1 ;
  wire \r1_OBUF[0]_inst_i_171_n_2 ;
  wire \r1_OBUF[0]_inst_i_171_n_3 ;
  wire \r1_OBUF[0]_inst_i_171_n_4 ;
  wire \r1_OBUF[0]_inst_i_171_n_5 ;
  wire \r1_OBUF[0]_inst_i_171_n_6 ;
  wire \r1_OBUF[0]_inst_i_172_n_0 ;
  wire \r1_OBUF[0]_inst_i_173_n_0 ;
  wire \r1_OBUF[0]_inst_i_174_n_0 ;
  wire \r1_OBUF[0]_inst_i_175_n_0 ;
  wire \r1_OBUF[0]_inst_i_176_n_0 ;
  wire \r1_OBUF[0]_inst_i_177_n_0 ;
  wire \r1_OBUF[0]_inst_i_178_n_0 ;
  wire \r1_OBUF[0]_inst_i_179_n_0 ;
  wire \r1_OBUF[0]_inst_i_17_n_0 ;
  wire \r1_OBUF[0]_inst_i_180_n_0 ;
  wire \r1_OBUF[0]_inst_i_181_n_0 ;
  wire \r1_OBUF[0]_inst_i_182_n_0 ;
  wire \r1_OBUF[0]_inst_i_183_n_0 ;
  wire \r1_OBUF[0]_inst_i_184_n_0 ;
  wire \r1_OBUF[0]_inst_i_185_n_0 ;
  wire \r1_OBUF[0]_inst_i_186_n_0 ;
  wire \r1_OBUF[0]_inst_i_187_n_0 ;
  wire \r1_OBUF[0]_inst_i_188_n_0 ;
  wire \r1_OBUF[0]_inst_i_188_n_1 ;
  wire \r1_OBUF[0]_inst_i_188_n_2 ;
  wire \r1_OBUF[0]_inst_i_188_n_3 ;
  wire \r1_OBUF[0]_inst_i_188_n_4 ;
  wire \r1_OBUF[0]_inst_i_188_n_5 ;
  wire \r1_OBUF[0]_inst_i_188_n_6 ;
  wire \r1_OBUF[0]_inst_i_188_n_7 ;
  wire \r1_OBUF[0]_inst_i_189_n_0 ;
  wire \r1_OBUF[0]_inst_i_18_n_0 ;
  wire \r1_OBUF[0]_inst_i_190_n_0 ;
  wire \r1_OBUF[0]_inst_i_191_n_0 ;
  wire \r1_OBUF[0]_inst_i_192_n_0 ;
  wire \r1_OBUF[0]_inst_i_193_n_0 ;
  wire \r1_OBUF[0]_inst_i_194_n_0 ;
  wire \r1_OBUF[0]_inst_i_195_n_0 ;
  wire \r1_OBUF[0]_inst_i_196_n_0 ;
  wire \r1_OBUF[0]_inst_i_197_n_0 ;
  wire \r1_OBUF[0]_inst_i_198_n_0 ;
  wire \r1_OBUF[0]_inst_i_199_n_0 ;
  wire \r1_OBUF[0]_inst_i_19_n_0 ;
  wire \r1_OBUF[0]_inst_i_200_n_0 ;
  wire \r1_OBUF[0]_inst_i_201_n_0 ;
  wire \r1_OBUF[0]_inst_i_202_n_0 ;
  wire \r1_OBUF[0]_inst_i_203_n_0 ;
  wire \r1_OBUF[0]_inst_i_20_n_0 ;
  wire \r1_OBUF[0]_inst_i_21_n_0 ;
  wire \r1_OBUF[0]_inst_i_22_n_0 ;
  wire \r1_OBUF[0]_inst_i_22_n_1 ;
  wire \r1_OBUF[0]_inst_i_22_n_2 ;
  wire \r1_OBUF[0]_inst_i_22_n_3 ;
  wire \r1_OBUF[0]_inst_i_23_n_0 ;
  wire \r1_OBUF[0]_inst_i_24_n_0 ;
  wire \r1_OBUF[0]_inst_i_25_n_0 ;
  wire \r1_OBUF[0]_inst_i_26_n_0 ;
  wire \r1_OBUF[0]_inst_i_27_n_0 ;
  wire \r1_OBUF[0]_inst_i_27_n_1 ;
  wire \r1_OBUF[0]_inst_i_27_n_2 ;
  wire \r1_OBUF[0]_inst_i_27_n_3 ;
  wire \r1_OBUF[0]_inst_i_28_n_0 ;
  wire \r1_OBUF[0]_inst_i_29_n_0 ;
  wire \r1_OBUF[0]_inst_i_30_n_0 ;
  wire \r1_OBUF[0]_inst_i_31_n_0 ;
  wire \r1_OBUF[0]_inst_i_32_n_0 ;
  wire \r1_OBUF[0]_inst_i_33_n_0 ;
  wire \r1_OBUF[0]_inst_i_34_n_0 ;
  wire \r1_OBUF[0]_inst_i_35_n_0 ;
  wire \r1_OBUF[0]_inst_i_36_n_0 ;
  wire \r1_OBUF[0]_inst_i_36_n_1 ;
  wire \r1_OBUF[0]_inst_i_36_n_2 ;
  wire \r1_OBUF[0]_inst_i_36_n_3 ;
  wire \r1_OBUF[0]_inst_i_36_n_4 ;
  wire \r1_OBUF[0]_inst_i_36_n_5 ;
  wire \r1_OBUF[0]_inst_i_36_n_6 ;
  wire \r1_OBUF[0]_inst_i_36_n_7 ;
  wire \r1_OBUF[0]_inst_i_37_n_0 ;
  wire \r1_OBUF[0]_inst_i_38_n_0 ;
  wire \r1_OBUF[0]_inst_i_39_n_0 ;
  wire \r1_OBUF[0]_inst_i_3_n_0 ;
  wire \r1_OBUF[0]_inst_i_3_n_2 ;
  wire \r1_OBUF[0]_inst_i_3_n_3 ;
  wire \r1_OBUF[0]_inst_i_40_n_0 ;
  wire \r1_OBUF[0]_inst_i_41_n_0 ;
  wire \r1_OBUF[0]_inst_i_42_n_0 ;
  wire \r1_OBUF[0]_inst_i_43_n_0 ;
  wire \r1_OBUF[0]_inst_i_44_n_0 ;
  wire \r1_OBUF[0]_inst_i_45_n_2 ;
  wire \r1_OBUF[0]_inst_i_45_n_7 ;
  wire \r1_OBUF[0]_inst_i_46_n_0 ;
  wire \r1_OBUF[0]_inst_i_46_n_1 ;
  wire \r1_OBUF[0]_inst_i_46_n_2 ;
  wire \r1_OBUF[0]_inst_i_46_n_3 ;
  wire \r1_OBUF[0]_inst_i_46_n_4 ;
  wire \r1_OBUF[0]_inst_i_46_n_5 ;
  wire \r1_OBUF[0]_inst_i_46_n_6 ;
  wire \r1_OBUF[0]_inst_i_46_n_7 ;
  wire \r1_OBUF[0]_inst_i_47_n_2 ;
  wire \r1_OBUF[0]_inst_i_47_n_7 ;
  wire \r1_OBUF[0]_inst_i_48_n_0 ;
  wire \r1_OBUF[0]_inst_i_48_n_1 ;
  wire \r1_OBUF[0]_inst_i_48_n_2 ;
  wire \r1_OBUF[0]_inst_i_48_n_3 ;
  wire \r1_OBUF[0]_inst_i_48_n_4 ;
  wire \r1_OBUF[0]_inst_i_48_n_5 ;
  wire \r1_OBUF[0]_inst_i_48_n_6 ;
  wire \r1_OBUF[0]_inst_i_48_n_7 ;
  wire \r1_OBUF[0]_inst_i_49_n_0 ;
  wire \r1_OBUF[0]_inst_i_4_n_1 ;
  wire \r1_OBUF[0]_inst_i_4_n_2 ;
  wire \r1_OBUF[0]_inst_i_4_n_3 ;
  wire \r1_OBUF[0]_inst_i_50_n_0 ;
  wire \r1_OBUF[0]_inst_i_51_n_0 ;
  wire \r1_OBUF[0]_inst_i_51_n_1 ;
  wire \r1_OBUF[0]_inst_i_51_n_2 ;
  wire \r1_OBUF[0]_inst_i_51_n_3 ;
  wire \r1_OBUF[0]_inst_i_52_n_0 ;
  wire \r1_OBUF[0]_inst_i_53_n_0 ;
  wire \r1_OBUF[0]_inst_i_54_n_0 ;
  wire \r1_OBUF[0]_inst_i_55_n_0 ;
  wire \r1_OBUF[0]_inst_i_56_n_0 ;
  wire \r1_OBUF[0]_inst_i_56_n_1 ;
  wire \r1_OBUF[0]_inst_i_56_n_2 ;
  wire \r1_OBUF[0]_inst_i_56_n_3 ;
  wire \r1_OBUF[0]_inst_i_57_n_0 ;
  wire \r1_OBUF[0]_inst_i_58_n_0 ;
  wire \r1_OBUF[0]_inst_i_59_n_0 ;
  wire \r1_OBUF[0]_inst_i_5_n_2 ;
  wire \r1_OBUF[0]_inst_i_5_n_3 ;
  wire \r1_OBUF[0]_inst_i_5_n_5 ;
  wire \r1_OBUF[0]_inst_i_5_n_6 ;
  wire \r1_OBUF[0]_inst_i_5_n_7 ;
  wire \r1_OBUF[0]_inst_i_60_n_0 ;
  wire \r1_OBUF[0]_inst_i_61_n_0 ;
  wire \r1_OBUF[0]_inst_i_62_n_0 ;
  wire \r1_OBUF[0]_inst_i_63_n_0 ;
  wire \r1_OBUF[0]_inst_i_64_n_0 ;
  wire \r1_OBUF[0]_inst_i_65_n_0 ;
  wire \r1_OBUF[0]_inst_i_65_n_1 ;
  wire \r1_OBUF[0]_inst_i_65_n_2 ;
  wire \r1_OBUF[0]_inst_i_65_n_3 ;
  wire \r1_OBUF[0]_inst_i_65_n_4 ;
  wire \r1_OBUF[0]_inst_i_65_n_5 ;
  wire \r1_OBUF[0]_inst_i_65_n_6 ;
  wire \r1_OBUF[0]_inst_i_65_n_7 ;
  wire \r1_OBUF[0]_inst_i_66_n_0 ;
  wire \r1_OBUF[0]_inst_i_67_n_0 ;
  wire \r1_OBUF[0]_inst_i_68_n_0 ;
  wire \r1_OBUF[0]_inst_i_69_n_0 ;
  wire \r1_OBUF[0]_inst_i_6_n_0 ;
  wire \r1_OBUF[0]_inst_i_6_n_1 ;
  wire \r1_OBUF[0]_inst_i_6_n_2 ;
  wire \r1_OBUF[0]_inst_i_6_n_3 ;
  wire \r1_OBUF[0]_inst_i_70_n_0 ;
  wire \r1_OBUF[0]_inst_i_71_n_0 ;
  wire \r1_OBUF[0]_inst_i_72_n_0 ;
  wire \r1_OBUF[0]_inst_i_73_n_0 ;
  wire \r1_OBUF[0]_inst_i_74_n_0 ;
  wire \r1_OBUF[0]_inst_i_74_n_1 ;
  wire \r1_OBUF[0]_inst_i_74_n_2 ;
  wire \r1_OBUF[0]_inst_i_74_n_3 ;
  wire \r1_OBUF[0]_inst_i_74_n_4 ;
  wire \r1_OBUF[0]_inst_i_74_n_5 ;
  wire \r1_OBUF[0]_inst_i_74_n_6 ;
  wire \r1_OBUF[0]_inst_i_74_n_7 ;
  wire \r1_OBUF[0]_inst_i_75_n_0 ;
  wire \r1_OBUF[0]_inst_i_76_n_0 ;
  wire \r1_OBUF[0]_inst_i_77_n_0 ;
  wire \r1_OBUF[0]_inst_i_77_n_1 ;
  wire \r1_OBUF[0]_inst_i_77_n_2 ;
  wire \r1_OBUF[0]_inst_i_77_n_3 ;
  wire \r1_OBUF[0]_inst_i_77_n_4 ;
  wire \r1_OBUF[0]_inst_i_77_n_5 ;
  wire \r1_OBUF[0]_inst_i_77_n_6 ;
  wire \r1_OBUF[0]_inst_i_77_n_7 ;
  wire \r1_OBUF[0]_inst_i_78_n_0 ;
  wire \r1_OBUF[0]_inst_i_79_n_0 ;
  wire \r1_OBUF[0]_inst_i_79_n_1 ;
  wire \r1_OBUF[0]_inst_i_79_n_2 ;
  wire \r1_OBUF[0]_inst_i_79_n_3 ;
  wire \r1_OBUF[0]_inst_i_79_n_4 ;
  wire \r1_OBUF[0]_inst_i_79_n_5 ;
  wire \r1_OBUF[0]_inst_i_79_n_6 ;
  wire \r1_OBUF[0]_inst_i_79_n_7 ;
  wire \r1_OBUF[0]_inst_i_7_n_0 ;
  wire \r1_OBUF[0]_inst_i_80_n_0 ;
  wire \r1_OBUF[0]_inst_i_81_n_0 ;
  wire \r1_OBUF[0]_inst_i_82_n_0 ;
  wire \r1_OBUF[0]_inst_i_83_n_0 ;
  wire \r1_OBUF[0]_inst_i_84_n_0 ;
  wire \r1_OBUF[0]_inst_i_85_n_0 ;
  wire \r1_OBUF[0]_inst_i_86_n_0 ;
  wire \r1_OBUF[0]_inst_i_87_n_0 ;
  wire \r1_OBUF[0]_inst_i_88_n_0 ;
  wire \r1_OBUF[0]_inst_i_89_n_0 ;
  wire \r1_OBUF[0]_inst_i_8_n_0 ;
  wire \r1_OBUF[0]_inst_i_90_n_0 ;
  wire \r1_OBUF[0]_inst_i_91_n_0 ;
  wire \r1_OBUF[0]_inst_i_92_n_7 ;
  wire \r1_OBUF[0]_inst_i_93_n_0 ;
  wire \r1_OBUF[0]_inst_i_93_n_1 ;
  wire \r1_OBUF[0]_inst_i_93_n_2 ;
  wire \r1_OBUF[0]_inst_i_93_n_3 ;
  wire \r1_OBUF[0]_inst_i_94_n_0 ;
  wire \r1_OBUF[0]_inst_i_95_n_0 ;
  wire \r1_OBUF[0]_inst_i_96_n_0 ;
  wire \r1_OBUF[0]_inst_i_97_n_0 ;
  wire \r1_OBUF[0]_inst_i_98_n_0 ;
  wire \r1_OBUF[0]_inst_i_98_n_1 ;
  wire \r1_OBUF[0]_inst_i_98_n_2 ;
  wire \r1_OBUF[0]_inst_i_98_n_3 ;
  wire \r1_OBUF[0]_inst_i_99_n_0 ;
  wire \r1_OBUF[0]_inst_i_9_n_0 ;
  wire \r1_OBUF[0]_inst_i_9_n_1 ;
  wire \r1_OBUF[0]_inst_i_9_n_2 ;
  wire \r1_OBUF[0]_inst_i_9_n_3 ;
  wire \r1_OBUF[11]_inst_i_3_n_0 ;
  wire \r1_OBUF[11]_inst_i_3_n_1 ;
  wire \r1_OBUF[11]_inst_i_3_n_2 ;
  wire \r1_OBUF[11]_inst_i_3_n_3 ;
  wire \r1_OBUF[11]_inst_i_3_n_4 ;
  wire \r1_OBUF[11]_inst_i_3_n_5 ;
  wire \r1_OBUF[11]_inst_i_3_n_6 ;
  wire \r1_OBUF[11]_inst_i_3_n_7 ;
  wire \r1_OBUF[11]_inst_i_4_n_0 ;
  wire \r1_OBUF[11]_inst_i_4_n_1 ;
  wire \r1_OBUF[11]_inst_i_4_n_2 ;
  wire \r1_OBUF[11]_inst_i_4_n_3 ;
  wire \r1_OBUF[11]_inst_i_4_n_4 ;
  wire \r1_OBUF[11]_inst_i_4_n_5 ;
  wire \r1_OBUF[11]_inst_i_4_n_6 ;
  wire \r1_OBUF[11]_inst_i_4_n_7 ;
  wire \r1_OBUF[11]_inst_i_5_n_0 ;
  wire \r1_OBUF[11]_inst_i_6_n_0 ;
  wire \r1_OBUF[11]_inst_i_7_n_0 ;
  wire \r1_OBUF[11]_inst_i_8_n_0 ;
  wire \r1_OBUF[13]_inst_i_10_n_0 ;
  wire \r1_OBUF[13]_inst_i_10_n_1 ;
  wire \r1_OBUF[13]_inst_i_10_n_2 ;
  wire \r1_OBUF[13]_inst_i_10_n_3 ;
  wire \r1_OBUF[13]_inst_i_10_n_4 ;
  wire \r1_OBUF[13]_inst_i_10_n_5 ;
  wire \r1_OBUF[13]_inst_i_10_n_6 ;
  wire \r1_OBUF[13]_inst_i_10_n_7 ;
  wire \r1_OBUF[13]_inst_i_11_n_0 ;
  wire \r1_OBUF[13]_inst_i_12_n_0 ;
  wire \r1_OBUF[13]_inst_i_13_n_0 ;
  wire \r1_OBUF[13]_inst_i_14_n_0 ;
  wire \r1_OBUF[13]_inst_i_15_n_0 ;
  wire \r1_OBUF[13]_inst_i_16_n_0 ;
  wire \r1_OBUF[13]_inst_i_17_n_0 ;
  wire \r1_OBUF[13]_inst_i_18_n_0 ;
  wire \r1_OBUF[13]_inst_i_19_n_0 ;
  wire \r1_OBUF[13]_inst_i_3_n_0 ;
  wire \r1_OBUF[13]_inst_i_4_n_0 ;
  wire \r1_OBUF[13]_inst_i_5_n_2 ;
  wire \r1_OBUF[13]_inst_i_5_n_7 ;
  wire \r1_OBUF[13]_inst_i_6_n_0 ;
  wire \r1_OBUF[13]_inst_i_7_n_3 ;
  wire \r1_OBUF[13]_inst_i_7_n_6 ;
  wire \r1_OBUF[13]_inst_i_7_n_7 ;
  wire \r1_OBUF[13]_inst_i_8_n_0 ;
  wire \r1_OBUF[13]_inst_i_8_n_1 ;
  wire \r1_OBUF[13]_inst_i_8_n_2 ;
  wire \r1_OBUF[13]_inst_i_8_n_3 ;
  wire \r1_OBUF[13]_inst_i_8_n_4 ;
  wire \r1_OBUF[13]_inst_i_8_n_5 ;
  wire \r1_OBUF[13]_inst_i_8_n_6 ;
  wire \r1_OBUF[13]_inst_i_8_n_7 ;
  wire \r1_OBUF[13]_inst_i_9_n_0 ;
  wire \r1_OBUF[13]_inst_i_9_n_1 ;
  wire \r1_OBUF[13]_inst_i_9_n_2 ;
  wire \r1_OBUF[13]_inst_i_9_n_3 ;
  wire \r1_OBUF[13]_inst_i_9_n_4 ;
  wire \r1_OBUF[13]_inst_i_9_n_5 ;
  wire \r1_OBUF[13]_inst_i_9_n_6 ;
  wire \r1_OBUF[13]_inst_i_9_n_7 ;
  wire \r1_OBUF[31]_inst_i_100_n_0 ;
  wire \r1_OBUF[31]_inst_i_101_n_0 ;
  wire \r1_OBUF[31]_inst_i_102_n_0 ;
  wire \r1_OBUF[31]_inst_i_103_n_0 ;
  wire \r1_OBUF[31]_inst_i_104_n_0 ;
  wire \r1_OBUF[31]_inst_i_105_n_0 ;
  wire \r1_OBUF[31]_inst_i_105_n_1 ;
  wire \r1_OBUF[31]_inst_i_105_n_2 ;
  wire \r1_OBUF[31]_inst_i_105_n_3 ;
  wire \r1_OBUF[31]_inst_i_105_n_4 ;
  wire \r1_OBUF[31]_inst_i_105_n_5 ;
  wire \r1_OBUF[31]_inst_i_105_n_6 ;
  wire \r1_OBUF[31]_inst_i_106_n_0 ;
  wire \r1_OBUF[31]_inst_i_106_n_1 ;
  wire \r1_OBUF[31]_inst_i_106_n_2 ;
  wire \r1_OBUF[31]_inst_i_106_n_3 ;
  wire \r1_OBUF[31]_inst_i_106_n_4 ;
  wire \r1_OBUF[31]_inst_i_106_n_5 ;
  wire \r1_OBUF[31]_inst_i_106_n_6 ;
  wire \r1_OBUF[31]_inst_i_106_n_7 ;
  wire \r1_OBUF[31]_inst_i_107_n_0 ;
  wire \r1_OBUF[31]_inst_i_108_n_0 ;
  wire \r1_OBUF[31]_inst_i_109_n_2 ;
  wire \r1_OBUF[31]_inst_i_109_n_3 ;
  wire \r1_OBUF[31]_inst_i_109_n_5 ;
  wire \r1_OBUF[31]_inst_i_109_n_6 ;
  wire \r1_OBUF[31]_inst_i_10_n_0 ;
  wire \r1_OBUF[31]_inst_i_10_n_1 ;
  wire \r1_OBUF[31]_inst_i_10_n_2 ;
  wire \r1_OBUF[31]_inst_i_10_n_3 ;
  wire \r1_OBUF[31]_inst_i_110_n_3 ;
  wire \r1_OBUF[31]_inst_i_110_n_6 ;
  wire \r1_OBUF[31]_inst_i_110_n_7 ;
  wire \r1_OBUF[31]_inst_i_111_n_0 ;
  wire \r1_OBUF[31]_inst_i_112_n_0 ;
  wire \r1_OBUF[31]_inst_i_113_n_0 ;
  wire \r1_OBUF[31]_inst_i_114_n_0 ;
  wire \r1_OBUF[31]_inst_i_115_n_0 ;
  wire \r1_OBUF[31]_inst_i_116_n_0 ;
  wire \r1_OBUF[31]_inst_i_117_n_0 ;
  wire \r1_OBUF[31]_inst_i_118_n_0 ;
  wire \r1_OBUF[31]_inst_i_119_n_0 ;
  wire \r1_OBUF[31]_inst_i_11_n_0 ;
  wire \r1_OBUF[31]_inst_i_120_n_0 ;
  wire \r1_OBUF[31]_inst_i_121_n_0 ;
  wire \r1_OBUF[31]_inst_i_122_n_0 ;
  wire \r1_OBUF[31]_inst_i_123_n_0 ;
  wire \r1_OBUF[31]_inst_i_124_n_0 ;
  wire \r1_OBUF[31]_inst_i_125_n_0 ;
  wire \r1_OBUF[31]_inst_i_126_n_0 ;
  wire \r1_OBUF[31]_inst_i_127_n_0 ;
  wire \r1_OBUF[31]_inst_i_128_n_0 ;
  wire \r1_OBUF[31]_inst_i_129_n_0 ;
  wire \r1_OBUF[31]_inst_i_130_n_0 ;
  wire \r1_OBUF[31]_inst_i_131_n_0 ;
  wire \r1_OBUF[31]_inst_i_132_n_0 ;
  wire \r1_OBUF[31]_inst_i_133_n_0 ;
  wire \r1_OBUF[31]_inst_i_134_n_0 ;
  wire \r1_OBUF[31]_inst_i_135_n_0 ;
  wire \r1_OBUF[31]_inst_i_136_n_0 ;
  wire \r1_OBUF[31]_inst_i_137_n_0 ;
  wire \r1_OBUF[31]_inst_i_138_n_0 ;
  wire \r1_OBUF[31]_inst_i_139_n_0 ;
  wire \r1_OBUF[31]_inst_i_140_n_0 ;
  wire \r1_OBUF[31]_inst_i_141_n_0 ;
  wire \r1_OBUF[31]_inst_i_142_n_0 ;
  wire \r1_OBUF[31]_inst_i_143_n_7 ;
  wire \r1_OBUF[31]_inst_i_144_n_0 ;
  wire \r1_OBUF[31]_inst_i_14_n_0 ;
  wire \r1_OBUF[31]_inst_i_14_n_1 ;
  wire \r1_OBUF[31]_inst_i_14_n_2 ;
  wire \r1_OBUF[31]_inst_i_14_n_3 ;
  wire \r1_OBUF[31]_inst_i_14_n_4 ;
  wire \r1_OBUF[31]_inst_i_14_n_5 ;
  wire \r1_OBUF[31]_inst_i_14_n_6 ;
  wire \r1_OBUF[31]_inst_i_14_n_7 ;
  wire \r1_OBUF[31]_inst_i_16_n_0 ;
  wire \r1_OBUF[31]_inst_i_16_n_1 ;
  wire \r1_OBUF[31]_inst_i_16_n_2 ;
  wire \r1_OBUF[31]_inst_i_16_n_3 ;
  wire \r1_OBUF[31]_inst_i_16_n_4 ;
  wire \r1_OBUF[31]_inst_i_16_n_5 ;
  wire \r1_OBUF[31]_inst_i_16_n_6 ;
  wire \r1_OBUF[31]_inst_i_16_n_7 ;
  wire \r1_OBUF[31]_inst_i_17_n_0 ;
  wire \r1_OBUF[31]_inst_i_17_n_1 ;
  wire \r1_OBUF[31]_inst_i_17_n_2 ;
  wire \r1_OBUF[31]_inst_i_17_n_3 ;
  wire \r1_OBUF[31]_inst_i_17_n_5 ;
  wire \r1_OBUF[31]_inst_i_17_n_6 ;
  wire \r1_OBUF[31]_inst_i_17_n_7 ;
  wire \r1_OBUF[31]_inst_i_18_n_0 ;
  wire \r1_OBUF[31]_inst_i_18_n_1 ;
  wire \r1_OBUF[31]_inst_i_18_n_2 ;
  wire \r1_OBUF[31]_inst_i_18_n_3 ;
  wire \r1_OBUF[31]_inst_i_18_n_4 ;
  wire \r1_OBUF[31]_inst_i_18_n_5 ;
  wire \r1_OBUF[31]_inst_i_18_n_6 ;
  wire \r1_OBUF[31]_inst_i_18_n_7 ;
  wire \r1_OBUF[31]_inst_i_22_n_0 ;
  wire \r1_OBUF[31]_inst_i_22_n_1 ;
  wire \r1_OBUF[31]_inst_i_22_n_2 ;
  wire \r1_OBUF[31]_inst_i_22_n_3 ;
  wire \r1_OBUF[31]_inst_i_22_n_4 ;
  wire \r1_OBUF[31]_inst_i_22_n_5 ;
  wire \r1_OBUF[31]_inst_i_22_n_6 ;
  wire \r1_OBUF[31]_inst_i_22_n_7 ;
  wire \r1_OBUF[31]_inst_i_23_n_0 ;
  wire \r1_OBUF[31]_inst_i_23_n_1 ;
  wire \r1_OBUF[31]_inst_i_23_n_2 ;
  wire \r1_OBUF[31]_inst_i_23_n_3 ;
  wire \r1_OBUF[31]_inst_i_23_n_4 ;
  wire \r1_OBUF[31]_inst_i_23_n_5 ;
  wire \r1_OBUF[31]_inst_i_23_n_6 ;
  wire \r1_OBUF[31]_inst_i_23_n_7 ;
  wire \r1_OBUF[31]_inst_i_26_n_0 ;
  wire \r1_OBUF[31]_inst_i_27_n_0 ;
  wire \r1_OBUF[31]_inst_i_28_n_0 ;
  wire \r1_OBUF[31]_inst_i_29_n_0 ;
  wire \r1_OBUF[31]_inst_i_2_n_2 ;
  wire \r1_OBUF[31]_inst_i_2_n_7 ;
  wire \r1_OBUF[31]_inst_i_31_n_1 ;
  wire \r1_OBUF[31]_inst_i_31_n_2 ;
  wire \r1_OBUF[31]_inst_i_31_n_3 ;
  wire \r1_OBUF[31]_inst_i_31_n_4 ;
  wire \r1_OBUF[31]_inst_i_31_n_5 ;
  wire \r1_OBUF[31]_inst_i_31_n_6 ;
  wire \r1_OBUF[31]_inst_i_31_n_7 ;
  wire \r1_OBUF[31]_inst_i_32_n_0 ;
  wire \r1_OBUF[31]_inst_i_33_n_0 ;
  wire \r1_OBUF[31]_inst_i_34_n_0 ;
  wire \r1_OBUF[31]_inst_i_35_n_0 ;
  wire \r1_OBUF[31]_inst_i_38_n_0 ;
  wire \r1_OBUF[31]_inst_i_3_n_2 ;
  wire \r1_OBUF[31]_inst_i_40_n_0 ;
  wire \r1_OBUF[31]_inst_i_41_n_0 ;
  wire \r1_OBUF[31]_inst_i_42_n_0 ;
  wire \r1_OBUF[31]_inst_i_43_n_0 ;
  wire \r1_OBUF[31]_inst_i_43_n_1 ;
  wire \r1_OBUF[31]_inst_i_43_n_2 ;
  wire \r1_OBUF[31]_inst_i_43_n_3 ;
  wire \r1_OBUF[31]_inst_i_43_n_4 ;
  wire \r1_OBUF[31]_inst_i_43_n_5 ;
  wire \r1_OBUF[31]_inst_i_43_n_6 ;
  wire \r1_OBUF[31]_inst_i_43_n_7 ;
  wire \r1_OBUF[31]_inst_i_44_n_0 ;
  wire \r1_OBUF[31]_inst_i_45_n_0 ;
  wire \r1_OBUF[31]_inst_i_46_n_0 ;
  wire \r1_OBUF[31]_inst_i_47_n_0 ;
  wire \r1_OBUF[31]_inst_i_48_n_0 ;
  wire \r1_OBUF[31]_inst_i_49_n_0 ;
  wire \r1_OBUF[31]_inst_i_4_n_0 ;
  wire \r1_OBUF[31]_inst_i_50_n_0 ;
  wire \r1_OBUF[31]_inst_i_51_n_0 ;
  wire \r1_OBUF[31]_inst_i_52_n_0 ;
  wire \r1_OBUF[31]_inst_i_53_n_0 ;
  wire \r1_OBUF[31]_inst_i_54_n_0 ;
  wire \r1_OBUF[31]_inst_i_55_n_0 ;
  wire \r1_OBUF[31]_inst_i_56_n_0 ;
  wire \r1_OBUF[31]_inst_i_57_n_0 ;
  wire \r1_OBUF[31]_inst_i_57_n_1 ;
  wire \r1_OBUF[31]_inst_i_57_n_2 ;
  wire \r1_OBUF[31]_inst_i_57_n_3 ;
  wire \r1_OBUF[31]_inst_i_57_n_4 ;
  wire \r1_OBUF[31]_inst_i_57_n_5 ;
  wire \r1_OBUF[31]_inst_i_57_n_6 ;
  wire \r1_OBUF[31]_inst_i_57_n_7 ;
  wire \r1_OBUF[31]_inst_i_58_n_0 ;
  wire \r1_OBUF[31]_inst_i_59_n_0 ;
  wire \r1_OBUF[31]_inst_i_5_n_0 ;
  wire \r1_OBUF[31]_inst_i_60_n_0 ;
  wire \r1_OBUF[31]_inst_i_61_n_0 ;
  wire \r1_OBUF[31]_inst_i_62_n_0 ;
  wire \r1_OBUF[31]_inst_i_62_n_1 ;
  wire \r1_OBUF[31]_inst_i_62_n_2 ;
  wire \r1_OBUF[31]_inst_i_62_n_3 ;
  wire \r1_OBUF[31]_inst_i_62_n_4 ;
  wire \r1_OBUF[31]_inst_i_62_n_5 ;
  wire \r1_OBUF[31]_inst_i_62_n_6 ;
  wire \r1_OBUF[31]_inst_i_62_n_7 ;
  wire \r1_OBUF[31]_inst_i_63_n_0 ;
  wire \r1_OBUF[31]_inst_i_63_n_1 ;
  wire \r1_OBUF[31]_inst_i_63_n_2 ;
  wire \r1_OBUF[31]_inst_i_63_n_3 ;
  wire \r1_OBUF[31]_inst_i_63_n_4 ;
  wire \r1_OBUF[31]_inst_i_63_n_5 ;
  wire \r1_OBUF[31]_inst_i_63_n_6 ;
  wire \r1_OBUF[31]_inst_i_63_n_7 ;
  wire \r1_OBUF[31]_inst_i_64_n_0 ;
  wire \r1_OBUF[31]_inst_i_64_n_1 ;
  wire \r1_OBUF[31]_inst_i_64_n_2 ;
  wire \r1_OBUF[31]_inst_i_64_n_3 ;
  wire \r1_OBUF[31]_inst_i_64_n_4 ;
  wire \r1_OBUF[31]_inst_i_64_n_5 ;
  wire \r1_OBUF[31]_inst_i_64_n_6 ;
  wire \r1_OBUF[31]_inst_i_64_n_7 ;
  wire \r1_OBUF[31]_inst_i_65_n_1 ;
  wire \r1_OBUF[31]_inst_i_65_n_3 ;
  wire \r1_OBUF[31]_inst_i_65_n_6 ;
  wire \r1_OBUF[31]_inst_i_65_n_7 ;
  wire \r1_OBUF[31]_inst_i_66_n_0 ;
  wire \r1_OBUF[31]_inst_i_66_n_2 ;
  wire \r1_OBUF[31]_inst_i_66_n_3 ;
  wire \r1_OBUF[31]_inst_i_66_n_5 ;
  wire \r1_OBUF[31]_inst_i_66_n_6 ;
  wire \r1_OBUF[31]_inst_i_66_n_7 ;
  wire \r1_OBUF[31]_inst_i_67_n_0 ;
  wire \r1_OBUF[31]_inst_i_68_n_0 ;
  wire \r1_OBUF[31]_inst_i_69_n_0 ;
  wire \r1_OBUF[31]_inst_i_6_n_0 ;
  wire \r1_OBUF[31]_inst_i_70_n_0 ;
  wire \r1_OBUF[31]_inst_i_71_n_3 ;
  wire \r1_OBUF[31]_inst_i_71_n_6 ;
  wire \r1_OBUF[31]_inst_i_71_n_7 ;
  wire \r1_OBUF[31]_inst_i_72_n_0 ;
  wire \r1_OBUF[31]_inst_i_72_n_1 ;
  wire \r1_OBUF[31]_inst_i_72_n_2 ;
  wire \r1_OBUF[31]_inst_i_72_n_3 ;
  wire \r1_OBUF[31]_inst_i_72_n_4 ;
  wire \r1_OBUF[31]_inst_i_72_n_5 ;
  wire \r1_OBUF[31]_inst_i_72_n_6 ;
  wire \r1_OBUF[31]_inst_i_73_n_0 ;
  wire \r1_OBUF[31]_inst_i_74_n_0 ;
  wire \r1_OBUF[31]_inst_i_75_n_0 ;
  wire \r1_OBUF[31]_inst_i_76_n_0 ;
  wire \r1_OBUF[31]_inst_i_77_n_0 ;
  wire \r1_OBUF[31]_inst_i_78_n_1 ;
  wire \r1_OBUF[31]_inst_i_78_n_3 ;
  wire \r1_OBUF[31]_inst_i_78_n_6 ;
  wire \r1_OBUF[31]_inst_i_78_n_7 ;
  wire \r1_OBUF[31]_inst_i_79_n_0 ;
  wire \r1_OBUF[31]_inst_i_7_n_0 ;
  wire \r1_OBUF[31]_inst_i_80_n_0 ;
  wire \r1_OBUF[31]_inst_i_81_n_0 ;
  wire \r1_OBUF[31]_inst_i_82_n_1 ;
  wire \r1_OBUF[31]_inst_i_82_n_3 ;
  wire \r1_OBUF[31]_inst_i_82_n_6 ;
  wire \r1_OBUF[31]_inst_i_82_n_7 ;
  wire \r1_OBUF[31]_inst_i_83_n_0 ;
  wire \r1_OBUF[31]_inst_i_84_n_0 ;
  wire \r1_OBUF[31]_inst_i_85_n_0 ;
  wire \r1_OBUF[31]_inst_i_85_n_1 ;
  wire \r1_OBUF[31]_inst_i_85_n_2 ;
  wire \r1_OBUF[31]_inst_i_85_n_3 ;
  wire \r1_OBUF[31]_inst_i_85_n_4 ;
  wire \r1_OBUF[31]_inst_i_85_n_5 ;
  wire \r1_OBUF[31]_inst_i_85_n_6 ;
  wire \r1_OBUF[31]_inst_i_86_n_0 ;
  wire \r1_OBUF[31]_inst_i_87_n_0 ;
  wire \r1_OBUF[31]_inst_i_88_n_0 ;
  wire \r1_OBUF[31]_inst_i_89_n_0 ;
  wire \r1_OBUF[31]_inst_i_8_n_0 ;
  wire \r1_OBUF[31]_inst_i_8_n_1 ;
  wire \r1_OBUF[31]_inst_i_8_n_2 ;
  wire \r1_OBUF[31]_inst_i_8_n_3 ;
  wire \r1_OBUF[31]_inst_i_8_n_4 ;
  wire \r1_OBUF[31]_inst_i_8_n_5 ;
  wire \r1_OBUF[31]_inst_i_8_n_6 ;
  wire \r1_OBUF[31]_inst_i_8_n_7 ;
  wire \r1_OBUF[31]_inst_i_90_n_0 ;
  wire \r1_OBUF[31]_inst_i_91_n_0 ;
  wire \r1_OBUF[31]_inst_i_92_n_0 ;
  wire \r1_OBUF[31]_inst_i_93_n_0 ;
  wire \r1_OBUF[31]_inst_i_94_n_0 ;
  wire \r1_OBUF[31]_inst_i_95_n_0 ;
  wire \r1_OBUF[31]_inst_i_96_n_0 ;
  wire \r1_OBUF[31]_inst_i_97_n_0 ;
  wire \r1_OBUF[31]_inst_i_98_n_0 ;
  wire \r1_OBUF[31]_inst_i_99_n_0 ;
  wire \r1_OBUF[31]_inst_i_9_n_0 ;
  wire \r1_OBUF[3]_inst_i_10_n_0 ;
  wire \r1_OBUF[3]_inst_i_11_n_0 ;
  wire \r1_OBUF[3]_inst_i_12_n_0 ;
  wire \r1_OBUF[3]_inst_i_13_n_0 ;
  wire \r1_OBUF[3]_inst_i_14_n_0 ;
  wire \r1_OBUF[3]_inst_i_14_n_1 ;
  wire \r1_OBUF[3]_inst_i_14_n_2 ;
  wire \r1_OBUF[3]_inst_i_14_n_3 ;
  wire \r1_OBUF[3]_inst_i_15_n_0 ;
  wire \r1_OBUF[3]_inst_i_16_n_0 ;
  wire \r1_OBUF[3]_inst_i_17_n_0 ;
  wire \r1_OBUF[3]_inst_i_18_n_0 ;
  wire \r1_OBUF[3]_inst_i_19_n_0 ;
  wire \r1_OBUF[3]_inst_i_20_n_0 ;
  wire \r1_OBUF[3]_inst_i_21_n_0 ;
  wire \r1_OBUF[3]_inst_i_22_n_0 ;
  wire \r1_OBUF[3]_inst_i_23_n_0 ;
  wire \r1_OBUF[3]_inst_i_23_n_1 ;
  wire \r1_OBUF[3]_inst_i_23_n_2 ;
  wire \r1_OBUF[3]_inst_i_23_n_3 ;
  wire \r1_OBUF[3]_inst_i_24_n_0 ;
  wire \r1_OBUF[3]_inst_i_25_n_0 ;
  wire \r1_OBUF[3]_inst_i_26_n_0 ;
  wire \r1_OBUF[3]_inst_i_27_n_0 ;
  wire \r1_OBUF[3]_inst_i_28_n_0 ;
  wire \r1_OBUF[3]_inst_i_29_n_0 ;
  wire \r1_OBUF[3]_inst_i_30_n_0 ;
  wire \r1_OBUF[3]_inst_i_31_n_0 ;
  wire \r1_OBUF[3]_inst_i_32_n_0 ;
  wire \r1_OBUF[3]_inst_i_32_n_1 ;
  wire \r1_OBUF[3]_inst_i_32_n_2 ;
  wire \r1_OBUF[3]_inst_i_32_n_3 ;
  wire \r1_OBUF[3]_inst_i_33_n_0 ;
  wire \r1_OBUF[3]_inst_i_34_n_0 ;
  wire \r1_OBUF[3]_inst_i_35_n_0 ;
  wire \r1_OBUF[3]_inst_i_36_n_0 ;
  wire \r1_OBUF[3]_inst_i_37_n_0 ;
  wire \r1_OBUF[3]_inst_i_38_n_0 ;
  wire \r1_OBUF[3]_inst_i_39_n_0 ;
  wire \r1_OBUF[3]_inst_i_3_n_0 ;
  wire \r1_OBUF[3]_inst_i_3_n_1 ;
  wire \r1_OBUF[3]_inst_i_3_n_2 ;
  wire \r1_OBUF[3]_inst_i_3_n_3 ;
  wire \r1_OBUF[3]_inst_i_3_n_4 ;
  wire \r1_OBUF[3]_inst_i_3_n_5 ;
  wire \r1_OBUF[3]_inst_i_3_n_6 ;
  wire \r1_OBUF[3]_inst_i_3_n_7 ;
  wire \r1_OBUF[3]_inst_i_40_n_0 ;
  wire \r1_OBUF[3]_inst_i_41_n_0 ;
  wire \r1_OBUF[3]_inst_i_41_n_1 ;
  wire \r1_OBUF[3]_inst_i_41_n_2 ;
  wire \r1_OBUF[3]_inst_i_41_n_3 ;
  wire \r1_OBUF[3]_inst_i_42_n_0 ;
  wire \r1_OBUF[3]_inst_i_43_n_0 ;
  wire \r1_OBUF[3]_inst_i_44_n_0 ;
  wire \r1_OBUF[3]_inst_i_45_n_0 ;
  wire \r1_OBUF[3]_inst_i_46_n_0 ;
  wire \r1_OBUF[3]_inst_i_47_n_0 ;
  wire \r1_OBUF[3]_inst_i_48_n_0 ;
  wire \r1_OBUF[3]_inst_i_49_n_0 ;
  wire \r1_OBUF[3]_inst_i_4_n_0 ;
  wire \r1_OBUF[3]_inst_i_4_n_1 ;
  wire \r1_OBUF[3]_inst_i_4_n_2 ;
  wire \r1_OBUF[3]_inst_i_4_n_3 ;
  wire \r1_OBUF[3]_inst_i_4_n_4 ;
  wire \r1_OBUF[3]_inst_i_4_n_5 ;
  wire \r1_OBUF[3]_inst_i_4_n_6 ;
  wire \r1_OBUF[3]_inst_i_4_n_7 ;
  wire \r1_OBUF[3]_inst_i_50_n_0 ;
  wire \r1_OBUF[3]_inst_i_51_n_0 ;
  wire \r1_OBUF[3]_inst_i_52_n_0 ;
  wire \r1_OBUF[3]_inst_i_53_n_0 ;
  wire \r1_OBUF[3]_inst_i_54_n_0 ;
  wire \r1_OBUF[3]_inst_i_55_n_0 ;
  wire \r1_OBUF[3]_inst_i_56_n_0 ;
  wire \r1_OBUF[3]_inst_i_5_n_0 ;
  wire \r1_OBUF[3]_inst_i_5_n_1 ;
  wire \r1_OBUF[3]_inst_i_5_n_2 ;
  wire \r1_OBUF[3]_inst_i_5_n_3 ;
  wire \r1_OBUF[3]_inst_i_6_n_0 ;
  wire \r1_OBUF[3]_inst_i_7_n_0 ;
  wire \r1_OBUF[3]_inst_i_8_n_0 ;
  wire \r1_OBUF[3]_inst_i_9_n_0 ;
  wire \r1_OBUF[4]_inst_i_3_n_0 ;
  wire \r1_OBUF[4]_inst_i_3_n_1 ;
  wire \r1_OBUF[4]_inst_i_3_n_2 ;
  wire \r1_OBUF[4]_inst_i_3_n_3 ;
  wire \r1_OBUF[4]_inst_i_4_n_0 ;
  wire \r1_OBUF[4]_inst_i_5_n_0 ;
  wire \r1_OBUF[4]_inst_i_6_n_0 ;
  wire \r1_OBUF[4]_inst_i_7_n_0 ;
  wire \r1_OBUF[4]_inst_i_8_n_0 ;
  wire \r1_OBUF[7]_inst_i_3_n_0 ;
  wire \r1_OBUF[7]_inst_i_3_n_1 ;
  wire \r1_OBUF[7]_inst_i_3_n_2 ;
  wire \r1_OBUF[7]_inst_i_3_n_3 ;
  wire \r1_OBUF[7]_inst_i_3_n_4 ;
  wire \r1_OBUF[7]_inst_i_3_n_5 ;
  wire \r1_OBUF[7]_inst_i_3_n_6 ;
  wire \r1_OBUF[7]_inst_i_3_n_7 ;
  wire \r1_OBUF[7]_inst_i_4_n_0 ;
  wire \r1_OBUF[7]_inst_i_4_n_1 ;
  wire \r1_OBUF[7]_inst_i_4_n_2 ;
  wire \r1_OBUF[7]_inst_i_4_n_3 ;
  wire \r1_OBUF[7]_inst_i_4_n_4 ;
  wire \r1_OBUF[7]_inst_i_4_n_5 ;
  wire \r1_OBUF[7]_inst_i_4_n_6 ;
  wire \r1_OBUF[7]_inst_i_4_n_7 ;
  wire \r1_OBUF[7]_inst_i_5_n_0 ;
  wire \r1_OBUF[7]_inst_i_6_n_0 ;
  wire \r1_OBUF[7]_inst_i_7_n_0 ;
  wire \r1_OBUF[7]_inst_i_8_n_0 ;
  wire \r1_OBUF[8]_inst_i_3_n_0 ;
  wire \r1_OBUF[8]_inst_i_3_n_1 ;
  wire \r1_OBUF[8]_inst_i_3_n_2 ;
  wire \r1_OBUF[8]_inst_i_3_n_3 ;
  wire \r1_OBUF[8]_inst_i_4_n_0 ;
  wire \r1_OBUF[8]_inst_i_5_n_0 ;
  wire \r1_OBUF[8]_inst_i_6_n_0 ;
  wire \r1_OBUF[8]_inst_i_7_n_0 ;
  wire [31:0]r_IBUF;
  wire [0:0]\NLW_r1_OBUF[0]_inst_i_108_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_142_O_UNCONNECTED ;
  wire [0:0]\NLW_r1_OBUF[0]_inst_i_161_O_UNCONNECTED ;
  wire [0:0]\NLW_r1_OBUF[0]_inst_i_171_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_27_O_UNCONNECTED ;
  wire [2:2]\NLW_r1_OBUF[0]_inst_i_3_CO_UNCONNECTED ;
  wire [3:3]\NLW_r1_OBUF[0]_inst_i_3_O_UNCONNECTED ;
  wire [3:3]\NLW_r1_OBUF[0]_inst_i_4_CO_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_4_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_45_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[0]_inst_i_45_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_47_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[0]_inst_i_47_O_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[0]_inst_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_r1_OBUF[0]_inst_i_5_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_56_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_9_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_92_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[0]_inst_i_92_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[0]_inst_i_98_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[13]_inst_i_5_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[13]_inst_i_5_O_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[13]_inst_i_7_CO_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[13]_inst_i_7_O_UNCONNECTED ;
  wire [0:0]\NLW_r1_OBUF[31]_inst_i_105_O_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[31]_inst_i_109_CO_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[31]_inst_i_109_O_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_110_CO_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[31]_inst_i_110_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[31]_inst_i_143_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_143_O_UNCONNECTED ;
  wire [3:3]\NLW_r1_OBUF[31]_inst_i_17_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[31]_inst_i_2_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[31]_inst_i_3_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_3_O_UNCONNECTED ;
  wire [3:3]\NLW_r1_OBUF[31]_inst_i_31_CO_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_65_CO_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[31]_inst_i_65_O_UNCONNECTED ;
  wire [2:2]\NLW_r1_OBUF[31]_inst_i_66_CO_UNCONNECTED ;
  wire [3:3]\NLW_r1_OBUF[31]_inst_i_66_O_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_71_CO_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[31]_inst_i_71_O_UNCONNECTED ;
  wire [0:0]\NLW_r1_OBUF[31]_inst_i_72_O_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_78_CO_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[31]_inst_i_78_O_UNCONNECTED ;
  wire [3:1]\NLW_r1_OBUF[31]_inst_i_82_CO_UNCONNECTED ;
  wire [3:2]\NLW_r1_OBUF[31]_inst_i_82_O_UNCONNECTED ;
  wire [0:0]\NLW_r1_OBUF[31]_inst_i_85_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[3]_inst_i_14_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[3]_inst_i_23_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[3]_inst_i_32_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[3]_inst_i_41_O_UNCONNECTED ;
  wire [3:0]\NLW_r1_OBUF[3]_inst_i_5_O_UNCONNECTED ;

  OBUF \r0_OBUF[0]_inst 
       (.I(1'b0),
        .O(r0[0]));
  OBUF \r0_OBUF[10]_inst 
       (.I(1'b0),
        .O(r0[10]));
  OBUF \r0_OBUF[11]_inst 
       (.I(1'b1),
        .O(r0[11]));
  OBUF \r0_OBUF[12]_inst 
       (.I(1'b1),
        .O(r0[12]));
  OBUF \r0_OBUF[13]_inst 
       (.I(1'b1),
        .O(r0[13]));
  OBUF \r0_OBUF[14]_inst 
       (.I(1'b1),
        .O(r0[14]));
  OBUF \r0_OBUF[15]_inst 
       (.I(1'b1),
        .O(r0[15]));
  OBUF \r0_OBUF[16]_inst 
       (.I(1'b1),
        .O(r0[16]));
  OBUF \r0_OBUF[17]_inst 
       (.I(1'b1),
        .O(r0[17]));
  OBUF \r0_OBUF[18]_inst 
       (.I(1'b1),
        .O(r0[18]));
  OBUF \r0_OBUF[19]_inst 
       (.I(r0_OBUF),
        .O(r0[19]));
  OBUF \r0_OBUF[1]_inst 
       (.I(1'b0),
        .O(r0[1]));
  OBUF \r0_OBUF[20]_inst 
       (.I(r0_OBUF),
        .O(r0[20]));
  OBUF \r0_OBUF[21]_inst 
       (.I(r0_OBUF),
        .O(r0[21]));
  OBUF \r0_OBUF[22]_inst 
       (.I(r0_OBUF),
        .O(r0[22]));
  OBUF \r0_OBUF[23]_inst 
       (.I(r0_OBUF),
        .O(r0[23]));
  OBUF \r0_OBUF[24]_inst 
       (.I(r0_OBUF),
        .O(r0[24]));
  OBUF \r0_OBUF[25]_inst 
       (.I(r0_OBUF),
        .O(r0[25]));
  OBUF \r0_OBUF[26]_inst 
       (.I(r0_OBUF),
        .O(r0[26]));
  OBUF \r0_OBUF[27]_inst 
       (.I(r0_OBUF),
        .O(r0[27]));
  OBUF \r0_OBUF[28]_inst 
       (.I(r0_OBUF),
        .O(r0[28]));
  OBUF \r0_OBUF[29]_inst 
       (.I(r0_OBUF),
        .O(r0[29]));
  OBUF \r0_OBUF[2]_inst 
       (.I(1'b0),
        .O(r0[2]));
  OBUF \r0_OBUF[30]_inst 
       (.I(r0_OBUF),
        .O(r0[30]));
  OBUF \r0_OBUF[31]_inst 
       (.I(r0_OBUF),
        .O(r0[31]));
  LUT5 #(
    .INIT(32'h00000001)) 
    \r0_OBUF[31]_inst_i_1 
       (.I0(\r0_OBUF[31]_inst_i_2_n_0 ),
        .I1(\r0_OBUF[31]_inst_i_3_n_0 ),
        .I2(\r0_OBUF[31]_inst_i_4_n_0 ),
        .I3(\r0_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r0_OBUF[31]_inst_i_6_n_0 ),
        .O(r0_OBUF));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEFEA)) 
    \r0_OBUF[31]_inst_i_2 
       (.I0(p_0_in__0[3]),
        .I1(\r1_OBUF[31]_inst_i_16_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_18_n_5 ),
        .I4(p_0_in__0[5]),
        .I5(p_0_in__0[4]),
        .O(\r0_OBUF[31]_inst_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFDFD5)) 
    \r0_OBUF[31]_inst_i_3 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I4(p_0_in__0[1]),
        .I5(p_0_in__0[0]),
        .O(\r0_OBUF[31]_inst_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF7FFF)) 
    \r0_OBUF[31]_inst_i_4 
       (.I0(\r1_OBUF[13]_inst_i_10_n_5 ),
        .I1(\r1_OBUF[13]_inst_i_10_n_4 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_7 ),
        .I3(\r1_OBUF[13]_inst_i_10_n_6 ),
        .I4(\r0_OBUF[31]_inst_i_8_n_0 ),
        .O(\r0_OBUF[31]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEFEA)) 
    \r0_OBUF[31]_inst_i_5 
       (.I0(p_0_in__0[7]),
        .I1(\r1_OBUF[31]_inst_i_22_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_23_n_5 ),
        .I4(\r1_OBUF[31]_inst_i_14_n_5 ),
        .I5(p_0_in__0[8]),
        .O(\r0_OBUF[31]_inst_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \r0_OBUF[31]_inst_i_6 
       (.I0(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_14_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_14_n_4 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_7 ),
        .O(\r0_OBUF[31]_inst_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r0_OBUF[31]_inst_i_7 
       (.I0(\r1_OBUF[31]_inst_i_16_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_4 ),
        .O(p_0_in__0[3]));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \r0_OBUF[31]_inst_i_8 
       (.I0(\r1_OBUF[31]_inst_i_8_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_8_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I3(\r1_OBUF[31]_inst_i_8_n_5 ),
        .O(\r0_OBUF[31]_inst_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r0_OBUF[31]_inst_i_9 
       (.I0(\r1_OBUF[31]_inst_i_22_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_4 ),
        .O(p_0_in__0[7]));
  OBUF \r0_OBUF[3]_inst 
       (.I(1'b0),
        .O(r0[3]));
  OBUF \r0_OBUF[4]_inst 
       (.I(1'b0),
        .O(r0[4]));
  OBUF \r0_OBUF[5]_inst 
       (.I(1'b0),
        .O(r0[5]));
  OBUF \r0_OBUF[6]_inst 
       (.I(1'b0),
        .O(r0[6]));
  OBUF \r0_OBUF[7]_inst 
       (.I(1'b0),
        .O(r0[7]));
  OBUF \r0_OBUF[8]_inst 
       (.I(1'b0),
        .O(r0[8]));
  OBUF \r0_OBUF[9]_inst 
       (.I(r0_OBUF),
        .O(r0[9]));
  OBUF \r1_OBUF[0]_inst 
       (.I(r1_OBUF[0]),
        .O(r1[0]));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    \r1_OBUF[0]_inst_i_1 
       (.I0(r110_in),
        .I1(\r1_OBUF[31]_inst_i_4_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[0]));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_10 
       (.I0(\r1_OBUF[0]_inst_i_5_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_100 
       (.I0(\r1_OBUF[0]_inst_i_65_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_7 ),
        .I3(r13[18]),
        .O(\r1_OBUF[0]_inst_i_100_n_0 ));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_101 
       (.I0(\r1_OBUF[0]_inst_i_65_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_4 ),
        .I3(r13[17]),
        .O(\r1_OBUF[0]_inst_i_101_n_0 ));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_102 
       (.I0(\r1_OBUF[0]_inst_i_108_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_5 ),
        .I3(r13[16]),
        .O(\r1_OBUF[0]_inst_i_102_n_0 ));
  LUT6 #(
    .INIT(64'hE4FF1B001B00E4FF)) 
    \r1_OBUF[0]_inst_i_103 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[19]),
        .I2(\r1_OBUF[31]_inst_i_8_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_65_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_65_n_4 ),
        .I5(\r1_OBUF[0]_inst_i_151_n_0 ),
        .O(\r1_OBUF[0]_inst_i_103_n_0 ));
  LUT6 #(
    .INIT(64'h00E4FF1BFF1B00E4)) 
    \r1_OBUF[0]_inst_i_104 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[18]),
        .I2(\r1_OBUF[31]_inst_i_8_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_65_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_65_n_5 ),
        .I5(\r1_OBUF[3]_inst_i_34_n_0 ),
        .O(\r1_OBUF[0]_inst_i_104_n_0 ));
  LUT6 #(
    .INIT(64'hFF1B00E400E4FF1B)) 
    \r1_OBUF[0]_inst_i_105 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[17]),
        .I2(\r1_OBUF[13]_inst_i_10_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_65_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_65_n_6 ),
        .I5(\r1_OBUF[3]_inst_i_35_n_0 ),
        .O(\r1_OBUF[0]_inst_i_105_n_0 ));
  LUT6 #(
    .INIT(64'hFF1B00E400E4FF1B)) 
    \r1_OBUF[0]_inst_i_106 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[16]),
        .I2(\r1_OBUF[13]_inst_i_10_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_108_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_65_n_7 ),
        .I5(\r1_OBUF[3]_inst_i_36_n_0 ),
        .O(\r1_OBUF[0]_inst_i_106_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[0]_inst_i_107 
       (.I0(r13[21]),
        .I1(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_107_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_108 
       (.CI(1'b0),
        .CO({\r1_OBUF[0]_inst_i_108_n_0 ,\r1_OBUF[0]_inst_i_108_n_1 ,\r1_OBUF[0]_inst_i_108_n_2 ,\r1_OBUF[0]_inst_i_108_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_152_n_0 ,\r1_OBUF[0]_inst_i_153_n_0 ,\r1_OBUF[0]_inst_i_154_n_0 ,\r1_OBUF[0]_inst_i_155_n_0 }),
        .O({\r1_OBUF[0]_inst_i_108_n_4 ,\r1_OBUF[0]_inst_i_108_n_5 ,\r1_OBUF[0]_inst_i_108_n_6 ,\NLW_r1_OBUF[0]_inst_i_108_O_UNCONNECTED [0]}),
        .S({\r1_OBUF[0]_inst_i_156_n_0 ,\r1_OBUF[0]_inst_i_157_n_0 ,\r1_OBUF[0]_inst_i_158_n_0 ,\r1_OBUF[0]_inst_i_159_n_0 }));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_109 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_160_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_121_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_123_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_161_n_4 ),
        .O(\r1_OBUF[0]_inst_i_109_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_11 
       (.I0(\r1_OBUF[0]_inst_i_5_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_11_n_0 ));
  LUT5 #(
    .INIT(32'hE81717E8)) 
    \r1_OBUF[0]_inst_i_110 
       (.I0(\r1_OBUF[0]_inst_i_121_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_123_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_161_n_4 ),
        .I3(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_160_n_0 ),
        .O(\r1_OBUF[0]_inst_i_110_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \r1_OBUF[0]_inst_i_111 
       (.I0(\r1_OBUF[0]_inst_i_123_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_161_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_121_n_6 ),
        .I3(\r1_OBUF[3]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_111_n_0 ));
  (* HLUTNM = "lutpair0" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[0]_inst_i_112 
       (.I0(\r1_OBUF[0]_inst_i_161_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_123_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_162_n_4 ),
        .O(\r1_OBUF[0]_inst_i_112_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_113 
       (.I0(\r1_OBUF[0]_inst_i_109_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_122_n_0 ),
        .I2(\r1_OBUF[3]_inst_i_3_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_118_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_123_n_4 ),
        .I5(\r1_OBUF[0]_inst_i_121_n_5 ),
        .O(\r1_OBUF[0]_inst_i_113_n_0 ));
  LUT6 #(
    .INIT(64'h6999999699969666)) 
    \r1_OBUF[0]_inst_i_114 
       (.I0(\r1_OBUF[0]_inst_i_160_n_0 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_121_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_161_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_123_n_5 ),
        .I5(\r1_OBUF[3]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_114_n_0 ));
  LUT4 #(
    .INIT(16'h566A)) 
    \r1_OBUF[0]_inst_i_115 
       (.I0(\r1_OBUF[0]_inst_i_111_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_121_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_123_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_161_n_5 ),
        .O(\r1_OBUF[0]_inst_i_115_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \r1_OBUF[0]_inst_i_116 
       (.I0(\r1_OBUF[0]_inst_i_112_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_123_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_161_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_121_n_7 ),
        .O(\r1_OBUF[0]_inst_i_116_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_117 
       (.I0(\r1_OBUF[0]_inst_i_77_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_74_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_79_n_4 ),
        .O(\r1_OBUF[0]_inst_i_117_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_118 
       (.CI(\r1_OBUF[0]_inst_i_161_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_118_n_0 ,\r1_OBUF[0]_inst_i_118_n_1 ,\r1_OBUF[0]_inst_i_118_n_2 ,\r1_OBUF[0]_inst_i_118_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[7]_inst_i_3_n_7 ,\r1_OBUF[3]_inst_i_3_n_4 ,\r1_OBUF[3]_inst_i_3_n_5 ,\r1_OBUF[3]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_118_n_4 ,\r1_OBUF[0]_inst_i_118_n_5 ,\r1_OBUF[0]_inst_i_118_n_6 ,\r1_OBUF[0]_inst_i_118_n_7 }),
        .S({\r1_OBUF[0]_inst_i_163_n_0 ,\r1_OBUF[0]_inst_i_164_n_0 ,\r1_OBUF[0]_inst_i_165_n_0 ,\r1_OBUF[0]_inst_i_166_n_0 }));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_119 
       (.I0(\r1_OBUF[0]_inst_i_77_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_118_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_79_n_5 ),
        .O(\r1_OBUF[0]_inst_i_119_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_12 
       (.I0(\r1_OBUF[0]_inst_i_16_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_12_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_120 
       (.I0(\r1_OBUF[0]_inst_i_77_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_118_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_79_n_6 ),
        .O(\r1_OBUF[0]_inst_i_120_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_121 
       (.CI(\r1_OBUF[0]_inst_i_162_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_121_n_0 ,\r1_OBUF[0]_inst_i_121_n_1 ,\r1_OBUF[0]_inst_i_121_n_2 ,\r1_OBUF[0]_inst_i_121_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[11]_inst_i_3_n_7 ,\r1_OBUF[7]_inst_i_3_n_4 ,\r1_OBUF[7]_inst_i_3_n_5 ,\r1_OBUF[7]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_121_n_4 ,\r1_OBUF[0]_inst_i_121_n_5 ,\r1_OBUF[0]_inst_i_121_n_6 ,\r1_OBUF[0]_inst_i_121_n_7 }),
        .S({\r1_OBUF[0]_inst_i_167_n_0 ,\r1_OBUF[0]_inst_i_168_n_0 ,\r1_OBUF[0]_inst_i_169_n_0 ,\r1_OBUF[0]_inst_i_170_n_0 }));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_122 
       (.I0(\r1_OBUF[0]_inst_i_121_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_118_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_79_n_7 ),
        .O(\r1_OBUF[0]_inst_i_122_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_123 
       (.CI(\r1_OBUF[0]_inst_i_171_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_123_n_0 ,\r1_OBUF[0]_inst_i_123_n_1 ,\r1_OBUF[0]_inst_i_123_n_2 ,\r1_OBUF[0]_inst_i_123_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[7]_inst_i_3_n_7 ,\r1_OBUF[3]_inst_i_3_n_4 ,\r1_OBUF[3]_inst_i_3_n_5 ,\r1_OBUF[3]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_123_n_4 ,\r1_OBUF[0]_inst_i_123_n_5 ,\r1_OBUF[0]_inst_i_123_n_6 ,\r1_OBUF[0]_inst_i_123_n_7 }),
        .S({\r1_OBUF[0]_inst_i_172_n_0 ,\r1_OBUF[0]_inst_i_173_n_0 ,\r1_OBUF[0]_inst_i_174_n_0 ,\r1_OBUF[0]_inst_i_175_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_124 
       (.I0(\r1_OBUF[11]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_124_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_125 
       (.I0(\r1_OBUF[7]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_125_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_126 
       (.I0(\r1_OBUF[7]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_126_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_127 
       (.I0(\r1_OBUF[7]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_127_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_128 
       (.I0(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[0]_inst_i_128_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_129 
       (.I0(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_129_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_13 
       (.I0(\r1_OBUF[0]_inst_i_5_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_13_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_130 
       (.I0(\r1_OBUF[11]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[0]_inst_i_130_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_131 
       (.I0(\r1_OBUF[11]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[0]_inst_i_131_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_132 
       (.I0(\r1_OBUF[11]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_132_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_133 
       (.I0(\r1_OBUF[7]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_133_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_134 
       (.I0(\r1_OBUF[7]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_134_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_135 
       (.I0(\r1_OBUF[7]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_135_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_136 
       (.I0(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[0]_inst_i_136_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_137 
       (.CI(1'b0),
        .CO({\r1_OBUF[0]_inst_i_137_n_0 ,\r1_OBUF[0]_inst_i_137_n_1 ,\r1_OBUF[0]_inst_i_137_n_2 ,\r1_OBUF[0]_inst_i_137_n_3 }),
        .CYINIT(\r1_OBUF[0]_inst_i_176_n_0 ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r13[4:1]),
        .S({\r1_OBUF[0]_inst_i_177_n_0 ,\r1_OBUF[0]_inst_i_178_n_0 ,\r1_OBUF[0]_inst_i_179_n_0 ,\r1_OBUF[0]_inst_i_180_n_0 }));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_138 
       (.I0(\r1_OBUF[13]_inst_i_9_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_8_n_7 ),
        .O(\r1_OBUF[0]_inst_i_138_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_139 
       (.I0(\r1_OBUF[31]_inst_i_23_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_22_n_4 ),
        .O(\r1_OBUF[0]_inst_i_139_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_14 
       (.I0(\r1_OBUF[0]_inst_i_5_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_5_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_14_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_140 
       (.I0(\r1_OBUF[31]_inst_i_23_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_22_n_5 ),
        .O(\r1_OBUF[0]_inst_i_140_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_141 
       (.I0(\r1_OBUF[31]_inst_i_23_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_22_n_6 ),
        .O(\r1_OBUF[0]_inst_i_141_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_142 
       (.CI(1'b0),
        .CO({\r1_OBUF[0]_inst_i_142_n_0 ,\r1_OBUF[0]_inst_i_142_n_1 ,\r1_OBUF[0]_inst_i_142_n_2 ,\r1_OBUF[0]_inst_i_142_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_181_n_0 ,\r1_OBUF[0]_inst_i_182_n_0 ,\r1_OBUF[0]_inst_i_183_n_0 ,1'b0}),
        .O(\NLW_r1_OBUF[0]_inst_i_142_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[0]_inst_i_184_n_0 ,\r1_OBUF[0]_inst_i_185_n_0 ,\r1_OBUF[0]_inst_i_186_n_0 ,\r1_OBUF[0]_inst_i_187_n_0 }));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_143 
       (.I0(\r1_OBUF[0]_inst_i_108_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_6 ),
        .I3(r13[15]),
        .O(\r1_OBUF[0]_inst_i_143_n_0 ));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_144 
       (.I0(\r1_OBUF[0]_inst_i_108_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_7 ),
        .I3(r13[14]),
        .O(\r1_OBUF[0]_inst_i_144_n_0 ));
  LUT5 #(
    .INIT(32'h9666FFFF)) 
    \r1_OBUF[0]_inst_i_145 
       (.I0(\r1_OBUF[0]_inst_i_162_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_171_n_6 ),
        .I2(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I4(\r1_OBUF[3]_inst_i_45_n_0 ),
        .O(\r1_OBUF[0]_inst_i_145_n_0 ));
  LUT5 #(
    .INIT(32'h66F66FFF)) 
    \r1_OBUF[0]_inst_i_146 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I3(\r1_OBUF[31]_inst_i_14_n_5 ),
        .I4(r13[12]),
        .O(\r1_OBUF[0]_inst_i_146_n_0 ));
  LUT6 #(
    .INIT(64'hFF1B00E400E4FF1B)) 
    \r1_OBUF[0]_inst_i_147 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[15]),
        .I2(\r1_OBUF[13]_inst_i_10_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_108_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_108_n_4 ),
        .I5(\r1_OBUF[3]_inst_i_42_n_0 ),
        .O(\r1_OBUF[0]_inst_i_147_n_0 ));
  LUT6 #(
    .INIT(64'hFF1B00E400E4FF1B)) 
    \r1_OBUF[0]_inst_i_148 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[14]),
        .I2(\r1_OBUF[13]_inst_i_10_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_108_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_108_n_5 ),
        .I5(\r1_OBUF[3]_inst_i_43_n_0 ),
        .O(\r1_OBUF[0]_inst_i_148_n_0 ));
  LUT6 #(
    .INIT(64'hFF1B00E400E4FF1B)) 
    \r1_OBUF[0]_inst_i_149 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[13]),
        .I2(\r1_OBUF[31]_inst_i_14_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_189_n_0 ),
        .I4(\r1_OBUF[0]_inst_i_108_n_6 ),
        .I5(\r1_OBUF[3]_inst_i_44_n_0 ),
        .O(\r1_OBUF[0]_inst_i_149_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_15 
       (.I0(\r1_OBUF[0]_inst_i_16_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_5_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h956A6A956A95956A)) 
    \r1_OBUF[0]_inst_i_150 
       (.I0(\r1_OBUF[0]_inst_i_146_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I2(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_171_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_162_n_7 ),
        .I5(\r1_OBUF[3]_inst_i_45_n_0 ),
        .O(\r1_OBUF[0]_inst_i_150_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[0]_inst_i_151 
       (.I0(r13[20]),
        .I1(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_151_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[0]_inst_i_152 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_171_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_162_n_5 ),
        .O(\r1_OBUF[0]_inst_i_152_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r1_OBUF[0]_inst_i_153 
       (.I0(\r1_OBUF[0]_inst_i_171_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_162_n_6 ),
        .O(\r1_OBUF[0]_inst_i_153_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r1_OBUF[0]_inst_i_154 
       (.I0(\r1_OBUF[0]_inst_i_162_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_171_n_6 ),
        .O(\r1_OBUF[0]_inst_i_154_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r1_OBUF[0]_inst_i_155 
       (.I0(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_155_n_0 ));
  (* HLUTNM = "lutpair0" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \r1_OBUF[0]_inst_i_156 
       (.I0(\r1_OBUF[0]_inst_i_161_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_123_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_162_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_152_n_0 ),
        .O(\r1_OBUF[0]_inst_i_156_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \r1_OBUF[0]_inst_i_157 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_171_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_162_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_153_n_0 ),
        .O(\r1_OBUF[0]_inst_i_157_n_0 ));
  LUT4 #(
    .INIT(16'h9666)) 
    \r1_OBUF[0]_inst_i_158 
       (.I0(\r1_OBUF[0]_inst_i_171_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_162_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_162_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_171_n_6 ),
        .O(\r1_OBUF[0]_inst_i_158_n_0 ));
  LUT4 #(
    .INIT(16'h8778)) 
    \r1_OBUF[0]_inst_i_159 
       (.I0(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_171_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_162_n_7 ),
        .O(\r1_OBUF[0]_inst_i_159_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_16 
       (.CI(\r1_OBUF[0]_inst_i_36_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_16_n_0 ,\r1_OBUF[0]_inst_i_16_n_1 ,\r1_OBUF[0]_inst_i_16_n_2 ,\r1_OBUF[0]_inst_i_16_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_37_n_0 ,\r1_OBUF[0]_inst_i_38_n_0 ,\r1_OBUF[0]_inst_i_39_n_0 ,\r1_OBUF[0]_inst_i_40_n_0 }),
        .O({\r1_OBUF[0]_inst_i_16_n_4 ,\r1_OBUF[0]_inst_i_16_n_5 ,\r1_OBUF[0]_inst_i_16_n_6 ,\r1_OBUF[0]_inst_i_16_n_7 }),
        .S({\r1_OBUF[0]_inst_i_41_n_0 ,\r1_OBUF[0]_inst_i_42_n_0 ,\r1_OBUF[0]_inst_i_43_n_0 ,\r1_OBUF[0]_inst_i_44_n_0 }));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_160 
       (.I0(\r1_OBUF[0]_inst_i_121_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_118_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_123_n_4 ),
        .O(\r1_OBUF[0]_inst_i_160_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_161 
       (.CI(1'b0),
        .CO({\r1_OBUF[0]_inst_i_161_n_0 ,\r1_OBUF[0]_inst_i_161_n_1 ,\r1_OBUF[0]_inst_i_161_n_2 ,\r1_OBUF[0]_inst_i_161_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_3_n_7 ,1'b0,1'b0,1'b1}),
        .O({\r1_OBUF[0]_inst_i_161_n_4 ,\r1_OBUF[0]_inst_i_161_n_5 ,\r1_OBUF[0]_inst_i_161_n_6 ,\NLW_r1_OBUF[0]_inst_i_161_O_UNCONNECTED [0]}),
        .S({\r1_OBUF[0]_inst_i_190_n_0 ,\r1_OBUF[0]_inst_i_191_n_0 ,\r1_OBUF[0]_inst_i_192_n_0 ,\r1_OBUF[3]_inst_i_3_n_7 }));
  CARRY4 \r1_OBUF[0]_inst_i_162 
       (.CI(\r1_OBUF[0]_inst_i_188_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_162_n_0 ,\r1_OBUF[0]_inst_i_162_n_1 ,\r1_OBUF[0]_inst_i_162_n_2 ,\r1_OBUF[0]_inst_i_162_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[7]_inst_i_3_n_7 ,\r1_OBUF[3]_inst_i_3_n_4 ,\r1_OBUF[3]_inst_i_3_n_5 ,\r1_OBUF[3]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_162_n_4 ,\r1_OBUF[0]_inst_i_162_n_5 ,\r1_OBUF[0]_inst_i_162_n_6 ,\r1_OBUF[0]_inst_i_162_n_7 }),
        .S({\r1_OBUF[0]_inst_i_193_n_0 ,\r1_OBUF[0]_inst_i_194_n_0 ,\r1_OBUF[0]_inst_i_195_n_0 ,\r1_OBUF[0]_inst_i_196_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_163 
       (.I0(\r1_OBUF[7]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_163_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_164 
       (.I0(\r1_OBUF[3]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_164_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_165 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_165_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_166 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_166_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_167 
       (.I0(\r1_OBUF[11]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_167_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_168 
       (.I0(\r1_OBUF[7]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_168_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_169 
       (.I0(\r1_OBUF[7]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_169_n_0 ));
  LUT6 #(
    .INIT(64'hEBBE82BE82BE8228)) 
    \r1_OBUF[0]_inst_i_17 
       (.I0(\r1_OBUF[11]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_45_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_46_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I4(\r1_OBUF[0]_inst_i_45_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_46_n_6 ),
        .O(\r1_OBUF[0]_inst_i_17_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_170 
       (.I0(\r1_OBUF[7]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[11]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_170_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_171 
       (.CI(1'b0),
        .CO({\r1_OBUF[0]_inst_i_171_n_0 ,\r1_OBUF[0]_inst_i_171_n_1 ,\r1_OBUF[0]_inst_i_171_n_2 ,\r1_OBUF[0]_inst_i_171_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_3_n_7 ,1'b0,1'b0,1'b1}),
        .O({\r1_OBUF[0]_inst_i_171_n_4 ,\r1_OBUF[0]_inst_i_171_n_5 ,\r1_OBUF[0]_inst_i_171_n_6 ,\NLW_r1_OBUF[0]_inst_i_171_O_UNCONNECTED [0]}),
        .S({\r1_OBUF[0]_inst_i_197_n_0 ,\r1_OBUF[0]_inst_i_198_n_0 ,\r1_OBUF[0]_inst_i_199_n_0 ,\r1_OBUF[3]_inst_i_3_n_7 }));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_172 
       (.I0(\r1_OBUF[7]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_172_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_173 
       (.I0(\r1_OBUF[3]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_173_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_174 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_174_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_175 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_175_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_176 
       (.I0(\r1_OBUF[31]_inst_i_18_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_16_n_7 ),
        .O(\r1_OBUF[0]_inst_i_176_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_177 
       (.I0(\r1_OBUF[31]_inst_i_23_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_22_n_7 ),
        .O(\r1_OBUF[0]_inst_i_177_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_178 
       (.I0(\r1_OBUF[31]_inst_i_18_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_16_n_4 ),
        .O(\r1_OBUF[0]_inst_i_178_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_179 
       (.I0(\r1_OBUF[31]_inst_i_18_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_16_n_5 ),
        .O(\r1_OBUF[0]_inst_i_179_n_0 ));
  LUT6 #(
    .INIT(64'hBEEB28EB28EB2882)) 
    \r1_OBUF[0]_inst_i_18 
       (.I0(\r1_OBUF[11]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_45_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_46_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I4(\r1_OBUF[0]_inst_i_48_n_4 ),
        .I5(\r1_OBUF[0]_inst_i_46_n_7 ),
        .O(\r1_OBUF[0]_inst_i_18_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_180 
       (.I0(\r1_OBUF[31]_inst_i_18_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_16_n_6 ),
        .O(\r1_OBUF[0]_inst_i_180_n_0 ));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_181 
       (.I0(\r1_OBUF[0]_inst_i_188_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_14_n_6 ),
        .I3(r13[11]),
        .O(\r1_OBUF[0]_inst_i_181_n_0 ));
  LUT4 #(
    .INIT(16'hAEBF)) 
    \r1_OBUF[0]_inst_i_182 
       (.I0(\r1_OBUF[0]_inst_i_188_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I3(r13[10]),
        .O(\r1_OBUF[0]_inst_i_182_n_0 ));
  LUT6 #(
    .INIT(64'hCCCEEECEDDDFFFDF)) 
    \r1_OBUF[0]_inst_i_183 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_188_n_7 ),
        .I2(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I5(r13[9]),
        .O(\r1_OBUF[0]_inst_i_183_n_0 ));
  LUT6 #(
    .INIT(64'h3CC369969669C33C)) 
    \r1_OBUF[0]_inst_i_184 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_181_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I3(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I4(r13[12]),
        .I5(\r1_OBUF[31]_inst_i_14_n_5 ),
        .O(\r1_OBUF[0]_inst_i_184_n_0 ));
  LUT6 #(
    .INIT(64'hFF1B00E400E4FF1B)) 
    \r1_OBUF[0]_inst_i_185 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[10]),
        .I2(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_188_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_188_n_5 ),
        .I5(\r1_OBUF[3]_inst_i_51_n_0 ),
        .O(\r1_OBUF[0]_inst_i_185_n_0 ));
  LUT6 #(
    .INIT(64'hF30CA65959A60CF3)) 
    \r1_OBUF[0]_inst_i_186 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_200_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_188_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_188_n_6 ),
        .I4(r13[10]),
        .I5(\r1_OBUF[31]_inst_i_14_n_7 ),
        .O(\r1_OBUF[0]_inst_i_186_n_0 ));
  LUT6 #(
    .INIT(64'h02A257F7FD5DA808)) 
    \r1_OBUF[0]_inst_i_187 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I4(r13[9]),
        .I5(\r1_OBUF[0]_inst_i_188_n_7 ),
        .O(\r1_OBUF[0]_inst_i_187_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_188 
       (.CI(1'b0),
        .CO({\r1_OBUF[0]_inst_i_188_n_0 ,\r1_OBUF[0]_inst_i_188_n_1 ,\r1_OBUF[0]_inst_i_188_n_2 ,\r1_OBUF[0]_inst_i_188_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_3_n_7 ,1'b0,1'b0,1'b1}),
        .O({\r1_OBUF[0]_inst_i_188_n_4 ,\r1_OBUF[0]_inst_i_188_n_5 ,\r1_OBUF[0]_inst_i_188_n_6 ,\r1_OBUF[0]_inst_i_188_n_7 }),
        .S({\r1_OBUF[0]_inst_i_201_n_0 ,\r1_OBUF[0]_inst_i_202_n_0 ,\r1_OBUF[0]_inst_i_203_n_0 ,\r1_OBUF[3]_inst_i_3_n_7 }));
  LUT4 #(
    .INIT(16'h8778)) 
    \r1_OBUF[0]_inst_i_189 
       (.I0(\r1_OBUF[0]_inst_i_188_n_4 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_171_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_162_n_7 ),
        .O(\r1_OBUF[0]_inst_i_189_n_0 ));
  LUT6 #(
    .INIT(64'h1C40FDC7E3BF0238)) 
    \r1_OBUF[0]_inst_i_19 
       (.I0(\r1_OBUF[0]_inst_i_46_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_46_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_45_n_2 ),
        .I4(\r1_OBUF[13]_inst_i_5_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_49_n_0 ),
        .O(\r1_OBUF[0]_inst_i_19_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_190 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_190_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_191 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_191_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_192 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_192_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_193 
       (.I0(\r1_OBUF[7]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_193_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_194 
       (.I0(\r1_OBUF[3]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_194_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_195 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_195_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_196 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[7]_inst_i_3_n_7 ),
        .O(\r1_OBUF[0]_inst_i_196_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_197 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_197_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_198 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_198_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_199 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_199_n_0 ));
  LUT6 #(
    .INIT(64'hF0F1F0FFF0E0F000)) 
    \r1_OBUF[0]_inst_i_2 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I4(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I5(\r1_OBUF[3]_inst_i_4_n_7 ),
        .O(r110_in));
  LUT6 #(
    .INIT(64'hA5965A69965A69A5)) 
    \r1_OBUF[0]_inst_i_20 
       (.I0(\r1_OBUF[0]_inst_i_17_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_45_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_46_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I4(\r1_OBUF[13]_inst_i_5_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_46_n_5 ),
        .O(\r1_OBUF[0]_inst_i_20_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[0]_inst_i_200 
       (.I0(r13[9]),
        .I1(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_200_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_201 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[3]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_201_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_202 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .O(\r1_OBUF[0]_inst_i_202_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_203 
       (.I0(\r1_OBUF[3]_inst_i_3_n_6 ),
        .O(\r1_OBUF[0]_inst_i_203_n_0 ));
  LUT6 #(
    .INIT(64'h6996969669696996)) 
    \r1_OBUF[0]_inst_i_21 
       (.I0(\r1_OBUF[0]_inst_i_18_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_50_n_0 ),
        .I2(\r1_OBUF[11]_inst_i_3_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_46_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_45_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_47_n_2 ),
        .O(\r1_OBUF[0]_inst_i_21_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_22 
       (.CI(\r1_OBUF[0]_inst_i_51_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_22_n_0 ,\r1_OBUF[0]_inst_i_22_n_1 ,\r1_OBUF[0]_inst_i_22_n_2 ,\r1_OBUF[0]_inst_i_22_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r13[16:13]),
        .S({\r1_OBUF[0]_inst_i_52_n_0 ,\r1_OBUF[0]_inst_i_53_n_0 ,\r1_OBUF[0]_inst_i_54_n_0 ,\r1_OBUF[0]_inst_i_55_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_23 
       (.I0(\r1_OBUF[31]_inst_i_8_n_5 ),
        .O(\r1_OBUF[0]_inst_i_23_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_24 
       (.I0(\r1_OBUF[31]_inst_i_8_n_6 ),
        .O(\r1_OBUF[0]_inst_i_24_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_25 
       (.I0(\r1_OBUF[31]_inst_i_8_n_7 ),
        .O(\r1_OBUF[0]_inst_i_25_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_26 
       (.I0(\r1_OBUF[13]_inst_i_10_n_4 ),
        .O(\r1_OBUF[0]_inst_i_26_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_27 
       (.CI(\r1_OBUF[0]_inst_i_56_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_27_n_0 ,\r1_OBUF[0]_inst_i_27_n_1 ,\r1_OBUF[0]_inst_i_27_n_2 ,\r1_OBUF[0]_inst_i_27_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_57_n_0 ,\r1_OBUF[0]_inst_i_58_n_0 ,\r1_OBUF[0]_inst_i_59_n_0 ,\r1_OBUF[0]_inst_i_60_n_0 }),
        .O(\NLW_r1_OBUF[0]_inst_i_27_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[0]_inst_i_61_n_0 ,\r1_OBUF[0]_inst_i_62_n_0 ,\r1_OBUF[0]_inst_i_63_n_0 ,\r1_OBUF[0]_inst_i_64_n_0 }));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_28 
       (.I0(\r1_OBUF[0]_inst_i_16_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_28_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_29 
       (.I0(\r1_OBUF[0]_inst_i_16_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_29_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_3 
       (.CI(\r1_OBUF[0]_inst_i_6_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_3_n_0 ,\NLW_r1_OBUF[0]_inst_i_3_CO_UNCONNECTED [2],\r1_OBUF[0]_inst_i_3_n_2 ,\r1_OBUF[0]_inst_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b1,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[0]_inst_i_3_O_UNCONNECTED [3],r13[23:21]}),
        .S({1'b1,\r1_OBUF[31]_inst_i_2_n_2 ,\r1_OBUF[0]_inst_i_7_n_0 ,\r1_OBUF[0]_inst_i_8_n_0 }));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_30 
       (.I0(\r1_OBUF[0]_inst_i_16_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_30_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \r1_OBUF[0]_inst_i_31 
       (.I0(\r1_OBUF[0]_inst_i_36_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .O(\r1_OBUF[0]_inst_i_31_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_32 
       (.I0(\r1_OBUF[0]_inst_i_16_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_16_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_32_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_33 
       (.I0(\r1_OBUF[0]_inst_i_16_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_16_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_33_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_34 
       (.I0(\r1_OBUF[0]_inst_i_16_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_16_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_34_n_0 ));
  LUT4 #(
    .INIT(16'h999C)) 
    \r1_OBUF[0]_inst_i_35 
       (.I0(\r1_OBUF[0]_inst_i_36_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_16_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_35_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_36 
       (.CI(\r1_OBUF[0]_inst_i_65_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_36_n_0 ,\r1_OBUF[0]_inst_i_36_n_1 ,\r1_OBUF[0]_inst_i_36_n_2 ,\r1_OBUF[0]_inst_i_36_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_66_n_0 ,\r1_OBUF[0]_inst_i_67_n_0 ,\r1_OBUF[0]_inst_i_68_n_0 ,\r1_OBUF[0]_inst_i_69_n_0 }),
        .O({\r1_OBUF[0]_inst_i_36_n_4 ,\r1_OBUF[0]_inst_i_36_n_5 ,\r1_OBUF[0]_inst_i_36_n_6 ,\r1_OBUF[0]_inst_i_36_n_7 }),
        .S({\r1_OBUF[0]_inst_i_70_n_0 ,\r1_OBUF[0]_inst_i_71_n_0 ,\r1_OBUF[0]_inst_i_72_n_0 ,\r1_OBUF[0]_inst_i_73_n_0 }));
  LUT6 #(
    .INIT(64'hBEEB28EB28EB2882)) 
    \r1_OBUF[0]_inst_i_37 
       (.I0(\r1_OBUF[11]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_48_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_46_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I4(\r1_OBUF[0]_inst_i_48_n_5 ),
        .I5(\r1_OBUF[0]_inst_i_74_n_4 ),
        .O(\r1_OBUF[0]_inst_i_37_n_0 ));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_38 
       (.I0(\r1_OBUF[11]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_75_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_47_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_48_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_74_n_5 ),
        .O(\r1_OBUF[0]_inst_i_38_n_0 ));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_39 
       (.I0(\r1_OBUF[7]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_76_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_77_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_48_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_74_n_6 ),
        .O(\r1_OBUF[0]_inst_i_39_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_4 
       (.CI(\r1_OBUF[0]_inst_i_9_n_0 ),
        .CO({\NLW_r1_OBUF[0]_inst_i_4_CO_UNCONNECTED [3],\r1_OBUF[0]_inst_i_4_n_1 ,\r1_OBUF[0]_inst_i_4_n_2 ,\r1_OBUF[0]_inst_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\r1_OBUF[0]_inst_i_10_n_0 ,\r1_OBUF[0]_inst_i_11_n_0 ,\r1_OBUF[0]_inst_i_12_n_0 }),
        .O(\NLW_r1_OBUF[0]_inst_i_4_O_UNCONNECTED [3:0]),
        .S({1'b0,\r1_OBUF[0]_inst_i_13_n_0 ,\r1_OBUF[0]_inst_i_14_n_0 ,\r1_OBUF[0]_inst_i_15_n_0 }));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_40 
       (.I0(\r1_OBUF[7]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_78_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_77_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_79_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_74_n_7 ),
        .O(\r1_OBUF[0]_inst_i_40_n_0 ));
  LUT6 #(
    .INIT(64'h6996969669696996)) 
    \r1_OBUF[0]_inst_i_41 
       (.I0(\r1_OBUF[0]_inst_i_37_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_80_n_0 ),
        .I2(\r1_OBUF[11]_inst_i_3_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_46_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_48_n_4 ),
        .I5(\r1_OBUF[0]_inst_i_47_n_2 ),
        .O(\r1_OBUF[0]_inst_i_41_n_0 ));
  LUT6 #(
    .INIT(64'h6996969669696996)) 
    \r1_OBUF[0]_inst_i_42 
       (.I0(\r1_OBUF[0]_inst_i_38_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_81_n_0 ),
        .I2(\r1_OBUF[11]_inst_i_3_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_74_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_48_n_5 ),
        .I5(\r1_OBUF[0]_inst_i_47_n_2 ),
        .O(\r1_OBUF[0]_inst_i_42_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_43 
       (.I0(\r1_OBUF[0]_inst_i_39_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_75_n_0 ),
        .I2(\r1_OBUF[11]_inst_i_3_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_74_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_48_n_6 ),
        .I5(\r1_OBUF[0]_inst_i_47_n_7 ),
        .O(\r1_OBUF[0]_inst_i_43_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_44 
       (.I0(\r1_OBUF[0]_inst_i_40_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_76_n_0 ),
        .I2(\r1_OBUF[7]_inst_i_3_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_74_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_48_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_77_n_4 ),
        .O(\r1_OBUF[0]_inst_i_44_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_45 
       (.CI(\r1_OBUF[0]_inst_i_48_n_0 ),
        .CO({\NLW_r1_OBUF[0]_inst_i_45_CO_UNCONNECTED [3:2],\r1_OBUF[0]_inst_i_45_n_2 ,\NLW_r1_OBUF[0]_inst_i_45_CO_UNCONNECTED [0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\r1_OBUF[13]_inst_i_5_n_2 }),
        .O({\NLW_r1_OBUF[0]_inst_i_45_O_UNCONNECTED [3:1],\r1_OBUF[0]_inst_i_45_n_7 }),
        .S({1'b0,1'b0,1'b1,\r1_OBUF[0]_inst_i_82_n_0 }));
  CARRY4 \r1_OBUF[0]_inst_i_46 
       (.CI(\r1_OBUF[0]_inst_i_74_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_46_n_0 ,\r1_OBUF[0]_inst_i_46_n_1 ,\r1_OBUF[0]_inst_i_46_n_2 ,\r1_OBUF[0]_inst_i_46_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[13]_inst_i_5_n_7 ,\r1_OBUF[11]_inst_i_3_n_4 ,\r1_OBUF[11]_inst_i_3_n_5 ,\r1_OBUF[11]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_46_n_4 ,\r1_OBUF[0]_inst_i_46_n_5 ,\r1_OBUF[0]_inst_i_46_n_6 ,\r1_OBUF[0]_inst_i_46_n_7 }),
        .S({\r1_OBUF[0]_inst_i_83_n_0 ,\r1_OBUF[0]_inst_i_84_n_0 ,\r1_OBUF[0]_inst_i_85_n_0 ,\r1_OBUF[0]_inst_i_86_n_0 }));
  CARRY4 \r1_OBUF[0]_inst_i_47 
       (.CI(\r1_OBUF[0]_inst_i_77_n_0 ),
        .CO({\NLW_r1_OBUF[0]_inst_i_47_CO_UNCONNECTED [3:2],\r1_OBUF[0]_inst_i_47_n_2 ,\NLW_r1_OBUF[0]_inst_i_47_CO_UNCONNECTED [0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\r1_OBUF[13]_inst_i_5_n_2 }),
        .O({\NLW_r1_OBUF[0]_inst_i_47_O_UNCONNECTED [3:1],\r1_OBUF[0]_inst_i_47_n_7 }),
        .S({1'b0,1'b0,1'b1,\r1_OBUF[0]_inst_i_87_n_0 }));
  CARRY4 \r1_OBUF[0]_inst_i_48 
       (.CI(\r1_OBUF[0]_inst_i_79_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_48_n_0 ,\r1_OBUF[0]_inst_i_48_n_1 ,\r1_OBUF[0]_inst_i_48_n_2 ,\r1_OBUF[0]_inst_i_48_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[13]_inst_i_5_n_7 ,\r1_OBUF[11]_inst_i_3_n_4 ,\r1_OBUF[11]_inst_i_3_n_5 ,\r1_OBUF[11]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_48_n_4 ,\r1_OBUF[0]_inst_i_48_n_5 ,\r1_OBUF[0]_inst_i_48_n_6 ,\r1_OBUF[0]_inst_i_48_n_7 }),
        .S({\r1_OBUF[0]_inst_i_88_n_0 ,\r1_OBUF[0]_inst_i_89_n_0 ,\r1_OBUF[0]_inst_i_90_n_0 ,\r1_OBUF[0]_inst_i_91_n_0 }));
  LUT5 #(
    .INIT(32'h36C96C93)) 
    \r1_OBUF[0]_inst_i_49 
       (.I0(\r1_OBUF[0]_inst_i_46_n_4 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_2 ),
        .I2(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I3(\r1_OBUF[0]_inst_i_92_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_45_n_2 ),
        .O(\r1_OBUF[0]_inst_i_49_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_5 
       (.CI(\r1_OBUF[0]_inst_i_16_n_0 ),
        .CO({\NLW_r1_OBUF[0]_inst_i_5_CO_UNCONNECTED [3:2],\r1_OBUF[0]_inst_i_5_n_2 ,\r1_OBUF[0]_inst_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\r1_OBUF[0]_inst_i_17_n_0 ,\r1_OBUF[0]_inst_i_18_n_0 }),
        .O({\NLW_r1_OBUF[0]_inst_i_5_O_UNCONNECTED [3],\r1_OBUF[0]_inst_i_5_n_5 ,\r1_OBUF[0]_inst_i_5_n_6 ,\r1_OBUF[0]_inst_i_5_n_7 }),
        .S({1'b0,\r1_OBUF[0]_inst_i_19_n_0 ,\r1_OBUF[0]_inst_i_20_n_0 ,\r1_OBUF[0]_inst_i_21_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_50 
       (.I0(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_46_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_45_n_2 ),
        .O(\r1_OBUF[0]_inst_i_50_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_51 
       (.CI(\r1_OBUF[0]_inst_i_93_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_51_n_0 ,\r1_OBUF[0]_inst_i_51_n_1 ,\r1_OBUF[0]_inst_i_51_n_2 ,\r1_OBUF[0]_inst_i_51_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r13[12:9]),
        .S({\r1_OBUF[0]_inst_i_94_n_0 ,\r1_OBUF[0]_inst_i_95_n_0 ,\r1_OBUF[0]_inst_i_96_n_0 ,\r1_OBUF[0]_inst_i_97_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_52 
       (.I0(\r1_OBUF[13]_inst_i_10_n_5 ),
        .O(\r1_OBUF[0]_inst_i_52_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_53 
       (.I0(\r1_OBUF[13]_inst_i_10_n_6 ),
        .O(\r1_OBUF[0]_inst_i_53_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_54 
       (.I0(\r1_OBUF[13]_inst_i_10_n_7 ),
        .O(\r1_OBUF[0]_inst_i_54_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_55 
       (.I0(\r1_OBUF[31]_inst_i_14_n_4 ),
        .O(\r1_OBUF[0]_inst_i_55_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_56 
       (.CI(\r1_OBUF[0]_inst_i_98_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_56_n_0 ,\r1_OBUF[0]_inst_i_56_n_1 ,\r1_OBUF[0]_inst_i_56_n_2 ,\r1_OBUF[0]_inst_i_56_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_99_n_0 ,\r1_OBUF[0]_inst_i_100_n_0 ,\r1_OBUF[0]_inst_i_101_n_0 ,\r1_OBUF[0]_inst_i_102_n_0 }),
        .O(\NLW_r1_OBUF[0]_inst_i_56_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[0]_inst_i_103_n_0 ,\r1_OBUF[0]_inst_i_104_n_0 ,\r1_OBUF[0]_inst_i_105_n_0 ,\r1_OBUF[0]_inst_i_106_n_0 }));
  LUT3 #(
    .INIT(8'h8A)) 
    \r1_OBUF[0]_inst_i_57 
       (.I0(\r1_OBUF[0]_inst_i_36_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(r13[23]),
        .O(\r1_OBUF[0]_inst_i_57_n_0 ));
  LUT4 #(
    .INIT(16'h082A)) 
    \r1_OBUF[0]_inst_i_58 
       (.I0(\r1_OBUF[0]_inst_i_36_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_7 ),
        .I3(r13[22]),
        .O(\r1_OBUF[0]_inst_i_58_n_0 ));
  LUT4 #(
    .INIT(16'h082A)) 
    \r1_OBUF[0]_inst_i_59 
       (.I0(\r1_OBUF[0]_inst_i_36_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I3(r13[21]),
        .O(\r1_OBUF[0]_inst_i_59_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_6 
       (.CI(\r1_OBUF[0]_inst_i_22_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_6_n_0 ,\r1_OBUF[0]_inst_i_6_n_1 ,\r1_OBUF[0]_inst_i_6_n_2 ,\r1_OBUF[0]_inst_i_6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r13[20:17]),
        .S({\r1_OBUF[0]_inst_i_23_n_0 ,\r1_OBUF[0]_inst_i_24_n_0 ,\r1_OBUF[0]_inst_i_25_n_0 ,\r1_OBUF[0]_inst_i_26_n_0 }));
  LUT4 #(
    .INIT(16'h082A)) 
    \r1_OBUF[0]_inst_i_60 
       (.I0(\r1_OBUF[0]_inst_i_65_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I3(r13[20]),
        .O(\r1_OBUF[0]_inst_i_60_n_0 ));
  LUT5 #(
    .INIT(32'hC3C34BB4)) 
    \r1_OBUF[0]_inst_i_61 
       (.I0(r13[23]),
        .I1(\r1_OBUF[0]_inst_i_36_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_36_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_61_n_0 ));
  LUT6 #(
    .INIT(64'h0F0FB44BC3C3B44B)) 
    \r1_OBUF[0]_inst_i_62 
       (.I0(r13[22]),
        .I1(\r1_OBUF[0]_inst_i_36_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_36_n_5 ),
        .I3(r13[23]),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I5(\r1_OBUF[31]_inst_i_2_n_7 ),
        .O(\r1_OBUF[0]_inst_i_62_n_0 ));
  LUT6 #(
    .INIT(64'hB4B44B4BB44BB44B)) 
    \r1_OBUF[0]_inst_i_63 
       (.I0(\r1_OBUF[0]_inst_i_107_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_36_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_36_n_6 ),
        .I3(r13[22]),
        .I4(\r1_OBUF[31]_inst_i_2_n_7 ),
        .I5(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[0]_inst_i_63_n_0 ));
  LUT6 #(
    .INIT(64'hE4FF1B001B00E4FF)) 
    \r1_OBUF[0]_inst_i_64 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(r13[20]),
        .I2(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_65_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_36_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_107_n_0 ),
        .O(\r1_OBUF[0]_inst_i_64_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_65 
       (.CI(\r1_OBUF[0]_inst_i_108_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_65_n_0 ,\r1_OBUF[0]_inst_i_65_n_1 ,\r1_OBUF[0]_inst_i_65_n_2 ,\r1_OBUF[0]_inst_i_65_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_109_n_0 ,\r1_OBUF[0]_inst_i_110_n_0 ,\r1_OBUF[0]_inst_i_111_n_0 ,\r1_OBUF[0]_inst_i_112_n_0 }),
        .O({\r1_OBUF[0]_inst_i_65_n_4 ,\r1_OBUF[0]_inst_i_65_n_5 ,\r1_OBUF[0]_inst_i_65_n_6 ,\r1_OBUF[0]_inst_i_65_n_7 }),
        .S({\r1_OBUF[0]_inst_i_113_n_0 ,\r1_OBUF[0]_inst_i_114_n_0 ,\r1_OBUF[0]_inst_i_115_n_0 ,\r1_OBUF[0]_inst_i_116_n_0 }));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_66 
       (.I0(\r1_OBUF[7]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[0]_inst_i_117_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_77_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_79_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_118_n_4 ),
        .O(\r1_OBUF[0]_inst_i_66_n_0 ));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_67 
       (.I0(\r1_OBUF[7]_inst_i_3_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_119_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_77_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_79_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_118_n_5 ),
        .O(\r1_OBUF[0]_inst_i_67_n_0 ));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_68 
       (.I0(\r1_OBUF[3]_inst_i_3_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_120_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_121_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_79_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_118_n_6 ),
        .O(\r1_OBUF[0]_inst_i_68_n_0 ));
  LUT5 #(
    .INIT(32'hEEE8E888)) 
    \r1_OBUF[0]_inst_i_69 
       (.I0(\r1_OBUF[3]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[0]_inst_i_122_n_0 ),
        .I2(\r1_OBUF[0]_inst_i_121_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_123_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_118_n_7 ),
        .O(\r1_OBUF[0]_inst_i_69_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_7 
       (.I0(\r1_OBUF[31]_inst_i_2_n_7 ),
        .O(\r1_OBUF[0]_inst_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_70 
       (.I0(\r1_OBUF[0]_inst_i_66_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_78_n_0 ),
        .I2(\r1_OBUF[7]_inst_i_3_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_74_n_7 ),
        .I4(\r1_OBUF[0]_inst_i_79_n_4 ),
        .I5(\r1_OBUF[0]_inst_i_77_n_5 ),
        .O(\r1_OBUF[0]_inst_i_70_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_71 
       (.I0(\r1_OBUF[0]_inst_i_67_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_117_n_0 ),
        .I2(\r1_OBUF[7]_inst_i_3_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_118_n_4 ),
        .I4(\r1_OBUF[0]_inst_i_79_n_5 ),
        .I5(\r1_OBUF[0]_inst_i_77_n_6 ),
        .O(\r1_OBUF[0]_inst_i_71_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_72 
       (.I0(\r1_OBUF[0]_inst_i_68_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_119_n_0 ),
        .I2(\r1_OBUF[7]_inst_i_3_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_118_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_79_n_6 ),
        .I5(\r1_OBUF[0]_inst_i_77_n_7 ),
        .O(\r1_OBUF[0]_inst_i_72_n_0 ));
  LUT6 #(
    .INIT(64'h6969699669969696)) 
    \r1_OBUF[0]_inst_i_73 
       (.I0(\r1_OBUF[0]_inst_i_69_n_0 ),
        .I1(\r1_OBUF[0]_inst_i_120_n_0 ),
        .I2(\r1_OBUF[3]_inst_i_3_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_118_n_6 ),
        .I4(\r1_OBUF[0]_inst_i_79_n_7 ),
        .I5(\r1_OBUF[0]_inst_i_121_n_4 ),
        .O(\r1_OBUF[0]_inst_i_73_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_74 
       (.CI(\r1_OBUF[0]_inst_i_118_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_74_n_0 ,\r1_OBUF[0]_inst_i_74_n_1 ,\r1_OBUF[0]_inst_i_74_n_2 ,\r1_OBUF[0]_inst_i_74_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[11]_inst_i_3_n_7 ,\r1_OBUF[7]_inst_i_3_n_4 ,\r1_OBUF[7]_inst_i_3_n_5 ,\r1_OBUF[7]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_74_n_4 ,\r1_OBUF[0]_inst_i_74_n_5 ,\r1_OBUF[0]_inst_i_74_n_6 ,\r1_OBUF[0]_inst_i_74_n_7 }),
        .S({\r1_OBUF[0]_inst_i_124_n_0 ,\r1_OBUF[0]_inst_i_125_n_0 ,\r1_OBUF[0]_inst_i_126_n_0 ,\r1_OBUF[0]_inst_i_127_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \r1_OBUF[0]_inst_i_75 
       (.I0(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_74_n_4 ),
        .I2(\r1_OBUF[0]_inst_i_48_n_5 ),
        .O(\r1_OBUF[0]_inst_i_75_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_76 
       (.I0(\r1_OBUF[0]_inst_i_47_n_7 ),
        .I1(\r1_OBUF[0]_inst_i_74_n_5 ),
        .I2(\r1_OBUF[0]_inst_i_48_n_6 ),
        .O(\r1_OBUF[0]_inst_i_76_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_77 
       (.CI(\r1_OBUF[0]_inst_i_121_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_77_n_0 ,\r1_OBUF[0]_inst_i_77_n_1 ,\r1_OBUF[0]_inst_i_77_n_2 ,\r1_OBUF[0]_inst_i_77_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[13]_inst_i_5_n_7 ,\r1_OBUF[11]_inst_i_3_n_4 ,\r1_OBUF[11]_inst_i_3_n_5 ,\r1_OBUF[11]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_77_n_4 ,\r1_OBUF[0]_inst_i_77_n_5 ,\r1_OBUF[0]_inst_i_77_n_6 ,\r1_OBUF[0]_inst_i_77_n_7 }),
        .S({\r1_OBUF[0]_inst_i_128_n_0 ,\r1_OBUF[0]_inst_i_129_n_0 ,\r1_OBUF[0]_inst_i_130_n_0 ,\r1_OBUF[0]_inst_i_131_n_0 }));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[0]_inst_i_78 
       (.I0(\r1_OBUF[0]_inst_i_77_n_4 ),
        .I1(\r1_OBUF[0]_inst_i_74_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_48_n_7 ),
        .O(\r1_OBUF[0]_inst_i_78_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_79 
       (.CI(\r1_OBUF[0]_inst_i_123_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_79_n_0 ,\r1_OBUF[0]_inst_i_79_n_1 ,\r1_OBUF[0]_inst_i_79_n_2 ,\r1_OBUF[0]_inst_i_79_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[11]_inst_i_3_n_7 ,\r1_OBUF[7]_inst_i_3_n_4 ,\r1_OBUF[7]_inst_i_3_n_5 ,\r1_OBUF[7]_inst_i_3_n_6 }),
        .O({\r1_OBUF[0]_inst_i_79_n_4 ,\r1_OBUF[0]_inst_i_79_n_5 ,\r1_OBUF[0]_inst_i_79_n_6 ,\r1_OBUF[0]_inst_i_79_n_7 }),
        .S({\r1_OBUF[0]_inst_i_132_n_0 ,\r1_OBUF[0]_inst_i_133_n_0 ,\r1_OBUF[0]_inst_i_134_n_0 ,\r1_OBUF[0]_inst_i_135_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_8 
       (.I0(\r1_OBUF[31]_inst_i_8_n_4 ),
        .O(\r1_OBUF[0]_inst_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \r1_OBUF[0]_inst_i_80 
       (.I0(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_46_n_6 ),
        .I2(\r1_OBUF[0]_inst_i_45_n_7 ),
        .O(\r1_OBUF[0]_inst_i_80_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \r1_OBUF[0]_inst_i_81 
       (.I0(\r1_OBUF[0]_inst_i_47_n_2 ),
        .I1(\r1_OBUF[0]_inst_i_46_n_7 ),
        .I2(\r1_OBUF[0]_inst_i_48_n_4 ),
        .O(\r1_OBUF[0]_inst_i_81_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_82 
       (.I0(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[0]_inst_i_82_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_83 
       (.I0(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[0]_inst_i_83_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_84 
       (.I0(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_84_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_85 
       (.I0(\r1_OBUF[11]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[0]_inst_i_85_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_86 
       (.I0(\r1_OBUF[11]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[0]_inst_i_86_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_87 
       (.I0(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[0]_inst_i_87_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_88 
       (.I0(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[0]_inst_i_88_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_89 
       (.I0(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[0]_inst_i_89_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_9 
       (.CI(\r1_OBUF[0]_inst_i_27_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_9_n_0 ,\r1_OBUF[0]_inst_i_9_n_1 ,\r1_OBUF[0]_inst_i_9_n_2 ,\r1_OBUF[0]_inst_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_28_n_0 ,\r1_OBUF[0]_inst_i_29_n_0 ,\r1_OBUF[0]_inst_i_30_n_0 ,\r1_OBUF[0]_inst_i_31_n_0 }),
        .O(\NLW_r1_OBUF[0]_inst_i_9_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[0]_inst_i_32_n_0 ,\r1_OBUF[0]_inst_i_33_n_0 ,\r1_OBUF[0]_inst_i_34_n_0 ,\r1_OBUF[0]_inst_i_35_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_90 
       (.I0(\r1_OBUF[11]_inst_i_3_n_5 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[0]_inst_i_90_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[0]_inst_i_91 
       (.I0(\r1_OBUF[11]_inst_i_3_n_6 ),
        .I1(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[0]_inst_i_91_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_92 
       (.CI(\r1_OBUF[0]_inst_i_46_n_0 ),
        .CO(\NLW_r1_OBUF[0]_inst_i_92_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[0]_inst_i_92_O_UNCONNECTED [3:1],\r1_OBUF[0]_inst_i_92_n_7 }),
        .S({1'b0,1'b0,1'b0,\r1_OBUF[0]_inst_i_136_n_0 }));
  CARRY4 \r1_OBUF[0]_inst_i_93 
       (.CI(\r1_OBUF[0]_inst_i_137_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_93_n_0 ,\r1_OBUF[0]_inst_i_93_n_1 ,\r1_OBUF[0]_inst_i_93_n_2 ,\r1_OBUF[0]_inst_i_93_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r13[8:5]),
        .S({\r1_OBUF[0]_inst_i_138_n_0 ,\r1_OBUF[0]_inst_i_139_n_0 ,\r1_OBUF[0]_inst_i_140_n_0 ,\r1_OBUF[0]_inst_i_141_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_94 
       (.I0(\r1_OBUF[31]_inst_i_14_n_5 ),
        .O(\r1_OBUF[0]_inst_i_94_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_95 
       (.I0(\r1_OBUF[31]_inst_i_14_n_6 ),
        .O(\r1_OBUF[0]_inst_i_95_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[0]_inst_i_96 
       (.I0(\r1_OBUF[31]_inst_i_14_n_7 ),
        .O(\r1_OBUF[0]_inst_i_96_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[0]_inst_i_97 
       (.I0(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_8_n_6 ),
        .O(\r1_OBUF[0]_inst_i_97_n_0 ));
  CARRY4 \r1_OBUF[0]_inst_i_98 
       (.CI(\r1_OBUF[0]_inst_i_142_n_0 ),
        .CO({\r1_OBUF[0]_inst_i_98_n_0 ,\r1_OBUF[0]_inst_i_98_n_1 ,\r1_OBUF[0]_inst_i_98_n_2 ,\r1_OBUF[0]_inst_i_98_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[0]_inst_i_143_n_0 ,\r1_OBUF[0]_inst_i_144_n_0 ,\r1_OBUF[0]_inst_i_145_n_0 ,\r1_OBUF[0]_inst_i_146_n_0 }),
        .O(\NLW_r1_OBUF[0]_inst_i_98_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[0]_inst_i_147_n_0 ,\r1_OBUF[0]_inst_i_148_n_0 ,\r1_OBUF[0]_inst_i_149_n_0 ,\r1_OBUF[0]_inst_i_150_n_0 }));
  LUT4 #(
    .INIT(16'h082A)) 
    \r1_OBUF[0]_inst_i_99 
       (.I0(\r1_OBUF[0]_inst_i_65_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_6 ),
        .I3(r13[19]),
        .O(\r1_OBUF[0]_inst_i_99_n_0 ));
  OBUF \r1_OBUF[10]_inst 
       (.I(r1_OBUF[10]),
        .O(r1[10]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[10]_inst_i_1 
       (.I0(data0[10]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[10]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[10]_inst_i_2 
       (.I0(r11[10]),
        .I1(\r1_OBUF[11]_inst_i_3_n_5 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[11]_inst_i_4_n_5 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[10]));
  OBUF \r1_OBUF[11]_inst 
       (.I(r1_OBUF[11]),
        .O(r1[11]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[11]_inst_i_1 
       (.I0(data0[11]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[11]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[11]_inst_i_2 
       (.I0(r11[11]),
        .I1(\r1_OBUF[11]_inst_i_3_n_4 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[11]_inst_i_4_n_4 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[11]));
  CARRY4 \r1_OBUF[11]_inst_i_3 
       (.CI(\r1_OBUF[7]_inst_i_3_n_0 ),
        .CO({\r1_OBUF[11]_inst_i_3_n_0 ,\r1_OBUF[11]_inst_i_3_n_1 ,\r1_OBUF[11]_inst_i_3_n_2 ,\r1_OBUF[11]_inst_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\r1_OBUF[11]_inst_i_3_n_4 ,\r1_OBUF[11]_inst_i_3_n_5 ,\r1_OBUF[11]_inst_i_3_n_6 ,\r1_OBUF[11]_inst_i_3_n_7 }),
        .S({\r1_OBUF[11]_inst_i_5_n_0 ,\r1_OBUF[11]_inst_i_6_n_0 ,\r1_OBUF[11]_inst_i_7_n_0 ,\r1_OBUF[11]_inst_i_8_n_0 }));
  CARRY4 \r1_OBUF[11]_inst_i_4 
       (.CI(\r1_OBUF[7]_inst_i_4_n_0 ),
        .CO({\r1_OBUF[11]_inst_i_4_n_0 ,\r1_OBUF[11]_inst_i_4_n_1 ,\r1_OBUF[11]_inst_i_4_n_2 ,\r1_OBUF[11]_inst_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\r1_OBUF[11]_inst_i_4_n_4 ,\r1_OBUF[11]_inst_i_4_n_5 ,\r1_OBUF[11]_inst_i_4_n_6 ,\r1_OBUF[11]_inst_i_4_n_7 }),
        .S({\r1_OBUF[11]_inst_i_3_n_4 ,\r1_OBUF[11]_inst_i_3_n_5 ,\r1_OBUF[11]_inst_i_3_n_6 ,\r1_OBUF[11]_inst_i_3_n_7 }));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[11]_inst_i_5 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[11]_inst_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[11]_inst_i_6 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[11]_inst_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[11]_inst_i_7 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[11]_inst_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[11]_inst_i_8 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[11]_inst_i_8_n_0 ));
  OBUF \r1_OBUF[12]_inst 
       (.I(r1_OBUF[12]),
        .O(r1[12]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[12]_inst_i_1 
       (.I0(data0[12]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[12]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[12]_inst_i_2 
       (.I0(r11[12]),
        .I1(\r1_OBUF[13]_inst_i_5_n_7 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[13]_inst_i_7_n_7 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[12]));
  OBUF \r1_OBUF[13]_inst 
       (.I(r1_OBUF[13]),
        .O(r1[13]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[13]_inst_i_1 
       (.I0(data0[13]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[13]));
  CARRY4 \r1_OBUF[13]_inst_i_10 
       (.CI(\r1_OBUF[31]_inst_i_14_n_0 ),
        .CO({\r1_OBUF[13]_inst_i_10_n_0 ,\r1_OBUF[13]_inst_i_10_n_1 ,\r1_OBUF[13]_inst_i_10_n_2 ,\r1_OBUF[13]_inst_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\r1_OBUF[13]_inst_i_10_n_4 ,\r1_OBUF[13]_inst_i_10_n_5 ,\r1_OBUF[13]_inst_i_10_n_6 ,\r1_OBUF[13]_inst_i_10_n_7 }),
        .S(p_0_in[17:14]));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[13]_inst_i_11 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[13]_inst_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[13]_inst_i_12 
       (.I0(\r1_OBUF[13]_inst_i_9_n_4 ),
        .O(\r1_OBUF[13]_inst_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[13]_inst_i_13 
       (.I0(\r1_OBUF[13]_inst_i_9_n_5 ),
        .O(\r1_OBUF[13]_inst_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[13]_inst_i_14 
       (.I0(\r1_OBUF[13]_inst_i_9_n_6 ),
        .O(\r1_OBUF[13]_inst_i_14_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[13]_inst_i_15 
       (.I0(\r1_OBUF[13]_inst_i_9_n_7 ),
        .O(\r1_OBUF[13]_inst_i_15_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[13]_inst_i_16 
       (.I0(r_IBUF[11]),
        .O(\r1_OBUF[13]_inst_i_16_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[13]_inst_i_17 
       (.I0(r_IBUF[10]),
        .I1(\r1_OBUF[31]_inst_i_66_n_0 ),
        .O(\r1_OBUF[13]_inst_i_17_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[13]_inst_i_18 
       (.I0(r_IBUF[9]),
        .I1(\r1_OBUF[31]_inst_i_66_n_5 ),
        .O(\r1_OBUF[13]_inst_i_18_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[13]_inst_i_19 
       (.I0(r_IBUF[8]),
        .I1(\r1_OBUF[31]_inst_i_66_n_6 ),
        .O(\r1_OBUF[13]_inst_i_19_n_0 ));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[13]_inst_i_2 
       (.I0(r11[13]),
        .I1(\r1_OBUF[13]_inst_i_5_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[13]_inst_i_7_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[13]_inst_i_20 
       (.I0(\r1_OBUF[31]_inst_i_43_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_57_n_6 ),
        .O(p_0_in[17]));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[13]_inst_i_21 
       (.I0(\r1_OBUF[31]_inst_i_43_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_57_n_7 ),
        .O(p_0_in[16]));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[13]_inst_i_22 
       (.I0(\r1_OBUF[31]_inst_i_62_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_63_n_4 ),
        .O(p_0_in[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[13]_inst_i_23 
       (.I0(\r1_OBUF[31]_inst_i_62_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_63_n_5 ),
        .O(p_0_in[14]));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFEFEFE)) 
    \r1_OBUF[13]_inst_i_3 
       (.I0(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_14_n_6 ),
        .I2(p_0_in__0[8]),
        .I3(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I5(\r1_OBUF[13]_inst_i_9_n_6 ),
        .O(\r1_OBUF[13]_inst_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \r1_OBUF[13]_inst_i_4 
       (.I0(\r1_OBUF[13]_inst_i_10_n_7 ),
        .I1(\r1_OBUF[13]_inst_i_10_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I3(\r1_OBUF[31]_inst_i_14_n_5 ),
        .O(\r1_OBUF[13]_inst_i_4_n_0 ));
  CARRY4 \r1_OBUF[13]_inst_i_5 
       (.CI(\r1_OBUF[11]_inst_i_3_n_0 ),
        .CO({\NLW_r1_OBUF[13]_inst_i_5_CO_UNCONNECTED [3:2],\r1_OBUF[13]_inst_i_5_n_2 ,\NLW_r1_OBUF[13]_inst_i_5_CO_UNCONNECTED [0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[13]_inst_i_5_O_UNCONNECTED [3:1],\r1_OBUF[13]_inst_i_5_n_7 }),
        .S({1'b0,1'b0,1'b1,\r1_OBUF[13]_inst_i_11_n_0 }));
  LUT4 #(
    .INIT(16'hFEAA)) 
    \r1_OBUF[13]_inst_i_6 
       (.I0(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I1(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .O(\r1_OBUF[13]_inst_i_6_n_0 ));
  CARRY4 \r1_OBUF[13]_inst_i_7 
       (.CI(\r1_OBUF[11]_inst_i_4_n_0 ),
        .CO({\NLW_r1_OBUF[13]_inst_i_7_CO_UNCONNECTED [3:1],\r1_OBUF[13]_inst_i_7_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[13]_inst_i_7_O_UNCONNECTED [3:2],\r1_OBUF[13]_inst_i_7_n_6 ,\r1_OBUF[13]_inst_i_7_n_7 }),
        .S({1'b0,1'b0,\r1_OBUF[13]_inst_i_5_n_2 ,\r1_OBUF[13]_inst_i_5_n_7 }));
  CARRY4 \r1_OBUF[13]_inst_i_8 
       (.CI(\r1_OBUF[31]_inst_i_22_n_0 ),
        .CO({\r1_OBUF[13]_inst_i_8_n_0 ,\r1_OBUF[13]_inst_i_8_n_1 ,\r1_OBUF[13]_inst_i_8_n_2 ,\r1_OBUF[13]_inst_i_8_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\r1_OBUF[13]_inst_i_8_n_4 ,\r1_OBUF[13]_inst_i_8_n_5 ,\r1_OBUF[13]_inst_i_8_n_6 ,\r1_OBUF[13]_inst_i_8_n_7 }),
        .S({\r1_OBUF[13]_inst_i_12_n_0 ,\r1_OBUF[13]_inst_i_13_n_0 ,\r1_OBUF[13]_inst_i_14_n_0 ,\r1_OBUF[13]_inst_i_15_n_0 }));
  CARRY4 \r1_OBUF[13]_inst_i_9 
       (.CI(\r1_OBUF[31]_inst_i_23_n_0 ),
        .CO({\r1_OBUF[13]_inst_i_9_n_0 ,\r1_OBUF[13]_inst_i_9_n_1 ,\r1_OBUF[13]_inst_i_9_n_2 ,\r1_OBUF[13]_inst_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI(r_IBUF[11:8]),
        .O({\r1_OBUF[13]_inst_i_9_n_4 ,\r1_OBUF[13]_inst_i_9_n_5 ,\r1_OBUF[13]_inst_i_9_n_6 ,\r1_OBUF[13]_inst_i_9_n_7 }),
        .S({\r1_OBUF[13]_inst_i_16_n_0 ,\r1_OBUF[13]_inst_i_17_n_0 ,\r1_OBUF[13]_inst_i_18_n_0 ,\r1_OBUF[13]_inst_i_19_n_0 }));
  OBUF \r1_OBUF[14]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[14]));
  OBUF \r1_OBUF[15]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[15]));
  OBUF \r1_OBUF[16]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[16]));
  OBUF \r1_OBUF[17]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[17]));
  OBUF \r1_OBUF[18]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[18]));
  OBUF \r1_OBUF[19]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[19]));
  OBUF \r1_OBUF[1]_inst 
       (.I(r1_OBUF[1]),
        .O(r1[1]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[1]_inst_i_1 
       (.I0(data0[1]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[1]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[1]_inst_i_2 
       (.I0(r11[1]),
        .I1(\r1_OBUF[3]_inst_i_3_n_6 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[3]_inst_i_4_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[1]));
  OBUF \r1_OBUF[20]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[20]));
  OBUF \r1_OBUF[21]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[21]));
  OBUF \r1_OBUF[22]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[22]));
  OBUF \r1_OBUF[23]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[23]));
  OBUF \r1_OBUF[24]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[24]));
  OBUF \r1_OBUF[25]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[25]));
  OBUF \r1_OBUF[26]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[26]));
  OBUF \r1_OBUF[27]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[27]));
  OBUF \r1_OBUF[28]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[28]));
  OBUF \r1_OBUF[29]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[29]));
  OBUF \r1_OBUF[2]_inst 
       (.I(r1_OBUF[2]),
        .O(r1[2]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[2]_inst_i_1 
       (.I0(data0[2]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[2]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[2]_inst_i_2 
       (.I0(r11[2]),
        .I1(\r1_OBUF[3]_inst_i_3_n_5 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[3]_inst_i_4_n_5 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[2]));
  OBUF \r1_OBUF[30]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[30]));
  OBUF \r1_OBUF[31]_inst 
       (.I(r1_OBUF[14]),
        .O(r1[31]));
  LUT6 #(
    .INIT(64'h1111111111111110)) 
    \r1_OBUF[31]_inst_i_1 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[31]_inst_i_3_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[14]));
  CARRY4 \r1_OBUF[31]_inst_i_10 
       (.CI(\r1_OBUF[8]_inst_i_3_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_10_n_0 ,\r1_OBUF[31]_inst_i_10_n_1 ,\r1_OBUF[31]_inst_i_10_n_2 ,\r1_OBUF[31]_inst_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r11[12:9]),
        .S({\r1_OBUF[31]_inst_i_32_n_0 ,\r1_OBUF[31]_inst_i_33_n_0 ,\r1_OBUF[31]_inst_i_34_n_0 ,\r1_OBUF[31]_inst_i_35_n_0 }));
  LUT2 #(
    .INIT(4'h8)) 
    \r1_OBUF[31]_inst_i_100 
       (.I0(r_IBUF[23]),
        .I1(r_IBUF[24]),
        .O(\r1_OBUF[31]_inst_i_100_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_101 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_101_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_102 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_102_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_103 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_103_n_0 ));
  LUT3 #(
    .INIT(8'h36)) 
    \r1_OBUF[31]_inst_i_104 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_104_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_105 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_105_n_0 ,\r1_OBUF[31]_inst_i_105_n_1 ,\r1_OBUF[31]_inst_i_105_n_2 ,\r1_OBUF[31]_inst_i_105_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[31]_inst_i_119_n_0 ,\r1_OBUF[31]_inst_i_120_n_0 ,\r1_OBUF[31]_inst_i_121_n_0 ,\r1_OBUF[31]_inst_i_122_n_0 }),
        .O({\r1_OBUF[31]_inst_i_105_n_4 ,\r1_OBUF[31]_inst_i_105_n_5 ,\r1_OBUF[31]_inst_i_105_n_6 ,\NLW_r1_OBUF[31]_inst_i_105_O_UNCONNECTED [0]}),
        .S({\r1_OBUF[31]_inst_i_123_n_0 ,\r1_OBUF[31]_inst_i_124_n_0 ,\r1_OBUF[31]_inst_i_125_n_0 ,\r1_OBUF[31]_inst_i_126_n_0 }));
  CARRY4 \r1_OBUF[31]_inst_i_106 
       (.CI(\r1_OBUF[31]_inst_i_85_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_106_n_0 ,\r1_OBUF[31]_inst_i_106_n_1 ,\r1_OBUF[31]_inst_i_106_n_2 ,\r1_OBUF[31]_inst_i_106_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[31]_inst_i_127_n_0 ,\r1_OBUF[31]_inst_i_128_n_0 ,\r1_OBUF[31]_inst_i_129_n_0 ,\r1_OBUF[31]_inst_i_130_n_0 }),
        .O({\r1_OBUF[31]_inst_i_106_n_4 ,\r1_OBUF[31]_inst_i_106_n_5 ,\r1_OBUF[31]_inst_i_106_n_6 ,\r1_OBUF[31]_inst_i_106_n_7 }),
        .S({\r1_OBUF[31]_inst_i_131_n_0 ,\r1_OBUF[31]_inst_i_132_n_0 ,\r1_OBUF[31]_inst_i_133_n_0 ,\r1_OBUF[31]_inst_i_134_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h5A69A596)) 
    \r1_OBUF[31]_inst_i_107 
       (.I0(\r1_OBUF[31]_inst_i_106_n_5 ),
        .I1(r_IBUF[30]),
        .I2(r_IBUF[31]),
        .I3(r_IBUF[29]),
        .I4(\r1_OBUF[31]_inst_i_105_n_4 ),
        .O(\r1_OBUF[31]_inst_i_107_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFF363600)) 
    \r1_OBUF[31]_inst_i_108 
       (.I0(r_IBUF[29]),
        .I1(r_IBUF[31]),
        .I2(r_IBUF[30]),
        .I3(\r1_OBUF[31]_inst_i_105_n_4 ),
        .I4(\r1_OBUF[31]_inst_i_106_n_5 ),
        .O(\r1_OBUF[31]_inst_i_108_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_109 
       (.CI(1'b0),
        .CO({\NLW_r1_OBUF[31]_inst_i_109_CO_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_109_n_2 ,\r1_OBUF[31]_inst_i_109_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\r1_OBUF[31]_inst_i_135_n_0 ,\r1_OBUF[31]_inst_i_136_n_0 }),
        .O({\NLW_r1_OBUF[31]_inst_i_109_O_UNCONNECTED [3],\r1_OBUF[31]_inst_i_109_n_5 ,\r1_OBUF[31]_inst_i_109_n_6 ,\NLW_r1_OBUF[31]_inst_i_109_O_UNCONNECTED [0]}),
        .S({1'b0,\r1_OBUF[31]_inst_i_137_n_0 ,\r1_OBUF[31]_inst_i_138_n_0 ,\r1_OBUF[31]_inst_i_139_n_0 }));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[31]_inst_i_11 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_7_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[13]_inst_i_5_n_2 ),
        .O(\r1_OBUF[31]_inst_i_11_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_110 
       (.CI(\r1_OBUF[31]_inst_i_105_n_0 ),
        .CO({\NLW_r1_OBUF[31]_inst_i_110_CO_UNCONNECTED [3:1],\r1_OBUF[31]_inst_i_110_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\r1_OBUF[31]_inst_i_140_n_0 }),
        .O({\NLW_r1_OBUF[31]_inst_i_110_O_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_110_n_6 ,\r1_OBUF[31]_inst_i_110_n_7 }),
        .S({1'b0,1'b0,\r1_OBUF[31]_inst_i_141_n_0 ,\r1_OBUF[31]_inst_i_142_n_0 }));
  LUT6 #(
    .INIT(64'hE81717E817E8E817)) 
    \r1_OBUF[31]_inst_i_111 
       (.I0(\r1_OBUF[31]_inst_i_106_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_110_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_109_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_110_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_109_n_5 ),
        .I5(\r1_OBUF[31]_inst_i_143_n_7 ),
        .O(\r1_OBUF[31]_inst_i_111_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hF660)) 
    \r1_OBUF[31]_inst_i_112 
       (.I0(r_IBUF[30]),
        .I1(r_IBUF[29]),
        .I2(\r1_OBUF[31]_inst_i_105_n_5 ),
        .I3(\r1_OBUF[31]_inst_i_106_n_6 ),
        .O(\r1_OBUF[31]_inst_i_112_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[31]_inst_i_113 
       (.I0(\r1_OBUF[31]_inst_i_106_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_109_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_110_n_7 ),
        .O(\r1_OBUF[31]_inst_i_113_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h36)) 
    \r1_OBUF[31]_inst_i_114 
       (.I0(r_IBUF[30]),
        .I1(r_IBUF[31]),
        .I2(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_114_n_0 ));
  LUT3 #(
    .INIT(8'h36)) 
    \r1_OBUF[31]_inst_i_115 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_115_n_0 ));
  LUT6 #(
    .INIT(64'h969696FF69FFFFFF)) 
    \r1_OBUF[31]_inst_i_116 
       (.I0(\r1_OBUF[31]_inst_i_105_n_5 ),
        .I1(r_IBUF[30]),
        .I2(\r1_OBUF[31]_inst_i_106_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_106_n_7 ),
        .I4(\r1_OBUF[31]_inst_i_105_n_6 ),
        .I5(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_116_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \r1_OBUF[31]_inst_i_117 
       (.I0(\r1_OBUF[31]_inst_i_106_n_6 ),
        .I1(r_IBUF[29]),
        .I2(r_IBUF[30]),
        .I3(\r1_OBUF[31]_inst_i_105_n_5 ),
        .O(\r1_OBUF[31]_inst_i_117_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \r1_OBUF[31]_inst_i_118 
       (.I0(\r1_OBUF[31]_inst_i_106_n_7 ),
        .I1(r_IBUF[29]),
        .I2(\r1_OBUF[31]_inst_i_105_n_6 ),
        .O(\r1_OBUF[31]_inst_i_118_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_119 
       (.I0(r_IBUF[28]),
        .I1(r_IBUF[27]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_119_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_12 
       (.I0(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_9_n_6 ),
        .O(p_0_in__0[9]));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_120 
       (.I0(r_IBUF[28]),
        .I1(r_IBUF[27]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_120_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_121 
       (.I0(r_IBUF[28]),
        .I1(r_IBUF[27]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_121_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r1_OBUF[31]_inst_i_122 
       (.I0(r_IBUF[26]),
        .I1(r_IBUF[27]),
        .O(\r1_OBUF[31]_inst_i_122_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_123 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_123_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_124 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_124_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_125 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_125_n_0 ));
  LUT3 #(
    .INIT(8'h36)) 
    \r1_OBUF[31]_inst_i_126 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_126_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_127 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_127_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_128 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_128_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_129 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_129_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_13 
       (.I0(\r1_OBUF[13]_inst_i_8_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_9_n_7 ),
        .O(p_0_in__0[8]));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_130 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_130_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_131 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_131_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_132 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_132_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_133 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_133_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_134 
       (.I0(r_IBUF[24]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_134_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_135 
       (.I0(r_IBUF[31]),
        .I1(r_IBUF[30]),
        .I2(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_135_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \r1_OBUF[31]_inst_i_136 
       (.I0(r_IBUF[29]),
        .I1(r_IBUF[30]),
        .O(\r1_OBUF[31]_inst_i_136_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_137 
       (.I0(r_IBUF[30]),
        .I1(r_IBUF[31]),
        .I2(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_137_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_138 
       (.I0(r_IBUF[30]),
        .I1(r_IBUF[31]),
        .I2(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_138_n_0 ));
  LUT3 #(
    .INIT(8'h36)) 
    \r1_OBUF[31]_inst_i_139 
       (.I0(r_IBUF[30]),
        .I1(r_IBUF[31]),
        .I2(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_139_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_14 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_14_n_0 ,\r1_OBUF[31]_inst_i_14_n_1 ,\r1_OBUF[31]_inst_i_14_n_2 ,\r1_OBUF[31]_inst_i_14_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b1,1'b0}),
        .O({\r1_OBUF[31]_inst_i_14_n_4 ,\r1_OBUF[31]_inst_i_14_n_5 ,\r1_OBUF[31]_inst_i_14_n_6 ,\r1_OBUF[31]_inst_i_14_n_7 }),
        .S({p_0_in[13:12],\r1_OBUF[31]_inst_i_38_n_0 ,p_0_in[10]}));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_140 
       (.I0(r_IBUF[28]),
        .I1(r_IBUF[27]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_140_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_141 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_141_n_0 ));
  LUT3 #(
    .INIT(8'h7E)) 
    \r1_OBUF[31]_inst_i_142 
       (.I0(r_IBUF[27]),
        .I1(r_IBUF[28]),
        .I2(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_142_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_143 
       (.CI(\r1_OBUF[31]_inst_i_106_n_0 ),
        .CO(\NLW_r1_OBUF[31]_inst_i_143_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[31]_inst_i_143_O_UNCONNECTED [3:1],\r1_OBUF[31]_inst_i_143_n_7 }),
        .S({1'b0,1'b0,1'b0,\r1_OBUF[31]_inst_i_144_n_0 }));
  LUT3 #(
    .INIT(8'hD4)) 
    \r1_OBUF[31]_inst_i_144 
       (.I0(r_IBUF[23]),
        .I1(r_IBUF[25]),
        .I2(r_IBUF[24]),
        .O(\r1_OBUF[31]_inst_i_144_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_15 
       (.I0(\r1_OBUF[31]_inst_i_16_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_5 ),
        .O(p_0_in__0[2]));
  CARRY4 \r1_OBUF[31]_inst_i_16 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_16_n_0 ,\r1_OBUF[31]_inst_i_16_n_1 ,\r1_OBUF[31]_inst_i_16_n_2 ,\r1_OBUF[31]_inst_i_16_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b1,1'b1,1'b1,1'b0}),
        .O({\r1_OBUF[31]_inst_i_16_n_4 ,\r1_OBUF[31]_inst_i_16_n_5 ,\r1_OBUF[31]_inst_i_16_n_6 ,\r1_OBUF[31]_inst_i_16_n_7 }),
        .S({\r1_OBUF[31]_inst_i_40_n_0 ,\r1_OBUF[31]_inst_i_41_n_0 ,\r1_OBUF[31]_inst_i_42_n_0 ,\r1_OBUF[31]_inst_i_18_n_7 }));
  CARRY4 \r1_OBUF[31]_inst_i_17 
       (.CI(\r1_OBUF[31]_inst_i_43_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_17_n_0 ,\r1_OBUF[31]_inst_i_17_n_1 ,\r1_OBUF[31]_inst_i_17_n_2 ,\r1_OBUF[31]_inst_i_17_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b0,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[31]_inst_i_17_O_UNCONNECTED [3],\r1_OBUF[31]_inst_i_17_n_5 ,\r1_OBUF[31]_inst_i_17_n_6 ,\r1_OBUF[31]_inst_i_17_n_7 }),
        .S({\r1_OBUF[31]_inst_i_44_n_0 ,\r1_OBUF[31]_inst_i_31_n_5 ,\r1_OBUF[31]_inst_i_31_n_6 ,\r1_OBUF[31]_inst_i_31_n_7 }));
  CARRY4 \r1_OBUF[31]_inst_i_18 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_18_n_0 ,\r1_OBUF[31]_inst_i_18_n_1 ,\r1_OBUF[31]_inst_i_18_n_2 ,\r1_OBUF[31]_inst_i_18_n_3 }),
        .CYINIT(1'b1),
        .DI(r_IBUF[3:0]),
        .O({\r1_OBUF[31]_inst_i_18_n_4 ,\r1_OBUF[31]_inst_i_18_n_5 ,\r1_OBUF[31]_inst_i_18_n_6 ,\r1_OBUF[31]_inst_i_18_n_7 }),
        .S({\r1_OBUF[31]_inst_i_45_n_0 ,\r1_OBUF[31]_inst_i_46_n_0 ,\r1_OBUF[31]_inst_i_47_n_0 ,\r1_OBUF[31]_inst_i_48_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_19 
       (.I0(\r1_OBUF[31]_inst_i_16_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_7 ),
        .O(p_0_in__0[0]));
  CARRY4 \r1_OBUF[31]_inst_i_2 
       (.CI(\r1_OBUF[31]_inst_i_8_n_0 ),
        .CO({\NLW_r1_OBUF[31]_inst_i_2_CO_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_2_n_2 ,\NLW_r1_OBUF[31]_inst_i_2_CO_UNCONNECTED [0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\NLW_r1_OBUF[31]_inst_i_2_O_UNCONNECTED [3:1],\r1_OBUF[31]_inst_i_2_n_7 }),
        .S({1'b0,1'b0,1'b1,\r1_OBUF[31]_inst_i_9_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_20 
       (.I0(\r1_OBUF[31]_inst_i_16_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_6 ),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_21 
       (.I0(\r1_OBUF[31]_inst_i_22_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_5 ),
        .O(p_0_in__0[6]));
  CARRY4 \r1_OBUF[31]_inst_i_22 
       (.CI(\r1_OBUF[31]_inst_i_16_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_22_n_0 ,\r1_OBUF[31]_inst_i_22_n_1 ,\r1_OBUF[31]_inst_i_22_n_2 ,\r1_OBUF[31]_inst_i_22_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\r1_OBUF[31]_inst_i_22_n_4 ,\r1_OBUF[31]_inst_i_22_n_5 ,\r1_OBUF[31]_inst_i_22_n_6 ,\r1_OBUF[31]_inst_i_22_n_7 }),
        .S({\r1_OBUF[31]_inst_i_49_n_0 ,\r1_OBUF[31]_inst_i_50_n_0 ,\r1_OBUF[31]_inst_i_51_n_0 ,\r1_OBUF[31]_inst_i_52_n_0 }));
  CARRY4 \r1_OBUF[31]_inst_i_23 
       (.CI(\r1_OBUF[31]_inst_i_18_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_23_n_0 ,\r1_OBUF[31]_inst_i_23_n_1 ,\r1_OBUF[31]_inst_i_23_n_2 ,\r1_OBUF[31]_inst_i_23_n_3 }),
        .CYINIT(1'b0),
        .DI(r_IBUF[7:4]),
        .O({\r1_OBUF[31]_inst_i_23_n_4 ,\r1_OBUF[31]_inst_i_23_n_5 ,\r1_OBUF[31]_inst_i_23_n_6 ,\r1_OBUF[31]_inst_i_23_n_7 }),
        .S({\r1_OBUF[31]_inst_i_53_n_0 ,\r1_OBUF[31]_inst_i_54_n_0 ,\r1_OBUF[31]_inst_i_55_n_0 ,\r1_OBUF[31]_inst_i_56_n_0 }));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_24 
       (.I0(\r1_OBUF[31]_inst_i_22_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_7 ),
        .O(p_0_in__0[4]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_25 
       (.I0(\r1_OBUF[31]_inst_i_22_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_6 ),
        .O(p_0_in__0[5]));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \r1_OBUF[31]_inst_i_26 
       (.I0(\r1_OBUF[31]_inst_i_8_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_8_n_6 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_5 ),
        .I3(\r1_OBUF[13]_inst_i_10_n_4 ),
        .O(\r1_OBUF[31]_inst_i_26_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[31]_inst_i_27 
       (.I0(\r1_OBUF[31]_inst_i_31_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_6 ),
        .O(\r1_OBUF[31]_inst_i_27_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[31]_inst_i_28 
       (.I0(\r1_OBUF[31]_inst_i_31_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_7 ),
        .O(\r1_OBUF[31]_inst_i_28_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[31]_inst_i_29 
       (.I0(\r1_OBUF[31]_inst_i_57_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_43_n_4 ),
        .O(\r1_OBUF[31]_inst_i_29_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_3 
       (.CI(\r1_OBUF[31]_inst_i_10_n_0 ),
        .CO({\NLW_r1_OBUF[31]_inst_i_3_CO_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_3_n_2 ,\NLW_r1_OBUF[31]_inst_i_3_CO_UNCONNECTED [0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_r1_OBUF[31]_inst_i_3_O_UNCONNECTED [3:1],r11[13]}),
        .S({1'b0,1'b0,1'b1,\r1_OBUF[31]_inst_i_11_n_0 }));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_30 
       (.I0(\r1_OBUF[31]_inst_i_43_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_57_n_5 ),
        .O(p_0_in[18]));
  CARRY4 \r1_OBUF[31]_inst_i_31 
       (.CI(\r1_OBUF[31]_inst_i_57_n_0 ),
        .CO({\NLW_r1_OBUF[31]_inst_i_31_CO_UNCONNECTED [3],\r1_OBUF[31]_inst_i_31_n_1 ,\r1_OBUF[31]_inst_i_31_n_2 ,\r1_OBUF[31]_inst_i_31_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,r_IBUF[22:20]}),
        .O({\r1_OBUF[31]_inst_i_31_n_4 ,\r1_OBUF[31]_inst_i_31_n_5 ,\r1_OBUF[31]_inst_i_31_n_6 ,\r1_OBUF[31]_inst_i_31_n_7 }),
        .S({\r1_OBUF[31]_inst_i_58_n_0 ,\r1_OBUF[31]_inst_i_59_n_0 ,\r1_OBUF[31]_inst_i_60_n_0 ,\r1_OBUF[31]_inst_i_61_n_0 }));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[31]_inst_i_32 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_7_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[13]_inst_i_5_n_7 ),
        .O(\r1_OBUF[31]_inst_i_32_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[31]_inst_i_33 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[11]_inst_i_4_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[11]_inst_i_3_n_4 ),
        .O(\r1_OBUF[31]_inst_i_33_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[31]_inst_i_34 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[11]_inst_i_4_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[11]_inst_i_3_n_5 ),
        .O(\r1_OBUF[31]_inst_i_34_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[31]_inst_i_35 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[11]_inst_i_4_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[11]_inst_i_3_n_6 ),
        .O(\r1_OBUF[31]_inst_i_35_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_36 
       (.I0(\r1_OBUF[31]_inst_i_62_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_63_n_6 ),
        .O(p_0_in[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_37 
       (.I0(\r1_OBUF[31]_inst_i_62_n_7 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_63_n_7 ),
        .O(p_0_in[12]));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[31]_inst_i_38 
       (.I0(\r1_OBUF[13]_inst_i_9_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_8_n_4 ),
        .O(\r1_OBUF[31]_inst_i_38_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \r1_OBUF[31]_inst_i_39 
       (.I0(\r1_OBUF[13]_inst_i_8_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_9_n_5 ),
        .O(p_0_in[10]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \r1_OBUF[31]_inst_i_4 
       (.I0(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I1(p_0_in__0[9]),
        .I2(p_0_in__0[8]),
        .I3(\r1_OBUF[31]_inst_i_14_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_14_n_7 ),
        .O(\r1_OBUF[31]_inst_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_40 
       (.I0(\r1_OBUF[31]_inst_i_18_n_4 ),
        .O(\r1_OBUF[31]_inst_i_40_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_41 
       (.I0(\r1_OBUF[31]_inst_i_18_n_5 ),
        .O(\r1_OBUF[31]_inst_i_41_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_42 
       (.I0(\r1_OBUF[31]_inst_i_18_n_6 ),
        .O(\r1_OBUF[31]_inst_i_42_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_43 
       (.CI(\r1_OBUF[31]_inst_i_62_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_43_n_0 ,\r1_OBUF[31]_inst_i_43_n_1 ,\r1_OBUF[31]_inst_i_43_n_2 ,\r1_OBUF[31]_inst_i_43_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\r1_OBUF[31]_inst_i_43_n_4 ,\r1_OBUF[31]_inst_i_43_n_5 ,\r1_OBUF[31]_inst_i_43_n_6 ,\r1_OBUF[31]_inst_i_43_n_7 }),
        .S({\r1_OBUF[31]_inst_i_57_n_4 ,\r1_OBUF[31]_inst_i_57_n_5 ,\r1_OBUF[31]_inst_i_57_n_6 ,\r1_OBUF[31]_inst_i_57_n_7 }));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_44 
       (.I0(\r1_OBUF[31]_inst_i_31_n_4 ),
        .O(\r1_OBUF[31]_inst_i_44_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_45 
       (.I0(r_IBUF[3]),
        .I1(\r1_OBUF[31]_inst_i_64_n_7 ),
        .O(\r1_OBUF[31]_inst_i_45_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_46 
       (.I0(r_IBUF[2]),
        .I1(\r1_OBUF[31]_inst_i_65_n_6 ),
        .O(\r1_OBUF[31]_inst_i_46_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_47 
       (.I0(r_IBUF[1]),
        .I1(\r1_OBUF[31]_inst_i_65_n_7 ),
        .O(\r1_OBUF[31]_inst_i_47_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_48 
       (.I0(r_IBUF[0]),
        .I1(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_48_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_49 
       (.I0(\r1_OBUF[31]_inst_i_23_n_4 ),
        .O(\r1_OBUF[31]_inst_i_49_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEFEA)) 
    \r1_OBUF[31]_inst_i_5 
       (.I0(p_0_in__0[2]),
        .I1(\r1_OBUF[31]_inst_i_16_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_18_n_4 ),
        .I4(p_0_in__0[0]),
        .I5(p_0_in__0[1]),
        .O(\r1_OBUF[31]_inst_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_50 
       (.I0(\r1_OBUF[31]_inst_i_23_n_5 ),
        .O(\r1_OBUF[31]_inst_i_50_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_51 
       (.I0(\r1_OBUF[31]_inst_i_23_n_6 ),
        .O(\r1_OBUF[31]_inst_i_51_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_52 
       (.I0(\r1_OBUF[31]_inst_i_23_n_7 ),
        .O(\r1_OBUF[31]_inst_i_52_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_53 
       (.I0(r_IBUF[7]),
        .I1(\r1_OBUF[31]_inst_i_66_n_7 ),
        .O(\r1_OBUF[31]_inst_i_53_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_54 
       (.I0(r_IBUF[6]),
        .I1(\r1_OBUF[31]_inst_i_64_n_4 ),
        .O(\r1_OBUF[31]_inst_i_54_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_55 
       (.I0(r_IBUF[5]),
        .I1(\r1_OBUF[31]_inst_i_64_n_5 ),
        .O(\r1_OBUF[31]_inst_i_55_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_56 
       (.I0(r_IBUF[4]),
        .I1(\r1_OBUF[31]_inst_i_64_n_6 ),
        .O(\r1_OBUF[31]_inst_i_56_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_57 
       (.CI(\r1_OBUF[31]_inst_i_63_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_57_n_0 ,\r1_OBUF[31]_inst_i_57_n_1 ,\r1_OBUF[31]_inst_i_57_n_2 ,\r1_OBUF[31]_inst_i_57_n_3 }),
        .CYINIT(1'b0),
        .DI(r_IBUF[19:16]),
        .O({\r1_OBUF[31]_inst_i_57_n_4 ,\r1_OBUF[31]_inst_i_57_n_5 ,\r1_OBUF[31]_inst_i_57_n_6 ,\r1_OBUF[31]_inst_i_57_n_7 }),
        .S({\r1_OBUF[31]_inst_i_67_n_0 ,\r1_OBUF[31]_inst_i_68_n_0 ,\r1_OBUF[31]_inst_i_69_n_0 ,\r1_OBUF[31]_inst_i_70_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_58 
       (.I0(r_IBUF[23]),
        .I1(\r1_OBUF[31]_inst_i_71_n_6 ),
        .O(\r1_OBUF[31]_inst_i_58_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_59 
       (.I0(r_IBUF[22]),
        .I1(\r1_OBUF[31]_inst_i_71_n_7 ),
        .O(\r1_OBUF[31]_inst_i_59_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEFEA)) 
    \r1_OBUF[31]_inst_i_6 
       (.I0(p_0_in__0[6]),
        .I1(\r1_OBUF[31]_inst_i_22_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_23_n_4 ),
        .I4(p_0_in__0[4]),
        .I5(p_0_in__0[5]),
        .O(\r1_OBUF[31]_inst_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_60 
       (.I0(r_IBUF[21]),
        .I1(\r1_OBUF[31]_inst_i_72_n_4 ),
        .O(\r1_OBUF[31]_inst_i_60_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_61 
       (.I0(r_IBUF[20]),
        .I1(\r1_OBUF[31]_inst_i_72_n_5 ),
        .O(\r1_OBUF[31]_inst_i_61_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_62 
       (.CI(\r1_OBUF[13]_inst_i_8_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_62_n_0 ,\r1_OBUF[31]_inst_i_62_n_1 ,\r1_OBUF[31]_inst_i_62_n_2 ,\r1_OBUF[31]_inst_i_62_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\r1_OBUF[31]_inst_i_62_n_4 ,\r1_OBUF[31]_inst_i_62_n_5 ,\r1_OBUF[31]_inst_i_62_n_6 ,\r1_OBUF[31]_inst_i_62_n_7 }),
        .S({\r1_OBUF[31]_inst_i_63_n_4 ,\r1_OBUF[31]_inst_i_63_n_5 ,\r1_OBUF[31]_inst_i_63_n_6 ,\r1_OBUF[31]_inst_i_73_n_0 }));
  CARRY4 \r1_OBUF[31]_inst_i_63 
       (.CI(\r1_OBUF[13]_inst_i_9_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_63_n_0 ,\r1_OBUF[31]_inst_i_63_n_1 ,\r1_OBUF[31]_inst_i_63_n_2 ,\r1_OBUF[31]_inst_i_63_n_3 }),
        .CYINIT(1'b0),
        .DI(r_IBUF[15:12]),
        .O({\r1_OBUF[31]_inst_i_63_n_4 ,\r1_OBUF[31]_inst_i_63_n_5 ,\r1_OBUF[31]_inst_i_63_n_6 ,\r1_OBUF[31]_inst_i_63_n_7 }),
        .S({\r1_OBUF[31]_inst_i_74_n_0 ,\r1_OBUF[31]_inst_i_75_n_0 ,\r1_OBUF[31]_inst_i_76_n_0 ,\r1_OBUF[31]_inst_i_77_n_0 }));
  CARRY4 \r1_OBUF[31]_inst_i_64 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_64_n_0 ,\r1_OBUF[31]_inst_i_64_n_1 ,\r1_OBUF[31]_inst_i_64_n_2 ,\r1_OBUF[31]_inst_i_64_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\r1_OBUF[31]_inst_i_78_n_7 ,1'b0}),
        .O({\r1_OBUF[31]_inst_i_64_n_4 ,\r1_OBUF[31]_inst_i_64_n_5 ,\r1_OBUF[31]_inst_i_64_n_6 ,\r1_OBUF[31]_inst_i_64_n_7 }),
        .S({\r1_OBUF[31]_inst_i_79_n_0 ,\r1_OBUF[31]_inst_i_78_n_6 ,\r1_OBUF[31]_inst_i_80_n_0 ,\r1_OBUF[31]_inst_i_81_n_0 }));
  CARRY4 \r1_OBUF[31]_inst_i_65 
       (.CI(1'b0),
        .CO({\NLW_r1_OBUF[31]_inst_i_65_CO_UNCONNECTED [3],\r1_OBUF[31]_inst_i_65_n_1 ,\NLW_r1_OBUF[31]_inst_i_65_CO_UNCONNECTED [1],\r1_OBUF[31]_inst_i_65_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,r_IBUF[25],1'b0}),
        .O({\NLW_r1_OBUF[31]_inst_i_65_O_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_65_n_6 ,\r1_OBUF[31]_inst_i_65_n_7 }),
        .S({1'b0,1'b1,r_IBUF[25:24]}));
  CARRY4 \r1_OBUF[31]_inst_i_66 
       (.CI(\r1_OBUF[31]_inst_i_64_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_66_n_0 ,\NLW_r1_OBUF[31]_inst_i_66_CO_UNCONNECTED [2],\r1_OBUF[31]_inst_i_66_n_2 ,\r1_OBUF[31]_inst_i_66_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\r1_OBUF[31]_inst_i_82_n_1 ,1'b0,\r1_OBUF[31]_inst_i_82_n_7 }),
        .O({\NLW_r1_OBUF[31]_inst_i_66_O_UNCONNECTED [3],\r1_OBUF[31]_inst_i_66_n_5 ,\r1_OBUF[31]_inst_i_66_n_6 ,\r1_OBUF[31]_inst_i_66_n_7 }),
        .S({1'b1,\r1_OBUF[31]_inst_i_82_n_1 ,\r1_OBUF[31]_inst_i_82_n_6 ,\r1_OBUF[31]_inst_i_83_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_67 
       (.I0(r_IBUF[19]),
        .I1(\r1_OBUF[31]_inst_i_72_n_6 ),
        .O(\r1_OBUF[31]_inst_i_67_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_68 
       (.I0(r_IBUF[18]),
        .I1(\r1_OBUF[31]_inst_i_84_n_0 ),
        .O(\r1_OBUF[31]_inst_i_68_n_0 ));
  LUT5 #(
    .INIT(32'h69699669)) 
    \r1_OBUF[31]_inst_i_69 
       (.I0(r_IBUF[17]),
        .I1(\r1_OBUF[31]_inst_i_85_n_5 ),
        .I2(r_IBUF[27]),
        .I3(r_IBUF[26]),
        .I4(\r1_OBUF[31]_inst_i_85_n_6 ),
        .O(\r1_OBUF[31]_inst_i_69_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF7FFF)) 
    \r1_OBUF[31]_inst_i_7 
       (.I0(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I1(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_7 ),
        .I3(\r1_OBUF[31]_inst_i_14_n_4 ),
        .I4(\r1_OBUF[31]_inst_i_26_n_0 ),
        .O(\r1_OBUF[31]_inst_i_7_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \r1_OBUF[31]_inst_i_70 
       (.I0(r_IBUF[16]),
        .I1(r_IBUF[26]),
        .I2(\r1_OBUF[31]_inst_i_85_n_6 ),
        .O(\r1_OBUF[31]_inst_i_70_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_71 
       (.CI(\r1_OBUF[31]_inst_i_72_n_0 ),
        .CO({\NLW_r1_OBUF[31]_inst_i_71_CO_UNCONNECTED [3:1],\r1_OBUF[31]_inst_i_71_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\r1_OBUF[31]_inst_i_86_n_0 }),
        .O({\NLW_r1_OBUF[31]_inst_i_71_O_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_71_n_6 ,\r1_OBUF[31]_inst_i_71_n_7 }),
        .S({1'b0,1'b0,\r1_OBUF[31]_inst_i_87_n_0 ,\r1_OBUF[31]_inst_i_88_n_0 }));
  CARRY4 \r1_OBUF[31]_inst_i_72 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_72_n_0 ,\r1_OBUF[31]_inst_i_72_n_1 ,\r1_OBUF[31]_inst_i_72_n_2 ,\r1_OBUF[31]_inst_i_72_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[31]_inst_i_89_n_0 ,\r1_OBUF[31]_inst_i_90_n_0 ,\r1_OBUF[31]_inst_i_91_n_0 ,\r1_OBUF[31]_inst_i_92_n_0 }),
        .O({\r1_OBUF[31]_inst_i_72_n_4 ,\r1_OBUF[31]_inst_i_72_n_5 ,\r1_OBUF[31]_inst_i_72_n_6 ,\NLW_r1_OBUF[31]_inst_i_72_O_UNCONNECTED [0]}),
        .S({\r1_OBUF[31]_inst_i_93_n_0 ,\r1_OBUF[31]_inst_i_94_n_0 ,\r1_OBUF[31]_inst_i_95_n_0 ,\r1_OBUF[31]_inst_i_96_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_73 
       (.I0(\r1_OBUF[31]_inst_i_63_n_7 ),
        .O(\r1_OBUF[31]_inst_i_73_n_0 ));
  LUT4 #(
    .INIT(16'h5A69)) 
    \r1_OBUF[31]_inst_i_74 
       (.I0(r_IBUF[15]),
        .I1(r_IBUF[23]),
        .I2(r_IBUF[25]),
        .I3(r_IBUF[24]),
        .O(\r1_OBUF[31]_inst_i_74_n_0 ));
  LUT3 #(
    .INIT(8'h69)) 
    \r1_OBUF[31]_inst_i_75 
       (.I0(r_IBUF[14]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_75_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \r1_OBUF[31]_inst_i_76 
       (.I0(r_IBUF[13]),
        .I1(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_76_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[31]_inst_i_77 
       (.I0(r_IBUF[12]),
        .O(\r1_OBUF[31]_inst_i_77_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_78 
       (.CI(1'b0),
        .CO({\NLW_r1_OBUF[31]_inst_i_78_CO_UNCONNECTED [3],\r1_OBUF[31]_inst_i_78_n_1 ,\NLW_r1_OBUF[31]_inst_i_78_CO_UNCONNECTED [1],\r1_OBUF[31]_inst_i_78_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,r_IBUF[28],1'b0}),
        .O({\NLW_r1_OBUF[31]_inst_i_78_O_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_78_n_6 ,\r1_OBUF[31]_inst_i_78_n_7 }),
        .S({1'b0,1'b1,r_IBUF[28:27]}));
  LUT2 #(
    .INIT(4'h6)) 
    \r1_OBUF[31]_inst_i_79 
       (.I0(\r1_OBUF[31]_inst_i_78_n_1 ),
        .I1(r_IBUF[29]),
        .O(\r1_OBUF[31]_inst_i_79_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_8 
       (.CI(\r1_OBUF[13]_inst_i_10_n_0 ),
        .CO({\r1_OBUF[31]_inst_i_8_n_0 ,\r1_OBUF[31]_inst_i_8_n_1 ,\r1_OBUF[31]_inst_i_8_n_2 ,\r1_OBUF[31]_inst_i_8_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b0}),
        .O({\r1_OBUF[31]_inst_i_8_n_4 ,\r1_OBUF[31]_inst_i_8_n_5 ,\r1_OBUF[31]_inst_i_8_n_6 ,\r1_OBUF[31]_inst_i_8_n_7 }),
        .S({\r1_OBUF[31]_inst_i_27_n_0 ,\r1_OBUF[31]_inst_i_28_n_0 ,\r1_OBUF[31]_inst_i_29_n_0 ,p_0_in[18]}));
  LUT3 #(
    .INIT(8'h78)) 
    \r1_OBUF[31]_inst_i_80 
       (.I0(\r1_OBUF[31]_inst_i_65_n_1 ),
        .I1(r_IBUF[26]),
        .I2(\r1_OBUF[31]_inst_i_78_n_7 ),
        .O(\r1_OBUF[31]_inst_i_80_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \r1_OBUF[31]_inst_i_81 
       (.I0(\r1_OBUF[31]_inst_i_65_n_1 ),
        .I1(r_IBUF[26]),
        .O(\r1_OBUF[31]_inst_i_81_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_82 
       (.CI(1'b0),
        .CO({\NLW_r1_OBUF[31]_inst_i_82_CO_UNCONNECTED [3],\r1_OBUF[31]_inst_i_82_n_1 ,\NLW_r1_OBUF[31]_inst_i_82_CO_UNCONNECTED [1],\r1_OBUF[31]_inst_i_82_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,r_IBUF[31],1'b0}),
        .O({\NLW_r1_OBUF[31]_inst_i_82_O_UNCONNECTED [3:2],\r1_OBUF[31]_inst_i_82_n_6 ,\r1_OBUF[31]_inst_i_82_n_7 }),
        .S({1'b0,1'b1,r_IBUF[31:30]}));
  LUT3 #(
    .INIT(8'h78)) 
    \r1_OBUF[31]_inst_i_83 
       (.I0(\r1_OBUF[31]_inst_i_78_n_1 ),
        .I1(r_IBUF[29]),
        .I2(\r1_OBUF[31]_inst_i_82_n_7 ),
        .O(\r1_OBUF[31]_inst_i_83_n_0 ));
  LUT6 #(
    .INIT(64'h639C33CCCC33639C)) 
    \r1_OBUF[31]_inst_i_84 
       (.I0(\r1_OBUF[31]_inst_i_85_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_85_n_4 ),
        .I2(r_IBUF[26]),
        .I3(r_IBUF[28]),
        .I4(r_IBUF[27]),
        .I5(\r1_OBUF[31]_inst_i_85_n_5 ),
        .O(\r1_OBUF[31]_inst_i_84_n_0 ));
  CARRY4 \r1_OBUF[31]_inst_i_85 
       (.CI(1'b0),
        .CO({\r1_OBUF[31]_inst_i_85_n_0 ,\r1_OBUF[31]_inst_i_85_n_1 ,\r1_OBUF[31]_inst_i_85_n_2 ,\r1_OBUF[31]_inst_i_85_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[31]_inst_i_97_n_0 ,\r1_OBUF[31]_inst_i_98_n_0 ,\r1_OBUF[31]_inst_i_99_n_0 ,\r1_OBUF[31]_inst_i_100_n_0 }),
        .O({\r1_OBUF[31]_inst_i_85_n_4 ,\r1_OBUF[31]_inst_i_85_n_5 ,\r1_OBUF[31]_inst_i_85_n_6 ,\NLW_r1_OBUF[31]_inst_i_85_O_UNCONNECTED [0]}),
        .S({\r1_OBUF[31]_inst_i_101_n_0 ,\r1_OBUF[31]_inst_i_102_n_0 ,\r1_OBUF[31]_inst_i_103_n_0 ,\r1_OBUF[31]_inst_i_104_n_0 }));
  LUT5 #(
    .INIT(32'hF6600000)) 
    \r1_OBUF[31]_inst_i_86 
       (.I0(r_IBUF[30]),
        .I1(r_IBUF[29]),
        .I2(\r1_OBUF[31]_inst_i_105_n_5 ),
        .I3(\r1_OBUF[31]_inst_i_106_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_107_n_0 ),
        .O(\r1_OBUF[31]_inst_i_86_n_0 ));
  LUT5 #(
    .INIT(32'h82287DD7)) 
    \r1_OBUF[31]_inst_i_87 
       (.I0(\r1_OBUF[31]_inst_i_108_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_106_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_109_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_110_n_7 ),
        .I4(\r1_OBUF[31]_inst_i_111_n_0 ),
        .O(\r1_OBUF[31]_inst_i_87_n_0 ));
  LUT5 #(
    .INIT(32'h9336366C)) 
    \r1_OBUF[31]_inst_i_88 
       (.I0(\r1_OBUF[31]_inst_i_112_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_113_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_114_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_105_n_4 ),
        .I4(\r1_OBUF[31]_inst_i_106_n_5 ),
        .O(\r1_OBUF[31]_inst_i_88_n_0 ));
  LUT6 #(
    .INIT(64'h40A8A840A84040A8)) 
    \r1_OBUF[31]_inst_i_89 
       (.I0(r_IBUF[29]),
        .I1(\r1_OBUF[31]_inst_i_105_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_106_n_7 ),
        .I3(\r1_OBUF[31]_inst_i_106_n_6 ),
        .I4(r_IBUF[30]),
        .I5(\r1_OBUF[31]_inst_i_105_n_5 ),
        .O(\r1_OBUF[31]_inst_i_89_n_0 ));
  LUT3 #(
    .INIT(8'h1D)) 
    \r1_OBUF[31]_inst_i_9 
       (.I0(\r1_OBUF[31]_inst_i_31_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_5 ),
        .O(\r1_OBUF[31]_inst_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h96000000)) 
    \r1_OBUF[31]_inst_i_90 
       (.I0(\r1_OBUF[31]_inst_i_106_n_7 ),
        .I1(r_IBUF[29]),
        .I2(\r1_OBUF[31]_inst_i_105_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_115_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_85_n_4 ),
        .O(\r1_OBUF[31]_inst_i_90_n_0 ));
  LUT5 #(
    .INIT(32'h21840000)) 
    \r1_OBUF[31]_inst_i_91 
       (.I0(\r1_OBUF[31]_inst_i_85_n_4 ),
        .I1(r_IBUF[26]),
        .I2(r_IBUF[28]),
        .I3(r_IBUF[27]),
        .I4(\r1_OBUF[31]_inst_i_85_n_5 ),
        .O(\r1_OBUF[31]_inst_i_91_n_0 ));
  LUT4 #(
    .INIT(16'h9000)) 
    \r1_OBUF[31]_inst_i_92 
       (.I0(\r1_OBUF[31]_inst_i_85_n_5 ),
        .I1(r_IBUF[27]),
        .I2(r_IBUF[26]),
        .I3(\r1_OBUF[31]_inst_i_85_n_6 ),
        .O(\r1_OBUF[31]_inst_i_92_n_0 ));
  LUT6 #(
    .INIT(64'h6666966996699999)) 
    \r1_OBUF[31]_inst_i_93 
       (.I0(\r1_OBUF[31]_inst_i_116_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_107_n_0 ),
        .I2(r_IBUF[30]),
        .I3(r_IBUF[29]),
        .I4(\r1_OBUF[31]_inst_i_105_n_5 ),
        .I5(\r1_OBUF[31]_inst_i_106_n_6 ),
        .O(\r1_OBUF[31]_inst_i_93_n_0 ));
  LUT6 #(
    .INIT(64'h870F0F780F7878F0)) 
    \r1_OBUF[31]_inst_i_94 
       (.I0(\r1_OBUF[31]_inst_i_115_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_85_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_117_n_0 ),
        .I3(r_IBUF[29]),
        .I4(\r1_OBUF[31]_inst_i_105_n_6 ),
        .I5(\r1_OBUF[31]_inst_i_106_n_7 ),
        .O(\r1_OBUF[31]_inst_i_94_n_0 ));
  LUT6 #(
    .INIT(64'hC633633CCCC6CC6C)) 
    \r1_OBUF[31]_inst_i_95 
       (.I0(\r1_OBUF[31]_inst_i_85_n_5 ),
        .I1(\r1_OBUF[31]_inst_i_118_n_0 ),
        .I2(r_IBUF[26]),
        .I3(r_IBUF[28]),
        .I4(r_IBUF[27]),
        .I5(\r1_OBUF[31]_inst_i_85_n_4 ),
        .O(\r1_OBUF[31]_inst_i_95_n_0 ));
  LUT6 #(
    .INIT(64'h639C33CCCC33639C)) 
    \r1_OBUF[31]_inst_i_96 
       (.I0(\r1_OBUF[31]_inst_i_85_n_6 ),
        .I1(\r1_OBUF[31]_inst_i_85_n_4 ),
        .I2(r_IBUF[26]),
        .I3(r_IBUF[28]),
        .I4(r_IBUF[27]),
        .I5(\r1_OBUF[31]_inst_i_85_n_5 ),
        .O(\r1_OBUF[31]_inst_i_96_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_97 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_97_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_98 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_98_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \r1_OBUF[31]_inst_i_99 
       (.I0(r_IBUF[25]),
        .I1(r_IBUF[24]),
        .I2(r_IBUF[23]),
        .O(\r1_OBUF[31]_inst_i_99_n_0 ));
  OBUF \r1_OBUF[3]_inst 
       (.I(r1_OBUF[3]),
        .O(r1[3]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[3]_inst_i_1 
       (.I0(data0[3]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[3]));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_10 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I3(r13[21]),
        .O(\r1_OBUF[3]_inst_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_11 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I3(r13[20]),
        .O(\r1_OBUF[3]_inst_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_12 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_6 ),
        .I3(r13[19]),
        .O(\r1_OBUF[3]_inst_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \r1_OBUF[3]_inst_i_13 
       (.I0(\r1_OBUF[3]_inst_i_3_n_7 ),
        .O(\r1_OBUF[3]_inst_i_13_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_14 
       (.CI(\r1_OBUF[3]_inst_i_23_n_0 ),
        .CO({\r1_OBUF[3]_inst_i_14_n_0 ,\r1_OBUF[3]_inst_i_14_n_1 ,\r1_OBUF[3]_inst_i_14_n_2 ,\r1_OBUF[3]_inst_i_14_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_24_n_0 ,\r1_OBUF[3]_inst_i_25_n_0 ,\r1_OBUF[3]_inst_i_26_n_0 ,\r1_OBUF[3]_inst_i_27_n_0 }),
        .O(\NLW_r1_OBUF[3]_inst_i_14_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[3]_inst_i_28_n_0 ,\r1_OBUF[3]_inst_i_29_n_0 ,\r1_OBUF[3]_inst_i_30_n_0 ,\r1_OBUF[3]_inst_i_31_n_0 }));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_15 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_15_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_16 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_16_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_17 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_17_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_18 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_18_n_0 ));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_19 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_8_n_7 ),
        .I3(r13[18]),
        .O(\r1_OBUF[3]_inst_i_19_n_0 ));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[3]_inst_i_2 
       (.I0(r11[3]),
        .I1(\r1_OBUF[3]_inst_i_3_n_4 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[3]_inst_i_4_n_4 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[3]));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_20 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_4 ),
        .I3(r13[17]),
        .O(\r1_OBUF[3]_inst_i_20_n_0 ));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_21 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_5 ),
        .I3(r13[16]),
        .O(\r1_OBUF[3]_inst_i_21_n_0 ));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_22 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_6 ),
        .I3(r13[15]),
        .O(\r1_OBUF[3]_inst_i_22_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_23 
       (.CI(\r1_OBUF[3]_inst_i_32_n_0 ),
        .CO({\r1_OBUF[3]_inst_i_23_n_0 ,\r1_OBUF[3]_inst_i_23_n_1 ,\r1_OBUF[3]_inst_i_23_n_2 ,\r1_OBUF[3]_inst_i_23_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_33_n_0 ,\r1_OBUF[3]_inst_i_34_n_0 ,\r1_OBUF[3]_inst_i_35_n_0 ,\r1_OBUF[3]_inst_i_36_n_0 }),
        .O(\NLW_r1_OBUF[3]_inst_i_23_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[3]_inst_i_37_n_0 ,\r1_OBUF[3]_inst_i_38_n_0 ,\r1_OBUF[3]_inst_i_39_n_0 ,\r1_OBUF[3]_inst_i_40_n_0 }));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_24 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_24_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \r1_OBUF[3]_inst_i_25 
       (.I0(r13[23]),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_25_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_26 
       (.I0(r13[22]),
        .I1(\r1_OBUF[31]_inst_i_2_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_26_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_27 
       (.I0(r13[21]),
        .I1(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_27_n_0 ));
  LUT4 #(
    .INIT(16'hE2D1)) 
    \r1_OBUF[3]_inst_i_28 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[13]_inst_i_10_n_7 ),
        .I3(r13[14]),
        .O(\r1_OBUF[3]_inst_i_28_n_0 ));
  LUT4 #(
    .INIT(16'hD1E2)) 
    \r1_OBUF[3]_inst_i_29 
       (.I0(r13[23]),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_14_n_4 ),
        .I3(r13[13]),
        .O(\r1_OBUF[3]_inst_i_29_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_3 
       (.CI(\r1_OBUF[3]_inst_i_5_n_0 ),
        .CO({\r1_OBUF[3]_inst_i_3_n_0 ,\r1_OBUF[3]_inst_i_3_n_1 ,\r1_OBUF[3]_inst_i_3_n_2 ,\r1_OBUF[3]_inst_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\r1_OBUF[3]_inst_i_6_n_0 ,\r1_OBUF[3]_inst_i_7_n_0 ,\r1_OBUF[3]_inst_i_8_n_0 }),
        .O({\r1_OBUF[3]_inst_i_3_n_4 ,\r1_OBUF[3]_inst_i_3_n_5 ,\r1_OBUF[3]_inst_i_3_n_6 ,\r1_OBUF[3]_inst_i_3_n_7 }),
        .S({\r1_OBUF[3]_inst_i_9_n_0 ,\r1_OBUF[3]_inst_i_10_n_0 ,\r1_OBUF[3]_inst_i_11_n_0 ,\r1_OBUF[3]_inst_i_12_n_0 }));
  LUT5 #(
    .INIT(32'h1DD12EE2)) 
    \r1_OBUF[3]_inst_i_30 
       (.I0(r13[22]),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_7 ),
        .I3(\r1_OBUF[31]_inst_i_14_n_5 ),
        .I4(r13[12]),
        .O(\r1_OBUF[3]_inst_i_30_n_0 ));
  LUT5 #(
    .INIT(32'h53A35CAC)) 
    \r1_OBUF[3]_inst_i_31 
       (.I0(\r1_OBUF[31]_inst_i_8_n_4 ),
        .I1(r13[21]),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I3(\r1_OBUF[31]_inst_i_14_n_6 ),
        .I4(r13[11]),
        .O(\r1_OBUF[3]_inst_i_31_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_32 
       (.CI(\r1_OBUF[3]_inst_i_41_n_0 ),
        .CO({\r1_OBUF[3]_inst_i_32_n_0 ,\r1_OBUF[3]_inst_i_32_n_1 ,\r1_OBUF[3]_inst_i_32_n_2 ,\r1_OBUF[3]_inst_i_32_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_42_n_0 ,\r1_OBUF[3]_inst_i_43_n_0 ,\r1_OBUF[3]_inst_i_44_n_0 ,\r1_OBUF[3]_inst_i_45_n_0 }),
        .O(\NLW_r1_OBUF[3]_inst_i_32_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[3]_inst_i_46_n_0 ,\r1_OBUF[3]_inst_i_47_n_0 ,\r1_OBUF[3]_inst_i_48_n_0 ,\r1_OBUF[3]_inst_i_49_n_0 }));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_33 
       (.I0(r13[20]),
        .I1(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_33_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_34 
       (.I0(r13[19]),
        .I1(\r1_OBUF[31]_inst_i_8_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_34_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_35 
       (.I0(r13[18]),
        .I1(\r1_OBUF[31]_inst_i_8_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_35_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_36 
       (.I0(r13[17]),
        .I1(\r1_OBUF[13]_inst_i_10_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_36_n_0 ));
  LUT5 #(
    .INIT(32'h53A35CAC)) 
    \r1_OBUF[3]_inst_i_37 
       (.I0(\r1_OBUF[31]_inst_i_8_n_5 ),
        .I1(r13[20]),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I3(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I4(r13[10]),
        .O(\r1_OBUF[3]_inst_i_37_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_38 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_34_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I5(r13[9]),
        .O(\r1_OBUF[3]_inst_i_38_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_39 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_35_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_9_n_7 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[13]_inst_i_8_n_7 ),
        .I5(r13[8]),
        .O(\r1_OBUF[3]_inst_i_39_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_4 
       (.CI(1'b0),
        .CO({\r1_OBUF[3]_inst_i_4_n_0 ,\r1_OBUF[3]_inst_i_4_n_1 ,\r1_OBUF[3]_inst_i_4_n_2 ,\r1_OBUF[3]_inst_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\r1_OBUF[3]_inst_i_4_n_4 ,\r1_OBUF[3]_inst_i_4_n_5 ,\r1_OBUF[3]_inst_i_4_n_6 ,\r1_OBUF[3]_inst_i_4_n_7 }),
        .S({\r1_OBUF[3]_inst_i_3_n_4 ,\r1_OBUF[3]_inst_i_3_n_5 ,\r1_OBUF[3]_inst_i_3_n_6 ,\r1_OBUF[3]_inst_i_13_n_0 }));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_40 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_36_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_4 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_22_n_4 ),
        .I5(r13[7]),
        .O(\r1_OBUF[3]_inst_i_40_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_41 
       (.CI(1'b0),
        .CO({\r1_OBUF[3]_inst_i_41_n_0 ,\r1_OBUF[3]_inst_i_41_n_1 ,\r1_OBUF[3]_inst_i_41_n_2 ,\r1_OBUF[3]_inst_i_41_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_50_n_0 ,\r1_OBUF[3]_inst_i_51_n_0 ,\r1_OBUF[3]_inst_i_52_n_0 ,1'b0}),
        .O(\NLW_r1_OBUF[3]_inst_i_41_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[3]_inst_i_53_n_0 ,\r1_OBUF[3]_inst_i_54_n_0 ,\r1_OBUF[3]_inst_i_55_n_0 ,\r1_OBUF[3]_inst_i_56_n_0 }));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_42 
       (.I0(r13[16]),
        .I1(\r1_OBUF[13]_inst_i_10_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_42_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_43 
       (.I0(r13[15]),
        .I1(\r1_OBUF[13]_inst_i_10_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_43_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_44 
       (.I0(r13[14]),
        .I1(\r1_OBUF[13]_inst_i_10_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_44_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_45 
       (.I0(r13[13]),
        .I1(\r1_OBUF[31]_inst_i_14_n_4 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_45_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_46 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_42_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_5 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_22_n_5 ),
        .I5(r13[6]),
        .O(\r1_OBUF[3]_inst_i_46_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_47 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_43_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_22_n_6 ),
        .I5(r13[5]),
        .O(\r1_OBUF[3]_inst_i_47_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_48 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_44_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_23_n_7 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_22_n_7 ),
        .I5(r13[4]),
        .O(\r1_OBUF[3]_inst_i_48_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_49 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_45_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_4 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_16_n_4 ),
        .I5(r13[3]),
        .O(\r1_OBUF[3]_inst_i_49_n_0 ));
  CARRY4 \r1_OBUF[3]_inst_i_5 
       (.CI(\r1_OBUF[3]_inst_i_14_n_0 ),
        .CO({\r1_OBUF[3]_inst_i_5_n_0 ,\r1_OBUF[3]_inst_i_5_n_1 ,\r1_OBUF[3]_inst_i_5_n_2 ,\r1_OBUF[3]_inst_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({\r1_OBUF[3]_inst_i_15_n_0 ,\r1_OBUF[3]_inst_i_16_n_0 ,\r1_OBUF[3]_inst_i_17_n_0 ,\r1_OBUF[3]_inst_i_18_n_0 }),
        .O(\NLW_r1_OBUF[3]_inst_i_5_O_UNCONNECTED [3:0]),
        .S({\r1_OBUF[3]_inst_i_19_n_0 ,\r1_OBUF[3]_inst_i_20_n_0 ,\r1_OBUF[3]_inst_i_21_n_0 ,\r1_OBUF[3]_inst_i_22_n_0 }));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_50 
       (.I0(r13[12]),
        .I1(\r1_OBUF[31]_inst_i_14_n_5 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_50_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_51 
       (.I0(r13[11]),
        .I1(\r1_OBUF[31]_inst_i_14_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_51_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_52 
       (.I0(r13[10]),
        .I1(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_52_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_53 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_50_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_5 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_16_n_5 ),
        .I5(r13[2]),
        .O(\r1_OBUF[3]_inst_i_53_n_0 ));
  LUT6 #(
    .INIT(64'h33399939666CCC6C)) 
    \r1_OBUF[3]_inst_i_54 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[3]_inst_i_51_n_0 ),
        .I2(\r1_OBUF[31]_inst_i_18_n_6 ),
        .I3(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_16_n_6 ),
        .I5(r13[1]),
        .O(\r1_OBUF[3]_inst_i_54_n_0 ));
  LUT6 #(
    .INIT(64'h272727D8D8D827D8)) 
    \r1_OBUF[3]_inst_i_55 
       (.I0(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I1(\r1_OBUF[31]_inst_i_14_n_7 ),
        .I2(r13[10]),
        .I3(\r1_OBUF[31]_inst_i_18_n_7 ),
        .I4(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_16_n_7 ),
        .O(\r1_OBUF[3]_inst_i_55_n_0 ));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[3]_inst_i_56 
       (.I0(r13[9]),
        .I1(\r1_OBUF[13]_inst_i_8_n_6 ),
        .I2(\r1_OBUF[31]_inst_i_17_n_0 ),
        .I3(\r1_OBUF[13]_inst_i_9_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_56_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_6 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_7 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[3]_inst_i_8 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_8_n_0 ));
  LUT3 #(
    .INIT(8'hCA)) 
    \r1_OBUF[3]_inst_i_9 
       (.I0(r13[22]),
        .I1(\r1_OBUF[31]_inst_i_2_n_7 ),
        .I2(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[3]_inst_i_9_n_0 ));
  OBUF \r1_OBUF[4]_inst 
       (.I(r1_OBUF[4]),
        .O(r1[4]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[4]_inst_i_1 
       (.I0(data0[4]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[4]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[4]_inst_i_2 
       (.I0(r11[4]),
        .I1(\r1_OBUF[7]_inst_i_3_n_7 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[7]_inst_i_4_n_7 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[4]));
  CARRY4 \r1_OBUF[4]_inst_i_3 
       (.CI(1'b0),
        .CO({\r1_OBUF[4]_inst_i_3_n_0 ,\r1_OBUF[4]_inst_i_3_n_1 ,\r1_OBUF[4]_inst_i_3_n_2 ,\r1_OBUF[4]_inst_i_3_n_3 }),
        .CYINIT(\r1_OBUF[4]_inst_i_4_n_0 ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r11[4:1]),
        .S({\r1_OBUF[4]_inst_i_5_n_0 ,\r1_OBUF[4]_inst_i_6_n_0 ,\r1_OBUF[4]_inst_i_7_n_0 ,\r1_OBUF[4]_inst_i_8_n_0 }));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[4]_inst_i_4 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[3]_inst_i_4_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[3]_inst_i_3_n_7 ),
        .O(\r1_OBUF[4]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[4]_inst_i_5 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[7]_inst_i_4_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[7]_inst_i_3_n_7 ),
        .O(\r1_OBUF[4]_inst_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[4]_inst_i_6 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[3]_inst_i_4_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[3]_inst_i_3_n_4 ),
        .O(\r1_OBUF[4]_inst_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[4]_inst_i_7 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[3]_inst_i_4_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[3]_inst_i_3_n_5 ),
        .O(\r1_OBUF[4]_inst_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[4]_inst_i_8 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[3]_inst_i_4_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[3]_inst_i_3_n_6 ),
        .O(\r1_OBUF[4]_inst_i_8_n_0 ));
  OBUF \r1_OBUF[5]_inst 
       (.I(r1_OBUF[5]),
        .O(r1[5]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[5]_inst_i_1 
       (.I0(data0[5]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[5]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[5]_inst_i_2 
       (.I0(r11[5]),
        .I1(\r1_OBUF[7]_inst_i_3_n_6 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[7]_inst_i_4_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[5]));
  OBUF \r1_OBUF[6]_inst 
       (.I(r1_OBUF[6]),
        .O(r1[6]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[6]_inst_i_1 
       (.I0(data0[6]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[6]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[6]_inst_i_2 
       (.I0(r11[6]),
        .I1(\r1_OBUF[7]_inst_i_3_n_5 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[7]_inst_i_4_n_5 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[6]));
  OBUF \r1_OBUF[7]_inst 
       (.I(r1_OBUF[7]),
        .O(r1[7]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[7]_inst_i_1 
       (.I0(data0[7]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[7]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[7]_inst_i_2 
       (.I0(r11[7]),
        .I1(\r1_OBUF[7]_inst_i_3_n_4 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[7]_inst_i_4_n_4 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[7]));
  CARRY4 \r1_OBUF[7]_inst_i_3 
       (.CI(\r1_OBUF[3]_inst_i_3_n_0 ),
        .CO({\r1_OBUF[7]_inst_i_3_n_0 ,\r1_OBUF[7]_inst_i_3_n_1 ,\r1_OBUF[7]_inst_i_3_n_2 ,\r1_OBUF[7]_inst_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\r1_OBUF[7]_inst_i_3_n_4 ,\r1_OBUF[7]_inst_i_3_n_5 ,\r1_OBUF[7]_inst_i_3_n_6 ,\r1_OBUF[7]_inst_i_3_n_7 }),
        .S({\r1_OBUF[7]_inst_i_5_n_0 ,\r1_OBUF[7]_inst_i_6_n_0 ,\r1_OBUF[7]_inst_i_7_n_0 ,\r1_OBUF[7]_inst_i_8_n_0 }));
  CARRY4 \r1_OBUF[7]_inst_i_4 
       (.CI(\r1_OBUF[3]_inst_i_4_n_0 ),
        .CO({\r1_OBUF[7]_inst_i_4_n_0 ,\r1_OBUF[7]_inst_i_4_n_1 ,\r1_OBUF[7]_inst_i_4_n_2 ,\r1_OBUF[7]_inst_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\r1_OBUF[7]_inst_i_4_n_4 ,\r1_OBUF[7]_inst_i_4_n_5 ,\r1_OBUF[7]_inst_i_4_n_6 ,\r1_OBUF[7]_inst_i_4_n_7 }),
        .S({\r1_OBUF[7]_inst_i_3_n_4 ,\r1_OBUF[7]_inst_i_3_n_5 ,\r1_OBUF[7]_inst_i_3_n_6 ,\r1_OBUF[7]_inst_i_3_n_7 }));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[7]_inst_i_5 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[7]_inst_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[7]_inst_i_6 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[7]_inst_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \r1_OBUF[7]_inst_i_7 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[7]_inst_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \r1_OBUF[7]_inst_i_8 
       (.I0(r13[23]),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(\r1_OBUF[7]_inst_i_8_n_0 ));
  OBUF \r1_OBUF[8]_inst 
       (.I(r1_OBUF[8]),
        .O(r1[8]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[8]_inst_i_1 
       (.I0(data0[8]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[8]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[8]_inst_i_2 
       (.I0(r11[8]),
        .I1(\r1_OBUF[11]_inst_i_3_n_7 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[11]_inst_i_4_n_7 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[8]));
  CARRY4 \r1_OBUF[8]_inst_i_3 
       (.CI(\r1_OBUF[4]_inst_i_3_n_0 ),
        .CO({\r1_OBUF[8]_inst_i_3_n_0 ,\r1_OBUF[8]_inst_i_3_n_1 ,\r1_OBUF[8]_inst_i_3_n_2 ,\r1_OBUF[8]_inst_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(r11[8:5]),
        .S({\r1_OBUF[8]_inst_i_4_n_0 ,\r1_OBUF[8]_inst_i_5_n_0 ,\r1_OBUF[8]_inst_i_6_n_0 ,\r1_OBUF[8]_inst_i_7_n_0 }));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[8]_inst_i_4 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[11]_inst_i_4_n_7 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[11]_inst_i_3_n_7 ),
        .O(\r1_OBUF[8]_inst_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[8]_inst_i_5 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[7]_inst_i_4_n_4 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[7]_inst_i_3_n_4 ),
        .O(\r1_OBUF[8]_inst_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[8]_inst_i_6 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[7]_inst_i_4_n_5 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[7]_inst_i_3_n_5 ),
        .O(\r1_OBUF[8]_inst_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000010FFFFFEF0F)) 
    \r1_OBUF[8]_inst_i_7 
       (.I0(\r1_OBUF[0]_inst_i_3_n_0 ),
        .I1(\r1_OBUF[31]_inst_i_2_n_2 ),
        .I2(\r1_OBUF[7]_inst_i_4_n_6 ),
        .I3(\r1_OBUF[0]_inst_i_5_n_5 ),
        .I4(\r1_OBUF[0]_inst_i_4_n_1 ),
        .I5(\r1_OBUF[7]_inst_i_3_n_6 ),
        .O(\r1_OBUF[8]_inst_i_7_n_0 ));
  OBUF \r1_OBUF[9]_inst 
       (.I(r1_OBUF[9]),
        .O(r1[9]));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAA8)) 
    \r1_OBUF[9]_inst_i_1 
       (.I0(data0[9]),
        .I1(\r1_OBUF[13]_inst_i_3_n_0 ),
        .I2(\r1_OBUF[13]_inst_i_4_n_0 ),
        .I3(\r1_OBUF[31]_inst_i_5_n_0 ),
        .I4(\r1_OBUF[31]_inst_i_6_n_0 ),
        .I5(\r1_OBUF[31]_inst_i_7_n_0 ),
        .O(r1_OBUF[9]));
  LUT5 #(
    .INIT(32'hCFC0AAAA)) 
    \r1_OBUF[9]_inst_i_2 
       (.I0(r11[9]),
        .I1(\r1_OBUF[11]_inst_i_3_n_6 ),
        .I2(\r1_OBUF[13]_inst_i_6_n_0 ),
        .I3(\r1_OBUF[11]_inst_i_4_n_6 ),
        .I4(\r1_OBUF[31]_inst_i_2_n_2 ),
        .O(data0[9]));
  IBUF \r_IBUF[0]_inst 
       (.I(r[0]),
        .O(r_IBUF[0]));
  IBUF \r_IBUF[10]_inst 
       (.I(r[10]),
        .O(r_IBUF[10]));
  IBUF \r_IBUF[11]_inst 
       (.I(r[11]),
        .O(r_IBUF[11]));
  IBUF \r_IBUF[12]_inst 
       (.I(r[12]),
        .O(r_IBUF[12]));
  IBUF \r_IBUF[13]_inst 
       (.I(r[13]),
        .O(r_IBUF[13]));
  IBUF \r_IBUF[14]_inst 
       (.I(r[14]),
        .O(r_IBUF[14]));
  IBUF \r_IBUF[15]_inst 
       (.I(r[15]),
        .O(r_IBUF[15]));
  IBUF \r_IBUF[16]_inst 
       (.I(r[16]),
        .O(r_IBUF[16]));
  IBUF \r_IBUF[17]_inst 
       (.I(r[17]),
        .O(r_IBUF[17]));
  IBUF \r_IBUF[18]_inst 
       (.I(r[18]),
        .O(r_IBUF[18]));
  IBUF \r_IBUF[19]_inst 
       (.I(r[19]),
        .O(r_IBUF[19]));
  IBUF \r_IBUF[1]_inst 
       (.I(r[1]),
        .O(r_IBUF[1]));
  IBUF \r_IBUF[20]_inst 
       (.I(r[20]),
        .O(r_IBUF[20]));
  IBUF \r_IBUF[21]_inst 
       (.I(r[21]),
        .O(r_IBUF[21]));
  IBUF \r_IBUF[22]_inst 
       (.I(r[22]),
        .O(r_IBUF[22]));
  IBUF \r_IBUF[23]_inst 
       (.I(r[23]),
        .O(r_IBUF[23]));
  IBUF \r_IBUF[24]_inst 
       (.I(r[24]),
        .O(r_IBUF[24]));
  IBUF \r_IBUF[25]_inst 
       (.I(r[25]),
        .O(r_IBUF[25]));
  IBUF \r_IBUF[26]_inst 
       (.I(r[26]),
        .O(r_IBUF[26]));
  IBUF \r_IBUF[27]_inst 
       (.I(r[27]),
        .O(r_IBUF[27]));
  IBUF \r_IBUF[28]_inst 
       (.I(r[28]),
        .O(r_IBUF[28]));
  IBUF \r_IBUF[29]_inst 
       (.I(r[29]),
        .O(r_IBUF[29]));
  IBUF \r_IBUF[2]_inst 
       (.I(r[2]),
        .O(r_IBUF[2]));
  IBUF \r_IBUF[30]_inst 
       (.I(r[30]),
        .O(r_IBUF[30]));
  IBUF \r_IBUF[31]_inst 
       (.I(r[31]),
        .O(r_IBUF[31]));
  IBUF \r_IBUF[3]_inst 
       (.I(r[3]),
        .O(r_IBUF[3]));
  IBUF \r_IBUF[4]_inst 
       (.I(r[4]),
        .O(r_IBUF[4]));
  IBUF \r_IBUF[5]_inst 
       (.I(r[5]),
        .O(r_IBUF[5]));
  IBUF \r_IBUF[6]_inst 
       (.I(r[6]),
        .O(r_IBUF[6]));
  IBUF \r_IBUF[7]_inst 
       (.I(r[7]),
        .O(r_IBUF[7]));
  IBUF \r_IBUF[8]_inst 
       (.I(r[8]),
        .O(r_IBUF[8]));
  IBUF \r_IBUF[9]_inst 
       (.I(r[9]),
        .O(r_IBUF[9]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
