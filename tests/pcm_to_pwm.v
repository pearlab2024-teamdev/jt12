//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 07/18/2024 04:25:24 PM
//// Design Name: 
//// Module Name: pcm_to_pwm
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module pcm_to_pwm (
//    input clk,          // クロック信号
//    input rst,
//    input snd_sample,
//    input signed [15:0] pcm_in, // 16ビットのPCM信号（符号付き）
//    output reg pwm_out  // PWM信号の出力
    
//);

//    reg [15:0] threshold; // PWM閾値（16ビットの符号付き）
//    reg [15:0] counter;   // カウンター（16ビットの符号付き）
//    reg prev_snd_sample;
//    reg [2:0]state = 0;
//    reg count_end = 0;
//    always @(posedge clk) begin
//        prev_snd_sample<=snd_sample;
//        if (rst) begin 
//            counter <= 0;
//            threshold <= 16'h8000;
//        end
//        else if (prev_snd_sample ==0 && snd_sample==1) begin
//            threshold <= pcm_in ^ 16'h8000;
//            counter <= 0;
//            state <= 0;
//            count_end <= 0;
//        end
//        else if (state == 0) begin
//            counter <= counter +  128;
//            if (count_end == 1 && counter == 0) begin
//                state <= 1;
//                count_end <= 0;
//            end
//            else if (counter < threshold) begin
//                pwm_out <= 1;
//            end 
//            else begin
//                count_end <= 1;
//                pwm_out <= 0;
//            end
//        end
//        else if (state == 1) begin
//            counter <= counter +  256;
//            if (count_end == 1 && counter == 0) begin
//                state <= 2;
//                count_end <= 0;
//            end
//            else if (counter < threshold[14:0]) begin
//                pwm_out <= 1;
//            end 
//            else begin
//                count_end <= 1;
//                pwm_out <= 0;
//            end
//        end  if (state == 2) begin
//            counter <= counter +  512;
//            if (count_end == 1 && counter == 0) begin
//                state <= 0;
//                count_end <= 0;
//            end
//            else if (counter < threshold[13:0]) begin
//                pwm_out <= 1;
//            end 
//            else begin
//                count_end <= 1;
//                pwm_out <= 0;
//            end
//        end
////        else begin
////        counter <= counter + 256;        
////        // PWM出力の生成
////        if (counter == 0) begin
            
////            pwm_out <= 1;
////        end
////        else if (counter < threshold) begin
////            pwm_out <= 1; // パルスの高状態
////        end else begin
////            pwm_out <= 0; // パルスの低状態
////        end
////        end
//    end

//endmodule
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
    input rst,
    input signed [15:0] pcm_in, // 16ビットのPCM信号（符号付き）
    input snd_sample,
    output reg pwm_out  // PWM信号の出力
    
);

    reg [15:0] threshold; // PWM閾値（16ビットの符号付き）
    reg [15:0] counter;   // カウンター（16ビットの符号付き
    reg prev_snd_sample = 0;
    always @(posedge clk) begin
        prev_snd_sample <= snd_sample;
        if (rst)
            counter <= 0;
        else if (counter == 0) begin
        // PCM信号からPWM閾値を設定
//            threshold <= pcm_in ^ 16'h8000;
            threshold <= pcm_in;
            counter <= counter + 256;
            
//            if (pcm_in & 16'h8000 != 0) begin
//                threshold <= 0 - pcm_in;
//            end else begin
//                threshold <= pcm_in;
//            end
        end else begin
            counter <= counter + 256;
        end
        
    end
    
    always @(posedge clk) begin

        if (counter < threshold)
            pwm_out <= 1; // パルスの高状態
        else
            pwm_out <= 0; // パルスの低状態
    end

endmodule