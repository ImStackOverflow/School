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


module counterUD16L(
    input up, //continuous count up
    input dw, //continuous count down
    input ld, //load in switches
    input cock, //clock
    input [15:0] sw, //loadable switches
    output [15:0] out, //output numnber
    output utc, //up counter 
    output dtc //down counter
    );
    
    //wires to chain up and down counters to subsequent counters
    wire [2:0] fuckup, throwdown;
    
    //1 only if all outputs 1
    assign utc = &out;
    
    //1 only if all outputs 0
    assign dtc = ~(|out);
    //lower
    countUD3L dick (.clk(cock), .up(up), .down(dw), .ld(ld), .din(sw[2:0]), .utc(fuckup[0]), .dtc(throwdown[0]), .Q(out[2:0]));   
    //lower
    countUD5L tits (.clk(cock), .up(fuckup[0]), .down(throwdown[0]), .ld(ld), .din(sw[7:3]), .utc(fuckup[1]), .dtc(throwdown[1]), .Q(out[7:3]));
    //upper
    countUD5L ass (.clk(cock), .up(fuckup[1]), .down(throwdown[1]), .ld(ld), .din(sw[12:8]), .utc(fuckup[2]), .dtc(throwdown[2]), .Q(out[12:8]));
    //upper
    countUD3L pein (.clk(cock), .up(fuckup[2]), .down(throwdown[2]), .ld(ld), .din(sw[15:13]), .utc(), .dtc(), .Q(out[15:13]));
    
endmodule
