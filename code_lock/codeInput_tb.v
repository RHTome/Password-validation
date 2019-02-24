`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:09:07 02/23/2019
// Design Name:   codeInput
// Module Name:   C:/Users/17813/Downloads/ex/ex/Calix/code_lock/codeInput_tb.v
// Project Name:  code_lock
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: codeInput
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module codeInput_tb;

	// Inputs
	reg clk;
	reg n_rst;
	reg codeSet_t;
	reg keySured;
	reg [3:0] keyValue;

	// Outputs
	wire codeFinish;
	wire success;
	wire ledSet;

	// Instantiate the Unit Under Test (UUT)
	codeInput uut (
		.clk(clk), 
		.n_rst(n_rst), 
		.codeSet_t(codeSet_t), 
		.keySured(keySured), 
		.keyValue(keyValue), 
		.codeFinish(codeFinish), 
		.success(success), 
		.ledSet(ledSet)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		n_rst = 0;
		codeSet_t = 0;
		keySured = 0;
		keyValue = 0;

		// Wait 100 ns for global reset to finish
		#100;
      n_rst = 1;  
		// Add stimulus here
		#200 codeSet_t=1;
		#200 codeSet_t=0;
		
		#50 keyValue=0;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=1;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=2;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=3;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=4;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=5;
		#10 keySured=1;
		#500 keySured=0;
		
		////////////////////////////////
		
		#50 keyValue=1;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=3;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=5;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=7;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=9;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=0;
		#10 keySured=1;
		#500 keySured=0;
		
		////////////////////////////////
		
		#50 keyValue=1;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=3;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=5;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=7;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=9;
		#10 keySured=1;
		#500 keySured=0;
		
		#50 keyValue=0;
		#10 keySured=1;
		#500 keySured=0;
	end
   always begin                                                                         
		#10  clk=~clk; 
	end
      
endmodule

