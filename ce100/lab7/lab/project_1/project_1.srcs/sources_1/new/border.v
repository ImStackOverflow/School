`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2018 01:03:36 PM
// Design Name: 
// Module Name: border
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

//takes in as input the current screen pixel location
//outputs a rgb bullshit thing if the current pixel is within the border tolerances

module border(
    input [9:0] horizontal,
    input flash,
    input qsec,
    input [9:0] vert,
    output [3:0] blue,
    output [3:0] red
    );
    wire blure;
    //blue is active in this fucking range bitch
    assign blure = horizontal <= 10'd10 | vert <= 10'd10 | horizontal >= 10'd629 | vert >= 10'd469;
    assign blue = {4{blure ^ (blure & flash & qsec)}};
endmodule
