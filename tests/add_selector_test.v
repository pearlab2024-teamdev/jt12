`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 01:48:44 PM
// Design Name: 
// Module Name: add_selector_test
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


module add_selector_test;
  reg RST;
  reg CLK_IN;
  //reg CEN;
  //reg [7:0] DIN;
  //reg ADDR;
  //reg CS_N;
  //reg WR_N;

  //reg [7:0] IOA_IN;
  //reg [7:0] IOB_IN;

  //wire [7:0] DOUT;
  //wire irq_n;
  //wire IOA_oe;
  //wire IOB_oe;
  //wire [7:0] psg_A;
  //wire [7:0] psg_B;
  //wire [7:0] psg_C;
  //wire [15:0] fm_snd;
  //wire [9:0] psg_snd;
  //wire [15:0] snd;
  wire snd_pwm;
  //wire snd_sample;
  //wire [7:0] debug_view;

  //wire [7:0] IOA_OUT;
  //wire [7:0] IOB_OUT;
  
  add_selector uut (
      .RST(RST),
      .CLK_IN(CLK_IN),
      //.cen(CEN),
      //.din(DIN),
      //.addr(ADDR),
      //.cs_n(CS_N),
      //.wr_n(WR_N),

      //.DOUT(DOUT),
      //.irq_n(irq_n),
      //.IOA_in(IOA_IN),
      //.IOB_in(IOB_IN),
      //.IOA_out(IOA_OUT),
      //.IOB_out(IOB_OUT),
      //.IOA_oe(IOA_oe),
      //.IOB_oe(IOB_oe),
      //.psg_A(psg_A),
      //.psg_B(psg_B),
      //.psg_C(psg_C),
      //.fm_snd(fm_snd),
      //.psg_snd(psg_snd),
      //.snd(snd),
      .snd_pwm(snd_pwm)
      //.snd_sample(snd_sample)
      //.debug_view(debug_view)

  );
  
  always #5 CLK_IN = ~CLK_IN;  //訂正 実際の動作クロックに合わせる(25)
  
  initial begin
    CLK_IN = 0;
    RST = 1;
   
  #35000 RST = 0;
  
  #1000000000 $stop;
  
  end
endmodule
