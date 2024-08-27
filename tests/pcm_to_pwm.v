`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2024 04:25:24 PM
// Design Name: 
// Module Name: pcm_to_pwm
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


module pcm_to_pwm (
    input clk,          // クロック信号
    input signed [15:0] pcm_in, // 16ビットのPCM信号（符号付き）
    output reg pwm_out  // PWM信号の出力
);

    reg signed [15:0] threshold; // PWM閾値（16ビットの符号付き）
    reg signed [15:0] counter;   // カウンター（16ビットの符号付き）

    always @(posedge clk) begin
        counter <= counter + 1;
        // PCM信号からPWM閾値を設定
        threshold <= pcm_in;
        
        // PWM出力の生成
        if (counter < threshold) begin
            pwm_out <= 1; // パルスの高状態
        end else begin
            pwm_out <= 0; // パルスの低状態
        end
    end

endmodule