module pwm_6bit_signed(
    input CLK,
    input RESET,
    input signed [5:0] signalIn,  // 符号付き入力に変更
    output pwmOut
    );

    // control duty cycle
    reg pwmReg;
    reg [31:0] pwmCount;
    reg [31:0] unitCount;
    reg [5:0] unitNum;
    parameter pwmUnit=100;
    parameter pwmPeriod = 15 * pwmUnit;

    // end control duty cycle
    always@(posedge CLK) begin
        if(RESET)
            pwmCount <= 0;
        else if(pwmCount >= pwmPeriod - 1)
            pwmCount <= 0;
        else
            pwmCount <= pwmCount + 1;
    end

    always@(posedge CLK) begin
        if(RESET) begin
            unitCount <= 0;
            unitNum <= 0;
        end else if(unitCount >= pwmUnit - 1) begin
            unitNum <= unitNum + 1;
            unitCount <= 0;
        end else
            unitCount <= unitCount + 1;
    end

    always@(posedge CLK) begin
        if(RESET)
            pwmReg <= 0;
        else if (signalIn >= 0) begin
            // 正の値の処理
            case (signalIn)
                0: pwmReg <= 0;
                1: pwmReg <= (pwmCount < 1*pwmUnit);
                2: pwmReg <= (pwmCount < 2*pwmUnit);
                3: pwmReg <= (pwmCount < 3*pwmUnit);
                4: pwmReg <= (pwmCount < 4*pwmUnit);
                5: pwmReg <= (pwmCount < 5*pwmUnit);
                6: pwmReg <= (pwmCount < 6*pwmUnit);
                7: pwmReg <= (pwmCount < 7*pwmUnit);
                8: pwmReg <= (pwmCount < 8*pwmUnit);
                9: pwmReg <= (pwmCount < 9*pwmUnit);
                10: pwmReg <= (pwmCount < 10*pwmUnit);
                11: pwmReg <= (pwmCount < 11*pwmUnit);
                12: pwmReg <= (pwmCount < 12*pwmUnit);
                13: pwmReg <= (pwmCount < 13*pwmUnit);
                14: pwmReg <= (pwmCount < 14*pwmUnit);
                15: pwmReg <= (pwmCount < 15*pwmUnit);
            endcase
        end else begin
            // 負の値の処理（逆方向のデューティサイクル）
            case (signalIn)
                -1: pwmReg <= (pwmCount >= 14*pwmUnit);
                -2: pwmReg <= (pwmCount >= 13*pwmUnit);
                -3: pwmReg <= (pwmCount >= 12*pwmUnit);
                -4: pwmReg <= (pwmCount >= 11*pwmUnit);
                -5: pwmReg <= (pwmCount >= 10*pwmUnit);
                -6: pwmReg <= (pwmCount >= 9*pwmUnit);
                -7: pwmReg <= (pwmCount >= 8*pwmUnit);
                -8: pwmReg <= (pwmCount >= 7*pwmUnit);
                -9: pwmReg <= (pwmCount >= 6*pwmUnit);
                -10: pwmReg <= (pwmCount >= 5*pwmUnit);
                -11: pwmReg <= (pwmCount >= 4*pwmUnit);
                -12: pwmReg <= (pwmCount >= 3*pwmUnit);
                -13: pwmReg <= (pwmCount >= 2*pwmUnit);
                -14: pwmReg <= (pwmCount >= 1*pwmUnit);
                -15: pwmReg <= (pwmCount >= 0);
            endcase
        end
    end

    assign pwmOut = pwmReg;
endmodule
