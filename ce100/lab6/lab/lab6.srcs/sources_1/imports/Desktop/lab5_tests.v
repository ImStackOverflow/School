// CMPE 100 
// This is a testbench for Lab 2.
// If the top level module in your Lab 2 project is named "top_lab2"
// and you used the suggested names for its inputs/outputs then
// then it will run without modification.  Otherwise follow the instructions
// in the comments marked "TODO" to modify this testbench to conform to your project.
`timescale 1ns/1ps

module lab2_tests();
   
   reg [7:0] in1; //first input number a
   reg [7:0] in2; //second input number b
   reg btnU; //sub function
   reg btnR; //global reset
   reg clkin;//switch input and subtract func
   wire [3:0] an; //anode switch
   wire [6:0] C;
   wire dp; //output and decimal point
   
// TODO: replace "top_lab2" with the name of your top level Lab 2 module.
   TopGun UUT (
        .sw({in2,in1}), .btnU(btnU), .btnR(btnR), .clkin(clkin), .seg(C), .dp(dp), .an(an)
        );
// TODO: In the three lines above, make sure the pin names match the names
// used for the inputs/outputs of your top level module.   For example, if you
// used "cin" rather than "sw0", then replace ".sw0(sw0)" with ".cin(sw0)" 
     
    initial
    begin	

        btnU=1'b0;
        btnR=1'b0;
        in1 = {8{1'b0}}; //initialize numbers to 0
        in2 = {8{1'b0}}; //inititialize numbers to 0
        // sum is 0 
	//-------------  Current Time:  0ns
	#100;  //This advances time by 100 units (ns in this case)
	in1 = {8'b00000001};
	in2 = {8'b00000000};
        // sum is 1
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000001;
	in2 = 8'b00000001;
        // sum is 2
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000010;
	in2 = 8'b00000001;
        // sum is 3
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000010;
	in2 = 8'b00000010;
        // sum is 4
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000011;
	in2 = 8'b00000010;
        // sum is 5
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000011;
	in2 = 8'b00000011;
        // sum is 6
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000100;
	in2 = 8'b00000011;
        // sum is 7
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'h8;
	in2 = 8'b00000000;
        // sum is 8
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'h9;
	in2 = 8'b00000000;
        // sum is 9
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'hA;
	in2 = 8'b00000000;
        // sum is A
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'hB;
	in2 = 8'b00000000;
        // sum is B
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'hC;
	in2 = 8'b00000000;
        // sum is C
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'hD;
	in2 = 8'b00000000;
        // sum is D
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'hE;
	in2 = 8'b00000000;
        // sum is E
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 1'hF;
	in2 = 8'b00000000;
        // sum is F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'H1F;
	in2 = 8'b00000000;
        // sum is 1F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h2F;
	in2 = 8'b00000000;
        // sum is 2F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h3F;
	in2 = 8'b00000000;
        // sum is 3F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h4F;
	in2 = 8'b00000000;
        // sum is 4F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h5F;
	in2 = 8'b00000000;
        // sum is 5F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h6F;
	in2 = 8'b00000000;
        // sum is 6F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h7F;
	in2 = 8'b00000000;
        // sum is 7F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h8F;
	in2 = 8'b00000000;
        // sum is 8F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'h9F;
	in2 = 8'b00000000;
        // sum is 9F
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'hAF;
	in2 = 8'b00000000;
        // sum is AF
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'hBF;
	in2 = 8'b00000000;
        // sum is BF
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'hCF;
	in2 = 8'b00000000;
        // sum is CF
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'hDF;
	in2 = 8'b00000000;
        // sum is DF
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'hEF;
	in2 = 8'b00000000;
        // sum is EF
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 2'hFF;
	in2 = 8'b00000000;
        // sum is FF
        // -------------  Current Time:  100ns
        
        
        
    //ALTERNATING SIGN TESTS    
    
	#100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b00000010;
    in2 = 8'b00000001;
            // sum is 3
            // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b10000010;
	in2 = 8'b00000001;
        // sum is 3
        // -------------  Current Time:  100ns


	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b00000010;
	in2 = 8'b10000001;
        // sum is 3
        // -------------  Current Time:  100ns


	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b10000010;
	in2 = 8'b10000001;
        // sum is 3
        // -------------  Current Time:  100ns


	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b01000010;
	in2 = 8'b01000001;
        // sum is 3
        // -------------  Current Time:  100ns


	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b11000010;
	in2 = 8'b01000001;
        // sum is 3
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b01000010;
	in2 = 8'b11000001;
        // sum is 3
        // -------------  Current Time:  100ns

	#100;  //This advances time by 100 units (ns in this case)
	in1 = 8'b11000010;
	in2 = 8'b11000001;
        // sum is 3
        // -------------  Current Time:  100ns
        

    //SAME TESTS BUT NOW SHIT HAS THE SUB BUTTON FUNCTION ACTIVATED        
        
    btnU = 1'b1;
    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b00000010;
    in2 = 8'b00000001;
            // sum is 3
            // -------------  Current Time:  100ns

    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b10000010;
    in2 = 8'b00000001;
        // sum is 3
        // -------------  Current Time:  100ns


    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b00000010;
    in2 = 8'b10000001;
        // sum is 3
        // -------------  Current Time:  100ns


    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b10000010;
    in2 = 8'b10000001;
        // sum is 3
        // -------------  Current Time:  100ns


    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b01000010;
    in2 = 8'b01000001;
        // sum is 3
        // -------------  Current Time:  100ns


    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b11000010;
    in2 = 8'b01000001;
        // sum is 3
        // -------------  Current Time:  100ns

    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b01000010;
    in2 = 8'b11000001;
        // sum is 3
        // -------------  Current Time:  100ns

    #100;  //This advances time by 100 units (ns in this case)
    in1 = 8'b11000010;
    in2 = 8'b11000001;
        // sum is 3
        // -------------  Current Time:  100ns
        

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
