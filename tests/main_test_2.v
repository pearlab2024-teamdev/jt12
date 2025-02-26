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


module main_test_2;
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
    
  
    
    top uut(
        .rst(RST),
        .clk_in(CLK_IN),
        .cen(CEN),
        .din(DIN),
        .addr(ADDR),
        .cs_n(CS_N),
        .wr_n(WR_N),
        
        .dout(DOUT),
        .irq_n(irq_n),
        .IOA_in(IOA_IN),
        .IOB_in(IOB_IN),
        .IOA_out(IOA_OUT),
        .IOB_out(IOB_OUT),
        .IOA_oe(IOA_oe),
        .IOB_oe(IOB_oe),
        .psg_A(psg_A),
        .psg_B(psg_B),
        .psg_C(psg_C),
        .fm_snd(fm_snd),
        .psg_snd(psg_snd),
        .snd(snd),
        .snd_pwm(snd_pwm),
        .snd_sample(snd_sample),
        .debug_view(debug_view)
        
    );
    
    
    always
        #125 CLK_IN = ~CLK_IN; //訂正 実際の動作クロックに合わせる(25)
    
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
      
       
       #1750 RST = 0;
             WR_N = 0;
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
