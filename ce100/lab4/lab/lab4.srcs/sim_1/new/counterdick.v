// CMPE 100 
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify this testbench to conform to your project.
`timescale 1ns/1ps

module counterdick();


   
    reg clkin; //input clock fucker
    reg up; //count up
    reg dw; //count down
    reg ld; //load option
    reg [15:0] sw; //input switches
    wire utc; //output one when all flip flops high
    wire dtc; //one when all the fuckers are 0
    wire [15:0] out; //output number count
// TODO: replace "top_lab2" with the name of your top level Lab 2 module.
   counterUD16L UUT (
        .cock(clkin), .up(up), .dw(dw), .ld(ld), .sw(sw), 
        .utc(utc), .dtc(dtc), .out(out)
        );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)" 
     
    initial
    
    begin
        up = 1'b0;
        dw = 1'b0;
        ld	 = 1'b0;
        #100
         sw = 16'b1111111111111000;
               ld=1'b1;
               //load in number
               #100
               ld = 1'b0;
        up=1'b1;
        //count up for 100 ns
        #150
        up=1'b0;
        sw = 16'b0000000000000111;
        ld = 1'b1;
        #100
        ld = 1'b0;
        dw=1'b1;
        //count down for 100ns
        #150
        dw=1'b0;
       

    end
    
    parameter PERIOD = 10;
     parameter real DUTY_CYCLE = 0.5;
     parameter OFFSET = 2;
 
     initial    // Clock process for clkin
     begin
         #OFFSET
           clkin = 1'b1;
         forever
         begin
             #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
         end
     end
     
    initial
    begin
      // add your stimuli here
      // to set signal foo to value 0 use
      // foo = 1'b0;
      // to set signal foo to value 1 use
      // foo = 1'b1;
      //always advance time my multiples of 100ns
      // to advance time by 100ns use the following line
      #100;
     end
endmodule	