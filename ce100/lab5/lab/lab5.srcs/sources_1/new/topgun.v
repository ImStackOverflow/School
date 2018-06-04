`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 12:08:41 AM
// Design Name: 
// Module Name: topgun
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


module topgun(
    input clkin,
    input btnU,
    input btnD,
    input btnC,
    input btnR,
    input sw,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg
    );
    
    wire clk, digsel, qsec, p1, p2, lastled, tup, run, ldtime, showtime, reset,
        showscore, flashp1, flashp2, incp1, incp2, halfsec, fuckingtime;
        
    wire [3:0] ring, n, p1score, p2score;
    wire [7:0] timebro;
    wire [15:0] display;
    
    //the fucking clock u fucking bitch
    lab5_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    FDRE #(.INIT(1'b1) ) halfass (.C(clk), .R(0), .CE(qsec), .D(1^halfsec), .Q(halfsec));
    
    //the fucking statemachine u whore
    shit state (.clk(clk), .btnc(btnC), .btnu(p1), .btnd(p2), .led(lastled), .tup(tup), 
        .reset(reset), .incu(incp1), .incd(incp2), .showscore(showscore), .runit(run), .ldtime(ldtime), .showtime(showtime));
        
    //fucking module shit
    shitfuck anus (.reset(reset), .up(btnU), .down(btnD), .incu(incp1), .incd(incp2), .clk(clk), .ubtn(p1), 
        .dbtn(p2), .flashu(flashp1), .flashd(flashp2));
        
    //led shifter shit
    //incriment on quarter second
    LEDshifter shitter (.clk(clk), .run(showtime&qsec), .lastled(lastled), .led(led));
    
    //FUCKING TIME BRO
    timeshit intersteallar (.clk(clk), .run(run&qsec), .ld(ldtime), .fuckingtime(timebro), .timeup(tup));

    //bitchass ring counter
    ringcounter shouldaputatingonit (.adv(digsel), .clk(clk), .o(ring));
    
    //bitch fuck selector
    selector bitchfuck (.count(display), .ring(ring), .digit(n));
    
    //fucking segway display bitch
    hex7seg segway (.n(n), .e(1'b1), .seg(seg));
    
    //p1 score shit
    countUD4L player1 (.clk(clk), .up(incp1), .Q(p1score));
    
    //p2 score shit
    countUD4L player2 (.clk(clk), .up(incp2), .Q(p2score));
    
    //set the fucking display data
    assign display = {p1score, timebro, p2score};
    
    //set the fucking display on shit
    assign an = ~{showscore&(1'b1^(flashp1&halfsec))&ring[3], (sw|showtime)&ring[2], (sw|showtime)&ring[1], showscore&(1'b1^(flashp2&halfsec))&ring[0]};
    

endmodule
