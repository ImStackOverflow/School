`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2018 11:59:30 PM
// Design Name: 
// Module Name: random
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

//random number generator
//outputs some random 8 bit number, highest bit is 0
module random(
    input clk,
	input enable,
    output [7:0] dick
    );
    
    wire [7:0] shit;
    wire ass;
    assign ass = shit[0]^shit[5]^shit[6]^shit[7];
    
    FDRE #(.INIT(1'b1) ) b0 (.C(clk), .R(reset), .CE(enable), .D(ass), .Q(shit[0]));
    FDRE #(.INIT(1'b0) ) b1 (.C(clk), .R(reset), .CE(enable), .D(shit[0]), .Q(shit[1]));
    FDRE #(.INIT(1'b0) ) b2 (.C(clk), .R(reset), .CE(enable), .D(shit[1]), .Q(shit[2]));
    FDRE #(.INIT(1'b0) ) b3 (.C(clk), .R(reset), .CE(enable), .D(shit[2]), .Q(shit[3]));
    FDRE #(.INIT(1'b0) ) b4 (.C(clk), .R(reset), .CE(enable), .D(shit[3]), .Q(shit[4]));
    FDRE #(.INIT(1'b0) ) b5 (.C(clk), .R(reset), .CE(enable), .D(shit[4]), .Q(shit[5]));
    FDRE #(.INIT(1'b0) ) b6 (.C(clk), .R(reset), .CE(enable), .D(shit[5]), .Q(shit[6]));
    FDRE #(.INIT(1'b0) ) b7 (.C(clk), .R(reset), .CE(enable), .D(shit[6]), .Q(shit[7]));
    
    assign dick = {1'b0,shit[6:0]};
endmodule
