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


//mux to work with bit shifter
//output 4 bit section of 16 bit  count input
//4 bit shifter input
//count = 16 bit digit
//ring = bit rotator/bit shifter
//digit = 4 bit digit output

module selector(
    input [15:0] count,
    input [3:0] ring,
    output [3:0] digit
    );

    assign digit = {4{ring[3]}} & count[15:12] | 
                    {4{ring[2]}} & count[11:8]  |
                    {4{ring[1]}} & count[7:4]   |
                    {4{ring[0]}} & count[3:0];
    
endmodule
