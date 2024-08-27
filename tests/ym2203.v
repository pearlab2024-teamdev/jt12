`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2024 07:28:01 PM
// Design Name: 
// Module Name: ym2203
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ym2203(
    input           rst,        //#IC rst should be at least 6 clk & cen cycles long
    input           clk,        // CPU clock
    input           cen,        // optional clock enable, if not needed leave as 1'b1
    input   [7:0]   din,        //D0~D7(入力)
    input           addr,       //A0
    input           cs_n,       //#CS
    input           wr_n,       //#WR

    output  [7:0]   dout,       //D0~D7(出力)
    output          irq_n,      //#IRQ(割り込み)
    // I/O pins used by YM2203 embedded YM2149 chip
    input   [7:0]   IOA_in,     //IOA0~7(汎用入力)
    input   [7:0]   IOB_in,     //IOB0~7    
    output  [7:0]   IOA_out,    //IOA0~7(汎用出力)
    output  [7:0]   IOB_out,    //IOB0~7
    output          IOA_oe,
    output          IOB_oe,
    // Separated output
    output          [ 7:0] psg_A,
    output          [ 7:0] psg_B,
    output          [ 7:0] psg_C,
    output  signed  [15:0] fm_snd,
    // combined output
    output          [ 9:0] psg_snd,
    output  signed  [15:0] snd,
    output                 snd_sample,
    output                 snd_pwm,
    // Debug
    //input           [ 7:0] debug_bus,
    output          [ 7:0] debug_view
    );
endmodule
