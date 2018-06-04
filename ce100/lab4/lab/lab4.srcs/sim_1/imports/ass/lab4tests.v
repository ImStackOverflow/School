// CMPE 100 
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify this testbench to conform to your project.
`timescale 1ns/1ps

module lab4tests();
   
    reg clkin; //clk
    reg btnR; //reset fpga
    reg btnU; //up count by 1
    reg btnD; //down count by 1
    reg btnC; //continuous count till FFFC-FFFF
    reg btnL; //load switch values
    reg [15:0] sw; //switch input corresponding to 16 bit num
    wire [6:0] seg; //output to segment display 
    wire dp; //decimal point 
    wire [3:0] an; //segment annode
    wire [15:0] leds; //leds on board

// TODO: replace "top_lab2" with the name of your top level Lab 2 module.
   top UUT (
        .clkin(clkin), .btnR(btnR), .btnU(btnU), .btnD(btnD), 
        .btnC(btnC), .btnL(btnL), .sw(sw), .seg(seg), .dp(dp), .an(an), .leds(leds)
        );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)" 
     
    initial
    begin	


        #1000
        btnU=1'b1;
        #100
        btnU=1'b0;
        btnD=1'b1;
        #100
        btnD=1'b0;
        btnC=1'b1;
        #200
        btnC = 1'b0;

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
