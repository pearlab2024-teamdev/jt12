`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 12:25:37 PM
// Design Name: 
// Module Name: add_selector
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

module add_selector(
    //input RST,
    input CLK_IN,
    //input CEN,
    //input [7:0] DIN,
    //input ADDR,
    //input CS_N,
    //input WR_N,
    
    //input [7:0] IOA_IN,
    //input [7:0] IOB_IN,
    
    //output [7:0] DOUT,
    //output irq_n,
    //output IOA_oe,
    //output IOB_oe,
    //output [7:0] psg_A,
    //output [7:0] psg_B,
    //output [7:0] psg_C,
    //output [15:0] fm_snd,
    //output [9:0] psg_snd,
    //output [15:0] snd,
    output snd_pwm, //PWM変換された出力が出る。
    //output snd_sample,
    //output [7:0] debug_view,
    
    //output [7:0] IOA_OUT,
    //output [7:0] IOB_OUT
    output ACTIVE_LOW,
    output ACTIVE_HIGH
       
    );
    
  assign ACTIVE_LOW = 1;
  assign ACTIVE_HIGH = 0;
  
  reg RST = 1;  
  reg CEN = 1'b1;
  reg [7:0] DIN = 0;
  reg ADDR = 0;
  reg CS_N = 0;
  reg WR_N = 1;
  
  wire [7:0] DOUT;
  wire       irq_n;
  wire       IOA_oe;
  wire       IOB_oe;
  wire [7:0] psg_A;
  wire [7:0] psg_B;
  wire [7:0] psg_C;
  wire [15:0] fm_snd;
  wire [9:0] psg_snd;
  wire [15:0] snd;
  wire        snd_sample;
  wire        debug_view;
    
  wire [7:0] IOA_OUT;
  wire [7:0] IOB_OUT;
  
  wire CLK_4;
  wire CLK_100;
  
  
    
  top u_top(
    .rst(RST),
    .clk_in(CLK_4),
    .clk_100(CLK_100),
    .cen(CEN),
    .din(DIN),
    .addr(ADDR),
    .cs_n(CS_N),
    .wr_n(WR_N),
    .dout(DOUT),
    .irq_n(irq_n),
    .psg_A(psg_A),
    .psg_B(psg_B),
    .psg_C(psg_C),
    .fm_snd(fm_snd),
    .psg_snd(psg_snd),
    .snd(snd),
    .snd_sample(snd_sample),
    .snd_pwm(snd_pwm)
    );
    
    // インスタンス化
    BUFG bufg_inst (
        .I(CLK_IN),
        .O(CLK_100)
    );  
    
    reg divider_rst = 0;
    
    clock_divider clock_divider_i(
    .clk_100mhz(CLK_100),
    .reset(divider_rst),
    .clk_4mhz(CLK_4)
    );
    
    wire locked;
    
   
    
  
    
    
    reg [15:0] counter = 0;
    
    //データ書き込みタイミングを取るためのカウンタ
    always @(posedge CLK_4)
    begin
        //if(RST)
        //begin
            //counter <= 0;
        //end
        
        //else
            counter <= counter + 1;     
    end
    
    //レジスタにsin波を発生させるためのデータを書き込んでいる。
    always @(posedge CLK_4)
    begin
    
            if(counter == 8'h07)
            begin
                RST = 0;
                WR_N = 0;
                DIN = 8'h27;
            end
        
            else if(counter == 16'h0008)
                WR_N = 1;
            
            else if(counter == 16'h0009)
            begin
                DIN = 8'h3B;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h000A)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            /// Disable SSG output
            else if(counter == 16'h0013)
            begin
                WR_N = 0;
                DIN = 8'h07;
            end
        
            else if(counter == 16'h14)
                WR_N = 1;
            
            else if(counter == 16'h15)
            begin
                DIN = 8'h38;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h16)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            // FB/CON
            else if(counter == 16'h1F)
            begin
                WR_N = 0;
                DIN = `FBCN;
            end
        
            else if(counter == 16'h20)
                WR_N = 1;
            
            else if(counter == 16'h21)
            begin
                DIN = `FBCN_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h22)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //DT/MUL
            else if(counter == 16'h1FE)
            begin
                WR_N = 0;
                DIN = `DTMUL;
            end
        
            else if(counter == 16'h1FF)
                WR_N = 1;
            
            else if(counter == 16'h200)
            begin
                DIN = `DTMUL_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h201)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //TL
            else if(counter == 16'h3DD)
            begin
                WR_N = 0;
                DIN = `TL;
            end
        
            else if(counter == 16'h3DE)
                WR_N = 1;
            
            else if(counter == 16'h3DF)
            begin
                DIN = `TL_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h3E0)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //KS/AR
            else if(counter == 16'h5BC)
            begin
                WR_N = 0;
                DIN = `KSAR;
            end
        
            else if(counter == 16'h5BD)
                WR_N = 1;
            
            else if(counter == 16'h5BE)
            begin
                DIN = `KSAR_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h5BF)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
           
            
            //DR
            else if(counter == 16'h79B)
            begin
                WR_N = 0;
                DIN = `DR;
            end
        
            else if(counter == 16'h79C)
                WR_N = 1;
            
            else if(counter == 16'h79D)
            begin
                DIN = `DR_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h79E)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //SR
            else if(counter == 16'h97B)
            begin
                WR_N = 0;
                DIN = `SR;
            end
        
            else if(counter == 16'h97C)
                WR_N = 1;
            
            else if(counter == 16'h97D)
            begin
                DIN = `SR_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h97E)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //SL/RR
            else if(counter == 16'hB5A)
            begin
                WR_N = 0;
                DIN = `SLRR;
            end
        
            else if(counter == 16'hB5B)
                WR_N = 1;
            
            else if(counter == 16'hB5C)
            begin
                DIN = `SLRR_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'hB5D)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //SGG-EG
            else if(counter == 16'hD39)
            begin
                WR_N = 0;
                DIN = `SSGEG;
            end
        
            else if(counter == 16'hD3A)
                WR_N = 1;
            
            else if(counter == 16'hD3B)
            begin
                DIN = `SSGEG_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'hD3C)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            //FNUM
            else if(counter == 16'hF18)
            begin
                WR_N = 0;
                DIN = `FNUM_HI;
            end
        
            else if(counter == 16'hF19)
                WR_N = 1;
            
            else if(counter == 16'hF1A)
            begin
                DIN = `FNUM_HI_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'hF1B)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
            else if(counter == 16'h10F7)
            begin
                WR_N = 0;
                DIN = `FNUM_LO;
            end
        
            else if(counter == 16'h10F8)
                WR_N = 1;
            
            else if(counter == 16'h10F9)
            begin
                DIN = `FNUM_LO_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h10FA)
            begin
                ADDR = 0;
                WR_N = 1;
            end
        
            //SLOT
            else if(counter == 16'h12D6)
            begin
                WR_N = 0;
                DIN = `KON;
            end
        
            else if(counter == 16'h12D7)
                WR_N = 1;
            
            else if(counter == 16'h12D8)
            begin
                DIN = `KON_VALUE;
                ADDR = 1;
                WR_N = 0;
            end
            
            else if(counter == 16'h12D9)
            begin
                ADDR = 0;
                WR_N = 1;
            end
            
    end
          
endmodule