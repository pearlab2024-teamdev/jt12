`timescale 1ns / 1ns  // 訂正 10nsに変更
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2024 01:42:44 PM
// Design Name: 
// Module Name: simple_test
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

// This test produces 440Hz sine wave

`define DTMUL 8'h30
`define DTMUL_VALUE 8'h01

`define TL 8'h40
`define TL_VALUE 8'h00

`define KSAR 8'h50
`define KSAR_VALUE 8'h1F

`define DR 8'h60
`define DR_VALUE 8'h00

`define SR 8'h70
`define SR_VALUE 8'h00

`define SLRR 8'h80
`define SLRR_VALUE 8'h00

`define SSGEG 8'h90
`define SSGEG_VALUE 8'h00

`define FNUM_LO 8'hA0
`define FNUM_LO_VALUE 8'h0F

`define FNUM_HI 8'hA4
`define FNUM_HI_VALUE 8'h24

`define FBCN 8'hB0
`define FBCN_VALUE 8'h07

`define KON 8'h28
`define KON_VALUE 8'h10

module sine_a4_test;
  reg RST;
  reg CLK_IN;
  reg CEN;
  reg [7:0] DIN;
  reg ADDR;
  reg CS_N;
  reg WR_N;

  reg [7:0] IOA_IN;
  reg [7:0] IOB_IN;

  wire [7:0] DOUT;
  wire irq_n;
  wire IOA_oe;
  wire IOB_oe;
  wire [7:0] psg_A;
  wire [7:0] psg_B;
  wire [7:0] psg_C;
  wire [15:0] fm_snd;
  wire [9:0] psg_snd;
  wire [15:0] snd;
  wire snd_pwm;
  wire snd_sample;
  wire [7:0] debug_view;

  wire [7:0] IOA_OUT;
  wire [7:0] IOB_OUT;



  top uut (
      .rst(RST),
      .clk_in(CLK_IN),
      .cen(CEN),
      .din(DIN),
      .addr(ADDR),
      .cs_n(CS_N),
      .wr_n(WR_N),

      .dout(DOUT),
      .irq_n(irq_n),
      //.IOA_in(IOA_IN),
      //.IOB_in(IOB_IN),
      //.IOA_out(IOA_OUT),
      //.IOB_out(IOB_OUT),
      //.IOA_oe(IOA_oe),
      //.IOB_oe(IOB_oe),
      .psg_A(psg_A),
      .psg_B(psg_B),
      .psg_C(psg_C),
      .fm_snd(fm_snd),
      .psg_snd(psg_snd),
      .snd(snd),
      .snd_pwm(snd_pwm),
      .snd_sample(snd_sample)
      //.debug_view(debug_view)

  );


  always #125 CLK_IN = ~CLK_IN;  //訂正 実際の動作クロックに合わせる(25)

  initial begin
    CLK_IN = 0;
    RST = 1;
    CEN = 1'b1;
    DIN = 0;
    ADDR = 0;
    CS_N = 0;
    WR_N = 1;

    IOA_IN = 0;
    IOB_IN = 0;

    // Jotego says 7 cycle is required for reset
    #1750 RST = 0;
    WR_N = 0;
    DIN  = 8'h27;
    #250 WR_N = 1;
    #250 DIN = 8'h3B;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    // Disable SSG output
    #2250 WR_N = 0;
    DIN = 8'h07;
    #250 WR_N = 1;
    #250 DIN = 8'h38;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //FB/CON
    #250 RST = 0;
    WR_N = 0;
    DIN  = `FBCN;
    #250 WR_N = 1;
    #250 DIN = `FBCN_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //DT/MUL
    #119000 WR_N = 0;
    DIN = `DTMUL;
    #250 WR_N = 1;
    #250 DIN = `DTMUL_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //TL
    #119000 WR_N = 0;
    DIN = `TL;
    #250 WR_N = 1;
    #250 DIN = `TL_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //KS/AR
    #119000 WR_N = 0;
    DIN = `KSAR;
    #250 WR_N = 1;
    #250 DIN = `KSAR_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //DR
    #119000 WR_N = 0;
    DIN = `DR;
    #250 WR_N = 1;
    #250 DIN = `DR_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //SR
    #119000 WR_N = 0;
    DIN = `SR;
    #250 WR_N = 1;
    #250 DIN = `SR_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //SL/RR
    #119000 WR_N = 0;
    DIN = `SLRR;
    #250 WR_N = 1;
    #250 DIN = `SLRR_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    // SSG-EG
    #119000 WR_N = 0;
    DIN = `SSGEG;
    #250 WR_N = 1;
    #250 DIN = `SSGEG_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    // FNUM
    #119000 WR_N = 0;
    DIN = `FNUM_HI;
    #250 WR_N = 1;
    #250 DIN = `FNUM_HI_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    #119000 WR_N = 0;
    DIN = `FNUM_LO;
    #250 WR_N = 1;
    #250 DIN = `FNUM_LO_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    //SLOT

    #119000 WR_N = 0;
    DIN = `KON;
    #250 WR_N = 1;
    #250 DIN = `KON_VALUE;
    ADDR = 1;
    WR_N = 0;
    #250 ADDR = 0;
    WR_N = 1;

    #20000000 $stop;



  end
endmodule