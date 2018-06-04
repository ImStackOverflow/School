`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2018 11:23:44 PM
// Design Name: 
// Module Name: timeshit
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


//time machine
//takes in as input run and load signals
//load while ld is high
//output on time, no roll down effect

module timeshit(
    input run,
    input ld,
    input clk,
    output [7:0] fuckingtime,
    output timeup
    );
    
    wire [7:0] fuck;
    wire fucking, shit;
    
    //random generator
    random rambo (.clk(clk), .enable(1'b1), .dick(fuck));
    
    //lower bits
    countUD4L cock1 (.clk(clk), .down(run&~timeup), .ld(ld), .up(1'b0),
        .din(fuck[3:0]), .Q(fuckingtime[3:0]), .dtc(fucking));
        
        
    //upper bits
    countUD4L cock2 (.clk(clk), .down(fucking&~timeup), .ld(ld), .up(1'b0),
        .din(fuck[7:4]), .Q(fuckingtime[7:4]), .dtc(shit));
    assign timeup = ~|fuckingtime;
    
endmodule
