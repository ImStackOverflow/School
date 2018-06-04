`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 02:33:57 PM
// Design Name: 
// Module Name: counterUD16L
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


//edge detector
//outputs a high signal for one clock cycle
//on input to in of sequence 10

module edgeD(
    input clk, //clock
    input in, //input
    output out //output high for 1 clock
    );

    wire o0;
    
    //first bit
    FDRE #(.INIT(1'b0) ) q0 (.C(clk), .R(1'b0), .CE(~clk), .D(in), .Q(o0));

   assign out = ~o0 & in;
    
endmodule
