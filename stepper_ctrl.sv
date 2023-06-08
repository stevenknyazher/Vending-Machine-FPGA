`timescale 1ns / 1ps

module stepper_ctrl(
    input clk,
    input [3:0] btn,
    output reg [3:0] stepperM0,
    output reg [3:0] stepperM1,
    output reg [3:0] stepperM2,
    output reg [3:0] stepperM3
    );
    
reg [31:0] clockCounter0;
reg [31:0] clockCounter1;
reg [31:0] clockCounter2;
reg [31:0] clockCounter3;

reg [2:0] step0;
reg [2:0] step1;
reg [2:0] step2;
reg [2:0] step3;

parameter STEPPER_DIVIDER = 125000;

integer stepDecrementer0 = 0;
integer stepDecrementer1 = 0;
integer stepDecrementer2 = 0;
integer stepDecrementer3 = 0;

logic rst;
logic [3:0] btn_db;
logic [3:0] btn_pulse;

debounce db_inst0 (.clk(clk), .rst(rst), .button(btn[0]), .result(btn_db[0]));
debounce db_inst1 (.clk(clk), .rst(rst), .button(btn[1]), .result(btn_db[1]));
debounce db_inst2 (.clk(clk), .rst(rst), .button(btn[2]), .result(btn_db[2]));
debounce db_inst3 (.clk(clk), .rst(rst), .button(btn[3]), .result(btn_db[3]));

single_pulse_detector pls_inst0 (.clk(clk), .rst(rst), .input_signal(btn_db[0]), .output_pulse(btn_pulse[0]));
single_pulse_detector pls_inst1 (.clk(clk), .rst(rst), .input_signal(btn_db[1]), .output_pulse(btn_pulse[1]));
single_pulse_detector pls_inst2 (.clk(clk), .rst(rst), .input_signal(btn_db[2]), .output_pulse(btn_pulse[2]));
single_pulse_detector pls_inst3 (.clk(clk), .rst(rst), .input_signal(btn_db[3]), .output_pulse(btn_pulse[3]));


always @(posedge clk) begin
    if(btn_pulse[0] == 1) begin
        stepDecrementer0 <= 4165;
    end
    if(stepDecrementer0 > 0) begin
        if(clockCounter0 >= STEPPER_DIVIDER) begin
            step0 <= step0 + 1'b1;
            clockCounter0 <= 1'b0;
            stepDecrementer0 <= stepDecrementer0 - 1;
        end else begin
            clockCounter0 <= clockCounter0 + 1'b1;
        end
    end else begin
        step0 <= 0;
        clockCounter0 <= 0;
    end
    
    if(btn_pulse[1] == 1) begin
        stepDecrementer1 <= 4165;
    end
    if(stepDecrementer1 > 0) begin
        if(clockCounter1 >= STEPPER_DIVIDER) begin
            step1 <= step1 + 1'b1;
            clockCounter1 <= 1'b0;
            stepDecrementer1 <= stepDecrementer1 - 1;
        end else begin
            clockCounter1 <= clockCounter1 + 1'b1;
        end
    end else begin
        step1 <= 0;
        clockCounter1 <= 0;
    end
    
    if(btn_pulse[2] == 1) begin
        stepDecrementer2 <= 4165;
    end
    if(stepDecrementer2 > 0) begin
        if(clockCounter2 >= STEPPER_DIVIDER) begin
            step2 <= step2 + 1'b1;
            clockCounter2 <= 1'b0;
            stepDecrementer2 <= stepDecrementer2 - 1;
        end else begin
            clockCounter2 <= clockCounter2 + 1'b1;
        end
    end else begin
        step2 <= 0;
        clockCounter2 <= 0;
    end
    
    if(btn_pulse[3] == 1) begin
        stepDecrementer3 <= 4165;
    end
    if(stepDecrementer3 > 0) begin
        if(clockCounter3 >= STEPPER_DIVIDER) begin
            step3 <= step3 + 1'b1;
            clockCounter3 <= 1'b0;
            stepDecrementer3 <= stepDecrementer3 - 1;
        end else begin
            clockCounter3 <= clockCounter3 + 1'b1;
        end
    end else begin
        step3 <= 0;
        clockCounter3 <= 0;
    end
end

always @(step0)
begin
    case(step0)
        0: stepperM0 <= 4'b1000;
        1: stepperM0 <= 4'b1100;
        2: stepperM0 <= 4'b0100;
        3: stepperM0 <= 4'b0110;
        4: stepperM0 <= 4'b0010;
        5: stepperM0 <= 4'b0011;
        6: stepperM0 <= 4'b0001;
        7: stepperM0 <= 4'b1001;
    endcase
end

always @(step1)
begin
    case(step1)
        0: stepperM1 <= 4'b1000;
        1: stepperM1 <= 4'b1100;
        2: stepperM1 <= 4'b0100;
        3: stepperM1 <= 4'b0110;
        4: stepperM1 <= 4'b0010;
        5: stepperM1 <= 4'b0011;
        6: stepperM1 <= 4'b0001;
        7: stepperM1 <= 4'b1001;
    endcase
end

always @(step2)
begin
    case(step2)
        0: stepperM2 <= 4'b1000;
        1: stepperM2 <= 4'b1100;
        2: stepperM2 <= 4'b0100;
        3: stepperM2 <= 4'b0110;
        4: stepperM2 <= 4'b0010;
        5: stepperM2 <= 4'b0011;
        6: stepperM2 <= 4'b0001;
        7: stepperM2 <= 4'b1001;
    endcase
end

always @(step3)
begin
    case(step3)
        0: stepperM3 <= 4'b1000;
        1: stepperM3 <= 4'b1100;
        2: stepperM3 <= 4'b0100;
        3: stepperM3 <= 4'b0110;
        4: stepperM3 <= 4'b0010;
        5: stepperM3 <= 4'b0011;
        6: stepperM3 <= 4'b0001;
        7: stepperM3 <= 4'b1001;
    endcase
end

endmodule
