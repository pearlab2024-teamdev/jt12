`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2024 04:44:58 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input wire clk_100mhz,  // 100MHz入力クロック
    input wire reset,       // リセット信号
    output reg clk_4mhz     // 4MHz出力クロック
);

      reg [4:0] counter;      // 25までカウントするための5ビットカウンタ

    initial begin
        counter = 0;
        clk_4mhz = 0;
    end
    
    always @(posedge clk_100mhz or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_4mhz <= 0;
        end else if (counter == 24) begin
            counter <= 0;
            clk_4mhz <= ~clk_4mhz;  // 4MHz出力を反転
        end else begin
            counter <= counter + 1;
        end
    end
endmodule

