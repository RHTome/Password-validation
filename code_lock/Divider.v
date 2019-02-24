`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:58:45 02/22/2019 
// Design Name: 
// Module Name:    Divider 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Divider(
    input clk,//50MHZ
    input n_rst,
    output reg clk_50kHz
    );
reg [8:0] count;	
parameter CLK_Freq = 50000000;
parameter OUT_Freq = 50000; 

always @(posedge clk or negedge n_rst)
begin
	if(!n_rst) begin 
		clk_50kHz<=0; 
		count<=0;		
	end
	else begin
		if( count >= (CLK_Freq/(2*OUT_Freq)-1) ) begin 
			clk_50kHz<=~clk_50kHz;
			count<=0;
		end
		else count<=count+1'b1;
	end
end
endmodule
