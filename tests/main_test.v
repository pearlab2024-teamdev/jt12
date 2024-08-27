`timescale 10ns / 1ps // 訂正 10nsに変更
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

`define DTMUL 8'h30
`define TL 8'h40
`define KSAR 8'h50
`define DR 8'h60
`define SR 8'h70
`define SLRR 8'h80


module main_test;
    reg RST;
    reg CLK;
    reg CEN;
    reg [7:0] DIN;
    reg ADDR;
    reg CS_N;
    reg WR_N;
    
    reg [7:0] IOA_IN;
    reg [7:0] IOB_IN;
        
    wire        [7:0] DOUT;
    wire              irq_n;
    wire              IOA_oe;
    wire              IOB_oe;
    wire        [7:0] psg_A;
    wire        [7:0] psg_B;
    wire        [7:0] psg_C;
    wire signed [15:0] fm_snd;
    wire        [9:0] psg_snd;
    wire              snd_pwm;
    wire signed [15:0] snd;
    wire snd_sample;
    wire [7:0] debug_view;
    
    
  
    
    top uut(
    .rst(RST),
    .clk_in(CLK),
    .cen(CEN),
    .din(DIN),
    .addr(ADDR),
    .cs_n(CS_N),
    .wr_n(WR_N),
    .dout(DOUT),
    .IOA_oe(IOA_oe),
    .IOB_oe(IOA_oe),
    .psg_A(psg_A),
    .psg_B(psg_B),
    .psg_C(psg_C),
    .fm_snd(fm_snd),
    .psg_snd(psg_snd),
    .snd_pwm(snd_pwm),
    .snd(snd),
    .snd_sample(snd_sample)
    );
    
    
    
    
    always
        #125 CLK = ~CLK; //訂正 実際の動作クロックに合わせる(25)
    
    initial begin
        RST = 1;
        CLK = 0;
        CEN = 1'b1;
        DIN = 0;
        ADDR = 0;
        CS_N = 0;
        WR_N = 1;
        IOA_IN = 0;
        IOB_IN = 0;
      
       
       #7000 RST = 0;
             CEN = 1;
       
       #119000 WR_N = 0;
             DIN = 8'h00;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1; 
       
        #119000 WR_N = 0;
             DIN = 8'h01;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
       
        #119000 WR_N = 0;
             DIN = 8'h02;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
         #119000 WR_N = 0;
             DIN = 8'h03;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h04;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h05;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h06;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
       
        #119000 WR_N = 0;
             DIN = 8'h08;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h09;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h0A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h0B;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h0C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
       
       #119000 WR_N = 0;
             DIN = 8'h0D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h0E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;     
        
        #119000 WR_N = 0;
             DIN = 8'h0F;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h07;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h24;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h25;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h26;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h27;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h28;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h30;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h31;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h32;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h34;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h35;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h36;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h38;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h39;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h3A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h3C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h3D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h3E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h40;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h41;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h42;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h44;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h45;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h46;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h48;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h49;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h4A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h4C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h4D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h4E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h50;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h51;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h52;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h54;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h55;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h56;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h58;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h59;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h5A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h5C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h5D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h5E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h60;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h61;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h62;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h64;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h65;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h66;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h68;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h69;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h6A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h6C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h6D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h6E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h70;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h71;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h72;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h74;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h75;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h76;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h78;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h79;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h7A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h7C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h7D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h7E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h80;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h81;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h82;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h84;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h85;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h86;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h88;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h89;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h8A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h8C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h8D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h8E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h90;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h91;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h92;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h94;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h95;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h96;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h98;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'h99;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;    
        
        #119000 WR_N = 0;
             DIN = 8'h9A;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h9C;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
         
         #119000 WR_N = 0;
             DIN = 8'h9D;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'h9E;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'hA0;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;     
        
        #119000 WR_N = 0;
             DIN = 8'hA1;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'hA2;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'hA4;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'hA5;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;   
             
       #119000 WR_N = 0;
             DIN = 8'hA6;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;  
             
        #119000 WR_N = 0;
             DIN = 8'hA8;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        #119000 WR_N = 0;
             DIN = 8'hA9;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'hAA;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
       #119000 WR_N = 0;
             DIN = 8'hAC;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'hAD;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
             DIN = 8'hAE;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
       #119000 WR_N = 0;
             DIN = 8'hB0;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
        
        #119000 WR_N = 0;
             DIN = 8'hB1;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
       #119000 WR_N = 0;
             DIN = 8'hB2;
        #250 WR_N = 1;
        #250 DIN = 8'h00;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
       //data write
       #119000 WR_N = 0;
             DIN = 8'h27;
        #250 WR_N = 1;
        #250 DIN = 8'h3B;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1; 
        
        #2250 RST = 0;
             WR_N = 0;
                DIN = 8'h07;      
        #250 WR_N = 1;         
        #250 DIN = 8'h38;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                     
        

        #119000 WR_N = 0;
                DIN = 01;      
        #250 WR_N = 1;         
        #250 DIN = 8'h01;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
             DIN = 8'h00;
        #250 WR_N = 1;
        #250 DIN = 8'h1b;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h0f;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = 8'h09;      
        #250 WR_N = 1;         
        #250 DIN = 8'h00;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        
        #119000 WR_N = 0;
                DIN = 8'h0A;      
        #250 WR_N = 1;         
        #250 DIN = 8'h00;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
        
        //FB/CON
        #250 RST = 0;
             WR_N = 0;
             DIN = 8'hB0;
        #250 WR_N = 1;
        #250 DIN = 8'h28;  
             ADDR = 1;
             WR_N = 0;
        #250 ADDR = 0;
             WR_N = 1;        
        
        //DT/MUL
        #119000 WR_N = 0;
                DIN = `DTMUL;      
        #250 WR_N = 1;         
        #250 DIN = 8'h43;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
                DIN = `DTMUL + 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h4F;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = `DTMUL + 8'h04;      
        #250 WR_N = 1;         
        #250 DIN = 8'h77;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = `DTMUL + 8'h0C;      
        #250 WR_N = 1;         
        #250 DIN = 8'h71;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        //TL
        #119000 WR_N = 0;
                DIN = `TL;      
        #250 WR_N = 1;         
        #250 DIN = 8'h0A;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
                DIN = `TL + 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h1C;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = `TL + 8'h04;      
        #250 WR_N = 1;         
        #250 DIN = 8'h17;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = `TL + 8'h0C;      
        #250 WR_N = 1;         
        #250 DIN = 8'h08;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
        
        //DR
        #119000 WR_N = 0;
                DIN = `DR;      
        #250 WR_N = 1;         
        #250 DIN = 8'h04;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
                DIN = `DR + 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h01;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = `DR + 8'h04;      
        #250 WR_N = 1;         
        #250 DIN = 8'h04;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = `DR + 8'h0C;      
        #250 WR_N = 1;         
        #250 DIN = 8'h0C;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
        
        //SL/RR
        #119000 WR_N = 0;
                DIN = `SLRR;      
        #250 WR_N = 1;         
        #250 DIN = 8'h10;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
                DIN = `SLRR + 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h18;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = `SLRR + 8'h04;      
        #250 WR_N = 1;         
        #250 DIN = 8'h10;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = `SLRR + 8'h0C;      
        #250 WR_N = 1;         
        #250 DIN = 8'h18;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
        
        //KS/AR
        #119000 WR_N = 0;
                DIN = `KSAR;      
        #250 WR_N = 1;         
        #250 DIN = 8'h1F;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
                DIN = `KSAR + 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h12;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = `KSAR + 8'h04;      
        #250 WR_N = 1;         
        #250 DIN = 8'h1F;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = `KSAR + 8'h0C;      
        #250 WR_N = 1;         
        #250 DIN = 8'h1F;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
        
        //SR
        #119000 WR_N = 0;
                DIN = `SR;      
        #250 WR_N = 1;         
        #250 DIN = 8'h01;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;  
        
        #119000 WR_N = 0;
                DIN = `SR + 8'h08;      
        #250 WR_N = 1;         
        #250 DIN = 8'h01;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        #119000 WR_N = 0;
                DIN = `SR + 8'h04;      
        #250 WR_N = 1;         
        #250 DIN = 8'h01;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
                        
        #119000 WR_N = 0;
                DIN = `SR + 8'h0C;      
        #250 WR_N = 1;         
        #250 DIN = 8'h04;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
             
        //SLOT
             
        #119000 WR_N = 0;
                DIN = 8'h28;      
        #250 WR_N = 1;         
        #250 DIN = 8'hF0;
             ADDR = 1;
             WR_N = 0;  
        #250 ADDR = 0;
             WR_N = 1;
        
        #2000000 $stop;
        
        
        
    end
endmodule