`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2018 12:21:23 AM
// Design Name: 
// Module Name: fuckingTIME
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

//time counter
module fuckingTIME(
    input go, // load in time and count down
    input clk, //clock 
    output [7:0] tiempo, //current time 
    output timeup //times up
    );
    
    //shit = random number, out = output
    wire [7:0] shit, out;
    //next=counter shit, actually atart is to make sure value is loaded in on one clock cycle
    wire next, actuallystart;
    //random number generator
    random rand (.clk(clk), .dick(shit));
    
    //edgeD output high for just one clock cycle
    edgeD edgeplay (.clk(clk), .sh(go), .it(actuallystart));
    
    //lower bits counter
    countUD4L lower (.clk(clk), .up(1'b0), .down(go), .ld(actuallystart),
                    .din(shit[3:0]), .dtc(next), .Q(out[3:0]));
    
    //upper bits counter
     countUD4L upper (.clk(clk), .up(1'b0), .down(next), .ld(actuallystart), 
                       .din(shit[7:4]), .Q(out[7:4]));
                       
                       
     assign timeup = ~{|{tiempo}};
                    
    
endmodule
