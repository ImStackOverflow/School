`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 10:56:55 AM
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


//endframe is from vga counter
//60hz refresh rate = counter for 60 end frames
//hsec is high/low for a full half second
//sec is high for only single clock cycle only every second

module timeshit(
    input endframe,
    input clk,
    output hsec,
    output sec
    );
    
    //high for one clock cycle once frame buffer = 32
    //ie high for one clock cycle every half second
    wire tick, hsec;
    countUD5L bottom (.clk(clk), .up(endframe), .down(1'b0), .ld(1'b0), 
        .din(5'b00000), .utc(tick));
        
    //one extra bit that will toggle itself only on half second
    //FDRE #(.INIT(1'b0) ) halfsec (.C(clk), .R(1'b0), .CE(tick), .D(1'b1 ^ hsec), .Q(hsec));
    FDRE #(.INIT(1'b0) ) halfsec (.C(clk), .R(1'b0), .CE(tick), .D(1'b1 ^ hsec), .Q(hsec));


    //sec is high if hsec is rolling over
    assign sec = endframe & hsec & tick;    
    
endmodule
