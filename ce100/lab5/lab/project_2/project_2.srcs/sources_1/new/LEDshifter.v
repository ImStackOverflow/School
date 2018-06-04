`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2018 12:38:16 AM
// Design Name: 
// Module Name: LEDshifter
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

//16 bit shifter
//grows 1's in array 
module LEDshifter(
    input reset,
    input clk,
    input enable,
    input [15:0] led
    );
     FDRE #(.INIT(1'b0) ) q0 (.C(clk), .R(reset), .CE(enable), .D(1'b1), .Q(led[0]));
     FDRE #(.INIT(1'b0) ) q1 (.C(clk), .R(reset), .CE(enable), .D(led[0]), .Q(led[1]));
     FDRE #(.INIT(1'b0) ) q2 (.C(clk), .R(reset), .CE(enable), .D(led[1]), .Q(led[2]));
     FDRE #(.INIT(1'b0) ) q3 (.C(clk), .R(reset), .CE(enable), .D(led[2]), .Q(led[3]));
     FDRE #(.INIT(1'b0) ) q4 (.C(clk), .R(reset), .CE(enable), .D(led[3]), .Q(led[4]));
     FDRE #(.INIT(1'b0) ) q5 (.C(clk), .R(reset), .CE(enable), .D(led[4]), .Q(led[5]));
     FDRE #(.INIT(1'b0) ) q6 (.C(clk), .R(reset), .CE(enable), .D(led[5]), .Q(led[6]));
     FDRE #(.INIT(1'b0) ) q7 (.C(clk), .R(reset), .CE(enable), .D(led[6]), .Q(led[7]));
     FDRE #(.INIT(1'b0) ) q8 (.C(clk), .R(reset), .CE(enable), .D(led[7]), .Q(led[8]));
     FDRE #(.INIT(1'b0) ) q9 (.C(clk), .R(reset), .CE(enable), .D(led[8]), .Q(led[9]));
     FDRE #(.INIT(1'b0) ) q10 (.C(clk), .R(reset), .CE(enable), .D(led[9]), .Q(led[10]));
     FDRE #(.INIT(1'b0) ) q11 (.C(clk), .R(reset), .CE(enable), .D(led[10]), .Q(led[11]));
     FDRE #(.INIT(1'b0) ) q12 (.C(clk), .R(reset), .CE(enable), .D(led[11]), .Q(led[12]));
     FDRE #(.INIT(1'b0) ) q13 (.C(clk), .R(reset), .CE(enable), .D(led[12]), .Q(led[13]));
     FDRE #(.INIT(1'b0) ) q14 (.C(clk), .R(reset), .CE(enable), .D(led[13]), .Q(led[14]));
     FDRE #(.INIT(1'b0) ) q15 (.C(clk), .R(reset), .CE(enable), .D(led[14]), .Q(led[15]));
endmodule
