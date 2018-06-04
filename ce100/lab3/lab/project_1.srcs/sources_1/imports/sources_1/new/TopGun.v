`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2018 01:52:42 AM
// Design Name: 
// Module Name: TopGun
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


module TopGun(
    input [15:0] sw, //input switch a = lower bits, b = upper
    input btnU, //subtraction function
    input btnR, //greset
    input clkin, //input clock
    output [6:0] seg, //segment display
    output dp, //decimal point
    output [3:0] an //annode
    
    
    );
    wire [7:0] sum;
    wire [7:0] low;
    wire [7:0] up;
    wire over, dig_sel;
    
    //lab3 header provided and shit
    lab3_digsel ass (.clkin(clkin), .greset(btnR), .digsel(dig_sel));
    
    //calculator using switches and up button as input
    //switches are number in binary
    //up button is subtraction option
    //sum is wired to 8 bit bus
    AddSub8 calc (.A(sw[7:0]), .B(sw[15:8]), .sub(btnU), .S(sum), .ovfl(over));
    
    //upper 4 bit led converter
    //converts upper 4 bits of sum into led display
    //always enabled
    //output on 8 bit bus up
    hex7seg upper(.n(sum[7:4]), .e(1), .seg(up));
    //same as previous but with lower bits
    //output bussed to low
    hex7seg lower(.n(sum[3:0]), .e(1), .seg(low));
    
    //chooses whitch segment display to wire
    //both lower and upper bits fed as input
    //choose connection with dig_sel wire
    //output = 8 bit bus to segment display
    assign an = {1'b1, 1'b1, dig_sel, ~dig_sel};
    assign dp = ~over; 
    //assign seg = {4{1'b0}};
    BusFux toggle(.in1(low), .in2(up), .s(dig_sel), .out(seg));
    
    //assign JA[0] = dig_sel;
    
endmodule
