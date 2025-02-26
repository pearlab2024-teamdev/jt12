`timescale 1ns / 1ps // 訂正 10nsに変更
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


module psg_test;
    reg RST;
    reg CLK;
    reg CEN;
    reg [7:0] DIN;
    reg ADDR;
    reg CS_N;
    reg WR_N;
    
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
    wire [7:0] debug_view;
    wire snd_pwm;
    
  
    
    jt03 uut(
    .rst(RST),
    .clk(CLK),
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
    .snd(snd),
    .debug_view(debug_view),
    .snd_pwm(snd_pwm)
    );
    
    
    always
        #125 CLK = ~CLK; //訂正 実際の動作クロックに合わせる(25)
    
    initial begin
        CLK = 0;
        RST = 0;
        CEN = 1'b1;
        DIN = 0;
        ADDR = 0;
        CS_N = 0;
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
             
        
        #2000000 $stop;
        
        
        
    end
endmodule