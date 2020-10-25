`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:18:37 10/21/2020
// Design Name:   FourDigitLEDdriver
// Module Name:   /home/iordanis/Desktop/CE333/ergasia1merosc/testbench.v
// Project Name:  ergasia1merosc
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FourDigitLEDdriver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg reset;
	reg clk;
	//reg button;

	// Outputs
	wire an3;
	wire an2;
	wire an1;
	wire an0;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
	wire dp;
	
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	FourDigitLEDdriver uut (
		.reset(reset), 
		.clk(clk), 
		//.button(button),
		.an3(an3), 
		.an2(an2), 
		.an1(an1), 
		.an0(an0), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.dp(dp)
	);
	//aythn thn syxnothta prepei na ftasw
	/*
	always begin
		#125000 clk = ~clk;
	end
	*/
	always begin
		#40 clk = ~clk;
	end
	initial begin
		
		// Initialize Inputs
		reset = 1;
		clk = 0;
		//button = 0;

		// Wait 100 ns for global reset to finish
		#1000;
		reset = 0;
		/*
		for(i = 0; i < 100; i = i + 1)
		begin
			#1630
			button = 1;
			#20
			button = 0;
			#10 
			button = 1;
			#1000;
			button = 0;
		end
		*/
		
		
        
		// Add stimulus here

	end
      
endmodule

