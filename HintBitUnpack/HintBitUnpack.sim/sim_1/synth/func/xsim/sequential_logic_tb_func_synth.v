// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Fri Dec 20 20:18:14 2024
// Host        : merledu1 running 64-bit Ubuntu 22.04.4 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/mlatif/HintBitUnpack/HintBitUnpack.sim/sim_1/synth/func/xsim/sequential_logic_tb_func_synth.v
// Design      : top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module sequential_logic
   (CLK,
    AR);
  input CLK;
  input [0:0]AR;

  wire [0:0]AR;
  wire CLK;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_10_n_0 ;
  wire \FSM_sequential_state[1]_i_11_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire \FSM_sequential_state[1]_i_9_n_0 ;
  wire \FSM_sequential_state[2]_i_10_n_0 ;
  wire \FSM_sequential_state[2]_i_11_n_0 ;
  wire \FSM_sequential_state[2]_i_12_n_0 ;
  wire \FSM_sequential_state[2]_i_15_n_0 ;
  wire \FSM_sequential_state[2]_i_16_n_0 ;
  wire \FSM_sequential_state[2]_i_17_n_0 ;
  wire \FSM_sequential_state[2]_i_18_n_0 ;
  wire \FSM_sequential_state[2]_i_19_n_0 ;
  wire \FSM_sequential_state[2]_i_1_n_0 ;
  wire \FSM_sequential_state[2]_i_20_n_0 ;
  wire \FSM_sequential_state[2]_i_21_n_0 ;
  wire \FSM_sequential_state[2]_i_22_n_0 ;
  wire \FSM_sequential_state[2]_i_2_n_0 ;
  wire \FSM_sequential_state[2]_i_3_n_0 ;
  wire \FSM_sequential_state[2]_i_4_n_0 ;
  wire \FSM_sequential_state[2]_i_5_n_0 ;
  wire \FSM_sequential_state[2]_i_6_n_0 ;
  wire \FSM_sequential_state[2]_i_7_n_0 ;
  wire \FSM_sequential_state[2]_i_8_n_0 ;
  wire \FSM_sequential_state[2]_i_9_n_0 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_0 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_1 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_2 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_3 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_4 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_5 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_6 ;
  wire \FSM_sequential_state_reg[1]_i_5_n_7 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_0 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_1 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_2 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_3 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_4 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_5 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_6 ;
  wire \FSM_sequential_state_reg[1]_i_6_n_7 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_0 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_1 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_2 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_3 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_4 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_5 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_6 ;
  wire \FSM_sequential_state_reg[1]_i_7_n_7 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_0 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_1 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_2 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_3 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_4 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_5 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_6 ;
  wire \FSM_sequential_state_reg[1]_i_8_n_7 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_0 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_1 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_2 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_3 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_4 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_5 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_6 ;
  wire \FSM_sequential_state_reg[2]_i_13_n_7 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_0 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_1 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_2 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_3 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_4 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_5 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_6 ;
  wire \FSM_sequential_state_reg[2]_i_14_n_7 ;
  wire \FSM_sequential_state_reg[2]_i_23_n_2 ;
  wire \FSM_sequential_state_reg[2]_i_23_n_3 ;
  wire \FSM_sequential_state_reg[2]_i_23_n_5 ;
  wire \FSM_sequential_state_reg[2]_i_23_n_6 ;
  wire \FSM_sequential_state_reg[2]_i_23_n_7 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_0 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_1 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_2 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_3 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_4 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_5 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_6 ;
  wire \FSM_sequential_state_reg[2]_i_24_n_7 ;
  wire [6:1]final_counter;
  wire \final_counter[0]_i_1_n_0 ;
  wire \final_counter[5]_i_2_n_0 ;
  wire \final_counter[6]_i_1_n_0 ;
  wire \final_counter[6]_i_3_n_0 ;
  wire \final_counter_reg_n_0_[0] ;
  wire \final_counter_reg_n_0_[1] ;
  wire \final_counter_reg_n_0_[2] ;
  wire \final_counter_reg_n_0_[3] ;
  wire \final_counter_reg_n_0_[4] ;
  wire \final_counter_reg_n_0_[5] ;
  wire \final_counter_reg_n_0_[6] ;
  wire [6:1]inner_counter;
  wire \inner_counter[0]_i_1_n_0 ;
  wire \inner_counter[5]_i_2_n_0 ;
  wire \inner_counter[5]_i_3_n_0 ;
  wire \inner_counter[6]_i_1_n_0 ;
  wire \inner_counter[6]_i_3_n_0 ;
  wire \inner_counter[6]_i_4_n_0 ;
  wire \inner_counter_reg_n_0_[0] ;
  wire \inner_counter_reg_n_0_[1] ;
  wire \inner_counter_reg_n_0_[2] ;
  wire \inner_counter_reg_n_0_[3] ;
  wire \inner_counter_reg_n_0_[4] ;
  wire \inner_counter_reg_n_0_[5] ;
  wire \inner_counter_reg_n_0_[6] ;
  wire [31:1]outer_counter;
  wire \outer_counter[0]_i_1_n_0 ;
  wire \outer_counter[31]_i_1_n_0 ;
  wire \outer_counter_reg[12]_i_2_n_0 ;
  wire \outer_counter_reg[12]_i_2_n_1 ;
  wire \outer_counter_reg[12]_i_2_n_2 ;
  wire \outer_counter_reg[12]_i_2_n_3 ;
  wire \outer_counter_reg[12]_i_2_n_4 ;
  wire \outer_counter_reg[12]_i_2_n_5 ;
  wire \outer_counter_reg[12]_i_2_n_6 ;
  wire \outer_counter_reg[12]_i_2_n_7 ;
  wire \outer_counter_reg[16]_i_2_n_0 ;
  wire \outer_counter_reg[16]_i_2_n_1 ;
  wire \outer_counter_reg[16]_i_2_n_2 ;
  wire \outer_counter_reg[16]_i_2_n_3 ;
  wire \outer_counter_reg[16]_i_2_n_4 ;
  wire \outer_counter_reg[16]_i_2_n_5 ;
  wire \outer_counter_reg[16]_i_2_n_6 ;
  wire \outer_counter_reg[16]_i_2_n_7 ;
  wire \outer_counter_reg[20]_i_2_n_0 ;
  wire \outer_counter_reg[20]_i_2_n_1 ;
  wire \outer_counter_reg[20]_i_2_n_2 ;
  wire \outer_counter_reg[20]_i_2_n_3 ;
  wire \outer_counter_reg[20]_i_2_n_4 ;
  wire \outer_counter_reg[20]_i_2_n_5 ;
  wire \outer_counter_reg[20]_i_2_n_6 ;
  wire \outer_counter_reg[20]_i_2_n_7 ;
  wire \outer_counter_reg[24]_i_2_n_0 ;
  wire \outer_counter_reg[24]_i_2_n_1 ;
  wire \outer_counter_reg[24]_i_2_n_2 ;
  wire \outer_counter_reg[24]_i_2_n_3 ;
  wire \outer_counter_reg[24]_i_2_n_4 ;
  wire \outer_counter_reg[24]_i_2_n_5 ;
  wire \outer_counter_reg[24]_i_2_n_6 ;
  wire \outer_counter_reg[24]_i_2_n_7 ;
  wire \outer_counter_reg[28]_i_2_n_0 ;
  wire \outer_counter_reg[28]_i_2_n_1 ;
  wire \outer_counter_reg[28]_i_2_n_2 ;
  wire \outer_counter_reg[28]_i_2_n_3 ;
  wire \outer_counter_reg[28]_i_2_n_4 ;
  wire \outer_counter_reg[28]_i_2_n_5 ;
  wire \outer_counter_reg[28]_i_2_n_6 ;
  wire \outer_counter_reg[28]_i_2_n_7 ;
  wire \outer_counter_reg[31]_i_3_n_2 ;
  wire \outer_counter_reg[31]_i_3_n_3 ;
  wire \outer_counter_reg[31]_i_3_n_5 ;
  wire \outer_counter_reg[31]_i_3_n_6 ;
  wire \outer_counter_reg[31]_i_3_n_7 ;
  wire \outer_counter_reg[4]_i_2_n_0 ;
  wire \outer_counter_reg[4]_i_2_n_1 ;
  wire \outer_counter_reg[4]_i_2_n_2 ;
  wire \outer_counter_reg[4]_i_2_n_3 ;
  wire \outer_counter_reg[4]_i_2_n_4 ;
  wire \outer_counter_reg[4]_i_2_n_5 ;
  wire \outer_counter_reg[4]_i_2_n_6 ;
  wire \outer_counter_reg[4]_i_2_n_7 ;
  wire \outer_counter_reg[8]_i_2_n_0 ;
  wire \outer_counter_reg[8]_i_2_n_1 ;
  wire \outer_counter_reg[8]_i_2_n_2 ;
  wire \outer_counter_reg[8]_i_2_n_3 ;
  wire \outer_counter_reg[8]_i_2_n_4 ;
  wire \outer_counter_reg[8]_i_2_n_5 ;
  wire \outer_counter_reg[8]_i_2_n_6 ;
  wire \outer_counter_reg[8]_i_2_n_7 ;
  wire \outer_counter_reg_n_0_[0] ;
  wire \outer_counter_reg_n_0_[10] ;
  wire \outer_counter_reg_n_0_[11] ;
  wire \outer_counter_reg_n_0_[12] ;
  wire \outer_counter_reg_n_0_[13] ;
  wire \outer_counter_reg_n_0_[14] ;
  wire \outer_counter_reg_n_0_[15] ;
  wire \outer_counter_reg_n_0_[16] ;
  wire \outer_counter_reg_n_0_[17] ;
  wire \outer_counter_reg_n_0_[18] ;
  wire \outer_counter_reg_n_0_[19] ;
  wire \outer_counter_reg_n_0_[1] ;
  wire \outer_counter_reg_n_0_[20] ;
  wire \outer_counter_reg_n_0_[21] ;
  wire \outer_counter_reg_n_0_[22] ;
  wire \outer_counter_reg_n_0_[23] ;
  wire \outer_counter_reg_n_0_[24] ;
  wire \outer_counter_reg_n_0_[25] ;
  wire \outer_counter_reg_n_0_[26] ;
  wire \outer_counter_reg_n_0_[27] ;
  wire \outer_counter_reg_n_0_[28] ;
  wire \outer_counter_reg_n_0_[29] ;
  wire \outer_counter_reg_n_0_[2] ;
  wire \outer_counter_reg_n_0_[30] ;
  wire \outer_counter_reg_n_0_[31] ;
  wire \outer_counter_reg_n_0_[3] ;
  wire \outer_counter_reg_n_0_[4] ;
  wire \outer_counter_reg_n_0_[5] ;
  wire \outer_counter_reg_n_0_[6] ;
  wire \outer_counter_reg_n_0_[7] ;
  wire \outer_counter_reg_n_0_[8] ;
  wire \outer_counter_reg_n_0_[9] ;
  (* RTL_KEEP = "yes" *) wire [2:0]state;
  wire [3:2]\NLW_FSM_sequential_state_reg[2]_i_23_CO_UNCONNECTED ;
  wire [3:3]\NLW_FSM_sequential_state_reg[2]_i_23_O_UNCONNECTED ;
  wire [3:2]\NLW_outer_counter_reg[31]_i_3_CO_UNCONNECTED ;
  wire [3:3]\NLW_outer_counter_reg[31]_i_3_O_UNCONNECTED ;

  LUT6 #(
    .INIT(64'h000003770000CF77)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[2]_i_5_n_0 ),
        .I1(state[0]),
        .I2(\FSM_sequential_state[2]_i_3_n_0 ),
        .I3(state[1]),
        .I4(state[2]),
        .I5(\FSM_sequential_state[2]_i_4_n_0 ),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h55570000)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(\FSM_sequential_state[2]_i_5_n_0 ),
        .I1(\FSM_sequential_state[1]_i_2_n_0 ),
        .I2(\FSM_sequential_state[1]_i_3_n_0 ),
        .I3(\FSM_sequential_state[2]_i_6_n_0 ),
        .I4(\FSM_sequential_state[1]_i_4_n_0 ),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_state[1]_i_10 
       (.I0(\outer_counter_reg_n_0_[3] ),
        .O(\FSM_sequential_state[1]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_state[1]_i_11 
       (.I0(\outer_counter_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(\FSM_sequential_state_reg[1]_i_5_n_5 ),
        .I1(\FSM_sequential_state_reg[1]_i_5_n_4 ),
        .I2(\FSM_sequential_state_reg[1]_i_6_n_7 ),
        .I3(\FSM_sequential_state_reg[1]_i_6_n_6 ),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFA800)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(\FSM_sequential_state[2]_i_19_n_0 ),
        .I1(\FSM_sequential_state_reg[1]_i_7_n_7 ),
        .I2(\FSM_sequential_state_reg[1]_i_8_n_4 ),
        .I3(\FSM_sequential_state_reg[1]_i_7_n_6 ),
        .I4(\FSM_sequential_state[2]_i_17_n_0 ),
        .I5(\FSM_sequential_state[2]_i_16_n_0 ),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(state[0]),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_sequential_state[1]_i_9 
       (.I0(\outer_counter_reg_n_0_[6] ),
        .O(\FSM_sequential_state[1]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'h33773737)) 
    \FSM_sequential_state[2]_i_1 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(\FSM_sequential_state[2]_i_3_n_0 ),
        .I3(\FSM_sequential_state[2]_i_4_n_0 ),
        .I4(state[0]),
        .O(\FSM_sequential_state[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_state[2]_i_10 
       (.I0(\outer_counter_reg_n_0_[9] ),
        .I1(\outer_counter_reg_n_0_[8] ),
        .I2(\outer_counter_reg_n_0_[7] ),
        .I3(\outer_counter_reg_n_0_[6] ),
        .O(\FSM_sequential_state[2]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0000000200000000)) 
    \FSM_sequential_state[2]_i_11 
       (.I0(\FSM_sequential_state[2]_i_21_n_0 ),
        .I1(\outer_counter_reg_n_0_[19] ),
        .I2(\outer_counter_reg_n_0_[18] ),
        .I3(\outer_counter_reg_n_0_[21] ),
        .I4(\outer_counter_reg_n_0_[20] ),
        .I5(\FSM_sequential_state[2]_i_22_n_0 ),
        .O(\FSM_sequential_state[2]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state[2]_i_12 
       (.I0(\FSM_sequential_state_reg[2]_i_14_n_5 ),
        .I1(\FSM_sequential_state_reg[2]_i_14_n_4 ),
        .I2(\FSM_sequential_state_reg[1]_i_5_n_7 ),
        .I3(\FSM_sequential_state_reg[1]_i_5_n_6 ),
        .O(\FSM_sequential_state[2]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state[2]_i_15 
       (.I0(\FSM_sequential_state_reg[1]_i_7_n_5 ),
        .I1(\FSM_sequential_state_reg[1]_i_7_n_4 ),
        .I2(\FSM_sequential_state_reg[2]_i_13_n_7 ),
        .I3(\FSM_sequential_state_reg[2]_i_13_n_6 ),
        .O(\FSM_sequential_state[2]_i_15_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_state[2]_i_16 
       (.I0(\FSM_sequential_state_reg[2]_i_23_n_6 ),
        .I1(\FSM_sequential_state_reg[2]_i_23_n_5 ),
        .I2(\FSM_sequential_state_reg[2]_i_23_n_7 ),
        .I3(\FSM_sequential_state_reg[1]_i_6_n_5 ),
        .I4(\FSM_sequential_state_reg[1]_i_6_n_4 ),
        .O(\FSM_sequential_state[2]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_sequential_state[2]_i_17 
       (.I0(\FSM_sequential_state_reg[2]_i_24_n_7 ),
        .I1(\FSM_sequential_state_reg[2]_i_24_n_6 ),
        .I2(\FSM_sequential_state_reg[2]_i_24_n_5 ),
        .I3(\FSM_sequential_state_reg[2]_i_24_n_4 ),
        .O(\FSM_sequential_state[2]_i_17_n_0 ));
  LUT3 #(
    .INIT(8'hE0)) 
    \FSM_sequential_state[2]_i_18 
       (.I0(\FSM_sequential_state_reg[1]_i_7_n_7 ),
        .I1(\FSM_sequential_state_reg[1]_i_8_n_4 ),
        .I2(\FSM_sequential_state_reg[1]_i_7_n_6 ),
        .O(\FSM_sequential_state[2]_i_18_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFAE)) 
    \FSM_sequential_state[2]_i_19 
       (.I0(\FSM_sequential_state_reg[1]_i_8_n_5 ),
        .I1(\FSM_sequential_state_reg[1]_i_8_n_7 ),
        .I2(\outer_counter_reg_n_0_[0] ),
        .I3(\FSM_sequential_state_reg[1]_i_8_n_6 ),
        .I4(\FSM_sequential_state_reg[1]_i_7_n_7 ),
        .O(\FSM_sequential_state[2]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00008880)) 
    \FSM_sequential_state[2]_i_2 
       (.I0(\FSM_sequential_state[2]_i_5_n_0 ),
        .I1(state[0]),
        .I2(\FSM_sequential_state[2]_i_6_n_0 ),
        .I3(\FSM_sequential_state[2]_i_7_n_0 ),
        .I4(state[2]),
        .I5(\FSM_sequential_state[2]_i_8_n_0 ),
        .O(\FSM_sequential_state[2]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_state[2]_i_20 
       (.I0(\outer_counter_reg_n_0_[13] ),
        .I1(\outer_counter_reg_n_0_[12] ),
        .I2(\outer_counter_reg_n_0_[11] ),
        .I3(\outer_counter_reg_n_0_[10] ),
        .O(\FSM_sequential_state[2]_i_20_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \FSM_sequential_state[2]_i_21 
       (.I0(\outer_counter_reg_n_0_[25] ),
        .I1(\outer_counter_reg_n_0_[24] ),
        .I2(\outer_counter_reg_n_0_[23] ),
        .I3(\outer_counter_reg_n_0_[22] ),
        .O(\FSM_sequential_state[2]_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_sequential_state[2]_i_22 
       (.I0(\outer_counter_reg_n_0_[26] ),
        .I1(\outer_counter_reg_n_0_[27] ),
        .I2(\outer_counter_reg_n_0_[28] ),
        .I3(\outer_counter_reg_n_0_[29] ),
        .I4(\outer_counter_reg_n_0_[31] ),
        .I5(\outer_counter_reg_n_0_[30] ),
        .O(\FSM_sequential_state[2]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'h00FF00FF00FF75FF)) 
    \FSM_sequential_state[2]_i_3 
       (.I0(\inner_counter_reg_n_0_[3] ),
        .I1(\inner_counter_reg_n_0_[2] ),
        .I2(\inner_counter[5]_i_3_n_0 ),
        .I3(\inner_counter_reg_n_0_[6] ),
        .I4(\inner_counter_reg_n_0_[5] ),
        .I5(\inner_counter_reg_n_0_[4] ),
        .O(\FSM_sequential_state[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h55555555555557FF)) 
    \FSM_sequential_state[2]_i_4 
       (.I0(\final_counter_reg_n_0_[6] ),
        .I1(\final_counter[5]_i_2_n_0 ),
        .I2(\final_counter_reg_n_0_[2] ),
        .I3(\final_counter_reg_n_0_[3] ),
        .I4(\final_counter_reg_n_0_[5] ),
        .I5(\final_counter_reg_n_0_[4] ),
        .O(\FSM_sequential_state[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \FSM_sequential_state[2]_i_5 
       (.I0(\FSM_sequential_state[2]_i_9_n_0 ),
        .I1(\outer_counter_reg_n_0_[3] ),
        .I2(\outer_counter_reg_n_0_[4] ),
        .I3(\outer_counter_reg_n_0_[5] ),
        .I4(\FSM_sequential_state[2]_i_10_n_0 ),
        .I5(\FSM_sequential_state[2]_i_11_n_0 ),
        .O(\FSM_sequential_state[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_sequential_state[2]_i_6 
       (.I0(\FSM_sequential_state[2]_i_12_n_0 ),
        .I1(\FSM_sequential_state_reg[2]_i_13_n_5 ),
        .I2(\FSM_sequential_state_reg[2]_i_13_n_4 ),
        .I3(\FSM_sequential_state_reg[2]_i_14_n_7 ),
        .I4(\FSM_sequential_state_reg[2]_i_14_n_6 ),
        .I5(\FSM_sequential_state[2]_i_15_n_0 ),
        .O(\FSM_sequential_state[2]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFEFEFE)) 
    \FSM_sequential_state[2]_i_7 
       (.I0(\FSM_sequential_state[1]_i_2_n_0 ),
        .I1(\FSM_sequential_state[2]_i_16_n_0 ),
        .I2(\FSM_sequential_state[2]_i_17_n_0 ),
        .I3(\FSM_sequential_state[2]_i_18_n_0 ),
        .I4(\FSM_sequential_state[2]_i_19_n_0 ),
        .O(\FSM_sequential_state[2]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h0E00)) 
    \FSM_sequential_state[2]_i_8 
       (.I0(state[0]),
        .I1(\FSM_sequential_state[2]_i_3_n_0 ),
        .I2(state[2]),
        .I3(state[1]),
        .O(\FSM_sequential_state[2]_i_8_n_0 ));
  LUT5 #(
    .INIT(32'h00010000)) 
    \FSM_sequential_state[2]_i_9 
       (.I0(\outer_counter_reg_n_0_[14] ),
        .I1(\outer_counter_reg_n_0_[15] ),
        .I2(\outer_counter_reg_n_0_[16] ),
        .I3(\outer_counter_reg_n_0_[17] ),
        .I4(\FSM_sequential_state[2]_i_20_n_0 ),
        .O(\FSM_sequential_state[2]_i_9_n_0 ));
  (* FSM_ENCODED_STATES = "IDLE:000,FINAL_CHECK:011,COMPUTE_INNER:010,COMPUTE_OUTER:001,DONE:101,ERROR:100" *) 
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(CLK),
        .CE(\FSM_sequential_state[2]_i_1_n_0 ),
        .CLR(AR),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]));
  (* FSM_ENCODED_STATES = "IDLE:000,FINAL_CHECK:011,COMPUTE_INNER:010,COMPUTE_OUTER:001,DONE:101,ERROR:100" *) 
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(CLK),
        .CE(\FSM_sequential_state[2]_i_1_n_0 ),
        .CLR(AR),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]));
  CARRY4 \FSM_sequential_state_reg[1]_i_5 
       (.CI(\FSM_sequential_state_reg[2]_i_14_n_0 ),
        .CO({\FSM_sequential_state_reg[1]_i_5_n_0 ,\FSM_sequential_state_reg[1]_i_5_n_1 ,\FSM_sequential_state_reg[1]_i_5_n_2 ,\FSM_sequential_state_reg[1]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\FSM_sequential_state_reg[1]_i_5_n_4 ,\FSM_sequential_state_reg[1]_i_5_n_5 ,\FSM_sequential_state_reg[1]_i_5_n_6 ,\FSM_sequential_state_reg[1]_i_5_n_7 }),
        .S({\outer_counter_reg_n_0_[20] ,\outer_counter_reg_n_0_[19] ,\outer_counter_reg_n_0_[18] ,\outer_counter_reg_n_0_[17] }));
  CARRY4 \FSM_sequential_state_reg[1]_i_6 
       (.CI(\FSM_sequential_state_reg[1]_i_5_n_0 ),
        .CO({\FSM_sequential_state_reg[1]_i_6_n_0 ,\FSM_sequential_state_reg[1]_i_6_n_1 ,\FSM_sequential_state_reg[1]_i_6_n_2 ,\FSM_sequential_state_reg[1]_i_6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\FSM_sequential_state_reg[1]_i_6_n_4 ,\FSM_sequential_state_reg[1]_i_6_n_5 ,\FSM_sequential_state_reg[1]_i_6_n_6 ,\FSM_sequential_state_reg[1]_i_6_n_7 }),
        .S({\outer_counter_reg_n_0_[24] ,\outer_counter_reg_n_0_[23] ,\outer_counter_reg_n_0_[22] ,\outer_counter_reg_n_0_[21] }));
  CARRY4 \FSM_sequential_state_reg[1]_i_7 
       (.CI(\FSM_sequential_state_reg[1]_i_8_n_0 ),
        .CO({\FSM_sequential_state_reg[1]_i_7_n_0 ,\FSM_sequential_state_reg[1]_i_7_n_1 ,\FSM_sequential_state_reg[1]_i_7_n_2 ,\FSM_sequential_state_reg[1]_i_7_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\outer_counter_reg_n_0_[6] ,1'b0}),
        .O({\FSM_sequential_state_reg[1]_i_7_n_4 ,\FSM_sequential_state_reg[1]_i_7_n_5 ,\FSM_sequential_state_reg[1]_i_7_n_6 ,\FSM_sequential_state_reg[1]_i_7_n_7 }),
        .S({\outer_counter_reg_n_0_[8] ,\outer_counter_reg_n_0_[7] ,\FSM_sequential_state[1]_i_9_n_0 ,\outer_counter_reg_n_0_[5] }));
  CARRY4 \FSM_sequential_state_reg[1]_i_8 
       (.CI(1'b0),
        .CO({\FSM_sequential_state_reg[1]_i_8_n_0 ,\FSM_sequential_state_reg[1]_i_8_n_1 ,\FSM_sequential_state_reg[1]_i_8_n_2 ,\FSM_sequential_state_reg[1]_i_8_n_3 }),
        .CYINIT(\outer_counter_reg_n_0_[0] ),
        .DI({1'b0,\outer_counter_reg_n_0_[3] ,1'b0,\outer_counter_reg_n_0_[1] }),
        .O({\FSM_sequential_state_reg[1]_i_8_n_4 ,\FSM_sequential_state_reg[1]_i_8_n_5 ,\FSM_sequential_state_reg[1]_i_8_n_6 ,\FSM_sequential_state_reg[1]_i_8_n_7 }),
        .S({\outer_counter_reg_n_0_[4] ,\FSM_sequential_state[1]_i_10_n_0 ,\outer_counter_reg_n_0_[2] ,\FSM_sequential_state[1]_i_11_n_0 }));
  (* FSM_ENCODED_STATES = "IDLE:000,FINAL_CHECK:011,COMPUTE_INNER:010,COMPUTE_OUTER:001,DONE:101,ERROR:100" *) 
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[2] 
       (.C(CLK),
        .CE(\FSM_sequential_state[2]_i_1_n_0 ),
        .CLR(AR),
        .D(\FSM_sequential_state[2]_i_2_n_0 ),
        .Q(state[2]));
  CARRY4 \FSM_sequential_state_reg[2]_i_13 
       (.CI(\FSM_sequential_state_reg[1]_i_7_n_0 ),
        .CO({\FSM_sequential_state_reg[2]_i_13_n_0 ,\FSM_sequential_state_reg[2]_i_13_n_1 ,\FSM_sequential_state_reg[2]_i_13_n_2 ,\FSM_sequential_state_reg[2]_i_13_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\FSM_sequential_state_reg[2]_i_13_n_4 ,\FSM_sequential_state_reg[2]_i_13_n_5 ,\FSM_sequential_state_reg[2]_i_13_n_6 ,\FSM_sequential_state_reg[2]_i_13_n_7 }),
        .S({\outer_counter_reg_n_0_[12] ,\outer_counter_reg_n_0_[11] ,\outer_counter_reg_n_0_[10] ,\outer_counter_reg_n_0_[9] }));
  CARRY4 \FSM_sequential_state_reg[2]_i_14 
       (.CI(\FSM_sequential_state_reg[2]_i_13_n_0 ),
        .CO({\FSM_sequential_state_reg[2]_i_14_n_0 ,\FSM_sequential_state_reg[2]_i_14_n_1 ,\FSM_sequential_state_reg[2]_i_14_n_2 ,\FSM_sequential_state_reg[2]_i_14_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\FSM_sequential_state_reg[2]_i_14_n_4 ,\FSM_sequential_state_reg[2]_i_14_n_5 ,\FSM_sequential_state_reg[2]_i_14_n_6 ,\FSM_sequential_state_reg[2]_i_14_n_7 }),
        .S({\outer_counter_reg_n_0_[16] ,\outer_counter_reg_n_0_[15] ,\outer_counter_reg_n_0_[14] ,\outer_counter_reg_n_0_[13] }));
  CARRY4 \FSM_sequential_state_reg[2]_i_23 
       (.CI(\FSM_sequential_state_reg[2]_i_24_n_0 ),
        .CO({\NLW_FSM_sequential_state_reg[2]_i_23_CO_UNCONNECTED [3:2],\FSM_sequential_state_reg[2]_i_23_n_2 ,\FSM_sequential_state_reg[2]_i_23_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_FSM_sequential_state_reg[2]_i_23_O_UNCONNECTED [3],\FSM_sequential_state_reg[2]_i_23_n_5 ,\FSM_sequential_state_reg[2]_i_23_n_6 ,\FSM_sequential_state_reg[2]_i_23_n_7 }),
        .S({1'b0,\outer_counter_reg_n_0_[31] ,\outer_counter_reg_n_0_[30] ,\outer_counter_reg_n_0_[29] }));
  CARRY4 \FSM_sequential_state_reg[2]_i_24 
       (.CI(\FSM_sequential_state_reg[1]_i_6_n_0 ),
        .CO({\FSM_sequential_state_reg[2]_i_24_n_0 ,\FSM_sequential_state_reg[2]_i_24_n_1 ,\FSM_sequential_state_reg[2]_i_24_n_2 ,\FSM_sequential_state_reg[2]_i_24_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\FSM_sequential_state_reg[2]_i_24_n_4 ,\FSM_sequential_state_reg[2]_i_24_n_5 ,\FSM_sequential_state_reg[2]_i_24_n_6 ,\FSM_sequential_state_reg[2]_i_24_n_7 }),
        .S({\outer_counter_reg_n_0_[28] ,\outer_counter_reg_n_0_[27] ,\outer_counter_reg_n_0_[26] ,\outer_counter_reg_n_0_[25] }));
  LUT2 #(
    .INIT(4'h2)) 
    \final_counter[0]_i_1 
       (.I0(state[1]),
        .I1(\final_counter_reg_n_0_[0] ),
        .O(\final_counter[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h28)) 
    \final_counter[1]_i_1 
       (.I0(state[1]),
        .I1(\final_counter_reg_n_0_[0] ),
        .I2(\final_counter_reg_n_0_[1] ),
        .O(final_counter[1]));
  LUT4 #(
    .INIT(16'h2A80)) 
    \final_counter[2]_i_1 
       (.I0(state[1]),
        .I1(\final_counter_reg_n_0_[1] ),
        .I2(\final_counter_reg_n_0_[0] ),
        .I3(\final_counter_reg_n_0_[2] ),
        .O(final_counter[2]));
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \final_counter[3]_i_1 
       (.I0(state[1]),
        .I1(\final_counter_reg_n_0_[2] ),
        .I2(\final_counter_reg_n_0_[0] ),
        .I3(\final_counter_reg_n_0_[1] ),
        .I4(\final_counter_reg_n_0_[3] ),
        .O(final_counter[3]));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \final_counter[4]_i_1 
       (.I0(\inner_counter[5]_i_2_n_0 ),
        .I1(\final_counter_reg_n_0_[3] ),
        .I2(\final_counter_reg_n_0_[1] ),
        .I3(\final_counter_reg_n_0_[0] ),
        .I4(\final_counter_reg_n_0_[2] ),
        .I5(\final_counter_reg_n_0_[4] ),
        .O(final_counter[4]));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \final_counter[5]_i_1 
       (.I0(\inner_counter[5]_i_2_n_0 ),
        .I1(\final_counter_reg_n_0_[4] ),
        .I2(\final_counter_reg_n_0_[2] ),
        .I3(\final_counter[5]_i_2_n_0 ),
        .I4(\final_counter_reg_n_0_[3] ),
        .I5(\final_counter_reg_n_0_[5] ),
        .O(final_counter[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \final_counter[5]_i_2 
       (.I0(\final_counter_reg_n_0_[1] ),
        .I1(\final_counter_reg_n_0_[0] ),
        .O(\final_counter[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0A030000)) 
    \final_counter[6]_i_1 
       (.I0(\FSM_sequential_state[2]_i_4_n_0 ),
        .I1(\FSM_sequential_state[2]_i_5_n_0 ),
        .I2(state[2]),
        .I3(state[1]),
        .I4(state[0]),
        .O(\final_counter[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2A80)) 
    \final_counter[6]_i_2 
       (.I0(state[1]),
        .I1(\final_counter_reg_n_0_[5] ),
        .I2(\final_counter[6]_i_3_n_0 ),
        .I3(\final_counter_reg_n_0_[6] ),
        .O(final_counter[6]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \final_counter[6]_i_3 
       (.I0(\final_counter_reg_n_0_[4] ),
        .I1(\final_counter_reg_n_0_[2] ),
        .I2(\final_counter_reg_n_0_[0] ),
        .I3(\final_counter_reg_n_0_[1] ),
        .I4(\final_counter_reg_n_0_[3] ),
        .O(\final_counter[6]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[0] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(\final_counter[0]_i_1_n_0 ),
        .Q(\final_counter_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[1] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(final_counter[1]),
        .Q(\final_counter_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[2] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(final_counter[2]),
        .Q(\final_counter_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[3] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(final_counter[3]),
        .Q(\final_counter_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[4] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(final_counter[4]),
        .Q(\final_counter_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[5] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(final_counter[5]),
        .Q(\final_counter_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \final_counter_reg[6] 
       (.C(CLK),
        .CE(\final_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(final_counter[6]),
        .Q(\final_counter_reg_n_0_[6] ));
  LUT3 #(
    .INIT(8'h04)) 
    \inner_counter[0]_i_1 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(\inner_counter_reg_n_0_[0] ),
        .O(\inner_counter[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0440)) 
    \inner_counter[1]_i_1 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(\inner_counter_reg_n_0_[1] ),
        .I3(\inner_counter_reg_n_0_[0] ),
        .O(inner_counter[1]));
  LUT5 #(
    .INIT(32'h04404040)) 
    \inner_counter[2]_i_1 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(\inner_counter_reg_n_0_[2] ),
        .I3(\inner_counter_reg_n_0_[0] ),
        .I4(\inner_counter_reg_n_0_[1] ),
        .O(inner_counter[2]));
  LUT6 #(
    .INIT(64'h0440404040404040)) 
    \inner_counter[3]_i_1 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(\inner_counter_reg_n_0_[3] ),
        .I3(\inner_counter_reg_n_0_[2] ),
        .I4(\inner_counter_reg_n_0_[1] ),
        .I5(\inner_counter_reg_n_0_[0] ),
        .O(inner_counter[3]));
  LUT6 #(
    .INIT(64'h2888888888888888)) 
    \inner_counter[4]_i_1 
       (.I0(\inner_counter[5]_i_2_n_0 ),
        .I1(\inner_counter_reg_n_0_[4] ),
        .I2(\inner_counter_reg_n_0_[0] ),
        .I3(\inner_counter_reg_n_0_[1] ),
        .I4(\inner_counter_reg_n_0_[2] ),
        .I5(\inner_counter_reg_n_0_[3] ),
        .O(inner_counter[4]));
  LUT6 #(
    .INIT(64'h8888888828888888)) 
    \inner_counter[5]_i_1 
       (.I0(\inner_counter[5]_i_2_n_0 ),
        .I1(\inner_counter_reg_n_0_[5] ),
        .I2(\inner_counter_reg_n_0_[4] ),
        .I3(\inner_counter_reg_n_0_[3] ),
        .I4(\inner_counter_reg_n_0_[2] ),
        .I5(\inner_counter[5]_i_3_n_0 ),
        .O(inner_counter[5]));
  LUT2 #(
    .INIT(4'h2)) 
    \inner_counter[5]_i_2 
       (.I0(state[1]),
        .I1(state[2]),
        .O(\inner_counter[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \inner_counter[5]_i_3 
       (.I0(\inner_counter_reg_n_0_[0] ),
        .I1(\inner_counter_reg_n_0_[1] ),
        .O(\inner_counter[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hAAAEAAAA)) 
    \inner_counter[6]_i_1 
       (.I0(\inner_counter[6]_i_3_n_0 ),
        .I1(\FSM_sequential_state[2]_i_5_n_0 ),
        .I2(\FSM_sequential_state[2]_i_6_n_0 ),
        .I3(\FSM_sequential_state[2]_i_7_n_0 ),
        .I4(\FSM_sequential_state[1]_i_4_n_0 ),
        .O(\inner_counter[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h04404040)) 
    \inner_counter[6]_i_2 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(\inner_counter_reg_n_0_[6] ),
        .I3(\inner_counter[6]_i_4_n_0 ),
        .I4(\inner_counter_reg_n_0_[5] ),
        .O(inner_counter[6]));
  LUT4 #(
    .INIT(16'h0400)) 
    \inner_counter[6]_i_3 
       (.I0(state[0]),
        .I1(\FSM_sequential_state[2]_i_3_n_0 ),
        .I2(state[2]),
        .I3(state[1]),
        .O(\inner_counter[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \inner_counter[6]_i_4 
       (.I0(\inner_counter_reg_n_0_[4] ),
        .I1(\inner_counter_reg_n_0_[3] ),
        .I2(\inner_counter_reg_n_0_[2] ),
        .I3(\inner_counter_reg_n_0_[1] ),
        .I4(\inner_counter_reg_n_0_[0] ),
        .O(\inner_counter[6]_i_4_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[0] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(\inner_counter[0]_i_1_n_0 ),
        .Q(\inner_counter_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[1] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(inner_counter[1]),
        .Q(\inner_counter_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[2] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(inner_counter[2]),
        .Q(\inner_counter_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[3] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(inner_counter[3]),
        .Q(\inner_counter_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[4] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(inner_counter[4]),
        .Q(\inner_counter_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[5] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(inner_counter[5]),
        .Q(\inner_counter_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \inner_counter_reg[6] 
       (.C(CLK),
        .CE(\inner_counter[6]_i_1_n_0 ),
        .CLR(AR),
        .D(inner_counter[6]),
        .Q(\inner_counter_reg_n_0_[6] ));
  LUT2 #(
    .INIT(4'h2)) 
    \outer_counter[0]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg_n_0_[0] ),
        .O(\outer_counter[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[10]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[12]_i_2_n_6 ),
        .O(outer_counter[10]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[11]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[12]_i_2_n_5 ),
        .O(outer_counter[11]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[12]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[12]_i_2_n_4 ),
        .O(outer_counter[12]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[13]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[16]_i_2_n_7 ),
        .O(outer_counter[13]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[14]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[16]_i_2_n_6 ),
        .O(outer_counter[14]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[15]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[16]_i_2_n_5 ),
        .O(outer_counter[15]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[16]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[16]_i_2_n_4 ),
        .O(outer_counter[16]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[17]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[20]_i_2_n_7 ),
        .O(outer_counter[17]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[18]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[20]_i_2_n_6 ),
        .O(outer_counter[18]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[19]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[20]_i_2_n_5 ),
        .O(outer_counter[19]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[1]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[4]_i_2_n_7 ),
        .O(outer_counter[1]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[20]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[20]_i_2_n_4 ),
        .O(outer_counter[20]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[21]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[24]_i_2_n_7 ),
        .O(outer_counter[21]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[22]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[24]_i_2_n_6 ),
        .O(outer_counter[22]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[23]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[24]_i_2_n_5 ),
        .O(outer_counter[23]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[24]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[24]_i_2_n_4 ),
        .O(outer_counter[24]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[25]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[28]_i_2_n_7 ),
        .O(outer_counter[25]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[26]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[28]_i_2_n_6 ),
        .O(outer_counter[26]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[27]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[28]_i_2_n_5 ),
        .O(outer_counter[27]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[28]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[28]_i_2_n_4 ),
        .O(outer_counter[28]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[29]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[31]_i_3_n_7 ),
        .O(outer_counter[29]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[2]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[4]_i_2_n_6 ),
        .O(outer_counter[2]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[30]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[31]_i_3_n_6 ),
        .O(outer_counter[30]));
  LUT4 #(
    .INIT(16'h0007)) 
    \outer_counter[31]_i_1 
       (.I0(\FSM_sequential_state[2]_i_3_n_0 ),
        .I1(state[1]),
        .I2(state[0]),
        .I3(state[2]),
        .O(\outer_counter[31]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[31]_i_2 
       (.I0(state[1]),
        .I1(\outer_counter_reg[31]_i_3_n_5 ),
        .O(outer_counter[31]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[3]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[4]_i_2_n_5 ),
        .O(outer_counter[3]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[4]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[4]_i_2_n_4 ),
        .O(outer_counter[4]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[5]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[8]_i_2_n_7 ),
        .O(outer_counter[5]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[6]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[8]_i_2_n_6 ),
        .O(outer_counter[6]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[7]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[8]_i_2_n_5 ),
        .O(outer_counter[7]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[8]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[8]_i_2_n_4 ),
        .O(outer_counter[8]));
  LUT2 #(
    .INIT(4'h8)) 
    \outer_counter[9]_i_1 
       (.I0(state[1]),
        .I1(\outer_counter_reg[12]_i_2_n_7 ),
        .O(outer_counter[9]));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[0] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(\outer_counter[0]_i_1_n_0 ),
        .Q(\outer_counter_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[10] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[10]),
        .Q(\outer_counter_reg_n_0_[10] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[11] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[11]),
        .Q(\outer_counter_reg_n_0_[11] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[12] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[12]),
        .Q(\outer_counter_reg_n_0_[12] ));
  CARRY4 \outer_counter_reg[12]_i_2 
       (.CI(\outer_counter_reg[8]_i_2_n_0 ),
        .CO({\outer_counter_reg[12]_i_2_n_0 ,\outer_counter_reg[12]_i_2_n_1 ,\outer_counter_reg[12]_i_2_n_2 ,\outer_counter_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[12]_i_2_n_4 ,\outer_counter_reg[12]_i_2_n_5 ,\outer_counter_reg[12]_i_2_n_6 ,\outer_counter_reg[12]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[12] ,\outer_counter_reg_n_0_[11] ,\outer_counter_reg_n_0_[10] ,\outer_counter_reg_n_0_[9] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[13] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[13]),
        .Q(\outer_counter_reg_n_0_[13] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[14] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[14]),
        .Q(\outer_counter_reg_n_0_[14] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[15] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[15]),
        .Q(\outer_counter_reg_n_0_[15] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[16] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[16]),
        .Q(\outer_counter_reg_n_0_[16] ));
  CARRY4 \outer_counter_reg[16]_i_2 
       (.CI(\outer_counter_reg[12]_i_2_n_0 ),
        .CO({\outer_counter_reg[16]_i_2_n_0 ,\outer_counter_reg[16]_i_2_n_1 ,\outer_counter_reg[16]_i_2_n_2 ,\outer_counter_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[16]_i_2_n_4 ,\outer_counter_reg[16]_i_2_n_5 ,\outer_counter_reg[16]_i_2_n_6 ,\outer_counter_reg[16]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[16] ,\outer_counter_reg_n_0_[15] ,\outer_counter_reg_n_0_[14] ,\outer_counter_reg_n_0_[13] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[17] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[17]),
        .Q(\outer_counter_reg_n_0_[17] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[18] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[18]),
        .Q(\outer_counter_reg_n_0_[18] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[19] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[19]),
        .Q(\outer_counter_reg_n_0_[19] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[1] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[1]),
        .Q(\outer_counter_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[20] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[20]),
        .Q(\outer_counter_reg_n_0_[20] ));
  CARRY4 \outer_counter_reg[20]_i_2 
       (.CI(\outer_counter_reg[16]_i_2_n_0 ),
        .CO({\outer_counter_reg[20]_i_2_n_0 ,\outer_counter_reg[20]_i_2_n_1 ,\outer_counter_reg[20]_i_2_n_2 ,\outer_counter_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[20]_i_2_n_4 ,\outer_counter_reg[20]_i_2_n_5 ,\outer_counter_reg[20]_i_2_n_6 ,\outer_counter_reg[20]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[20] ,\outer_counter_reg_n_0_[19] ,\outer_counter_reg_n_0_[18] ,\outer_counter_reg_n_0_[17] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[21] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[21]),
        .Q(\outer_counter_reg_n_0_[21] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[22] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[22]),
        .Q(\outer_counter_reg_n_0_[22] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[23] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[23]),
        .Q(\outer_counter_reg_n_0_[23] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[24] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[24]),
        .Q(\outer_counter_reg_n_0_[24] ));
  CARRY4 \outer_counter_reg[24]_i_2 
       (.CI(\outer_counter_reg[20]_i_2_n_0 ),
        .CO({\outer_counter_reg[24]_i_2_n_0 ,\outer_counter_reg[24]_i_2_n_1 ,\outer_counter_reg[24]_i_2_n_2 ,\outer_counter_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[24]_i_2_n_4 ,\outer_counter_reg[24]_i_2_n_5 ,\outer_counter_reg[24]_i_2_n_6 ,\outer_counter_reg[24]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[24] ,\outer_counter_reg_n_0_[23] ,\outer_counter_reg_n_0_[22] ,\outer_counter_reg_n_0_[21] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[25] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[25]),
        .Q(\outer_counter_reg_n_0_[25] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[26] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[26]),
        .Q(\outer_counter_reg_n_0_[26] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[27] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[27]),
        .Q(\outer_counter_reg_n_0_[27] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[28] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[28]),
        .Q(\outer_counter_reg_n_0_[28] ));
  CARRY4 \outer_counter_reg[28]_i_2 
       (.CI(\outer_counter_reg[24]_i_2_n_0 ),
        .CO({\outer_counter_reg[28]_i_2_n_0 ,\outer_counter_reg[28]_i_2_n_1 ,\outer_counter_reg[28]_i_2_n_2 ,\outer_counter_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[28]_i_2_n_4 ,\outer_counter_reg[28]_i_2_n_5 ,\outer_counter_reg[28]_i_2_n_6 ,\outer_counter_reg[28]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[28] ,\outer_counter_reg_n_0_[27] ,\outer_counter_reg_n_0_[26] ,\outer_counter_reg_n_0_[25] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[29] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[29]),
        .Q(\outer_counter_reg_n_0_[29] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[2] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[2]),
        .Q(\outer_counter_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[30] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[30]),
        .Q(\outer_counter_reg_n_0_[30] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[31] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[31]),
        .Q(\outer_counter_reg_n_0_[31] ));
  CARRY4 \outer_counter_reg[31]_i_3 
       (.CI(\outer_counter_reg[28]_i_2_n_0 ),
        .CO({\NLW_outer_counter_reg[31]_i_3_CO_UNCONNECTED [3:2],\outer_counter_reg[31]_i_3_n_2 ,\outer_counter_reg[31]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_outer_counter_reg[31]_i_3_O_UNCONNECTED [3],\outer_counter_reg[31]_i_3_n_5 ,\outer_counter_reg[31]_i_3_n_6 ,\outer_counter_reg[31]_i_3_n_7 }),
        .S({1'b0,\outer_counter_reg_n_0_[31] ,\outer_counter_reg_n_0_[30] ,\outer_counter_reg_n_0_[29] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[3] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[3]),
        .Q(\outer_counter_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[4] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[4]),
        .Q(\outer_counter_reg_n_0_[4] ));
  CARRY4 \outer_counter_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\outer_counter_reg[4]_i_2_n_0 ,\outer_counter_reg[4]_i_2_n_1 ,\outer_counter_reg[4]_i_2_n_2 ,\outer_counter_reg[4]_i_2_n_3 }),
        .CYINIT(\outer_counter_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[4]_i_2_n_4 ,\outer_counter_reg[4]_i_2_n_5 ,\outer_counter_reg[4]_i_2_n_6 ,\outer_counter_reg[4]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[4] ,\outer_counter_reg_n_0_[3] ,\outer_counter_reg_n_0_[2] ,\outer_counter_reg_n_0_[1] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[5] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[5]),
        .Q(\outer_counter_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[6] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[6]),
        .Q(\outer_counter_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[7] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[7]),
        .Q(\outer_counter_reg_n_0_[7] ));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[8] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[8]),
        .Q(\outer_counter_reg_n_0_[8] ));
  CARRY4 \outer_counter_reg[8]_i_2 
       (.CI(\outer_counter_reg[4]_i_2_n_0 ),
        .CO({\outer_counter_reg[8]_i_2_n_0 ,\outer_counter_reg[8]_i_2_n_1 ,\outer_counter_reg[8]_i_2_n_2 ,\outer_counter_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\outer_counter_reg[8]_i_2_n_4 ,\outer_counter_reg[8]_i_2_n_5 ,\outer_counter_reg[8]_i_2_n_6 ,\outer_counter_reg[8]_i_2_n_7 }),
        .S({\outer_counter_reg_n_0_[8] ,\outer_counter_reg_n_0_[7] ,\outer_counter_reg_n_0_[6] ,\outer_counter_reg_n_0_[5] }));
  FDCE #(
    .INIT(1'b0)) 
    \outer_counter_reg[9] 
       (.C(CLK),
        .CE(\outer_counter[31]_i_1_n_0 ),
        .CLR(AR),
        .D(outer_counter[9]),
        .Q(\outer_counter_reg_n_0_[9] ));
endmodule

(* NotValidForBitStream *)
module top
   (clk,
    rst,
    btn,
    led);
  input clk;
  input rst;
  input btn;
  output led;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire led;
  wire rst;
  wire rst_IBUF;

  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  sequential_logic dut
       (.AR(rst_IBUF),
        .CLK(clk_IBUF_BUFG));
  OBUF led_OBUF_inst
       (.I(1'b0),
        .O(led));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
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
