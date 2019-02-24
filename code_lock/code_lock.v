`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:46 01/17/2019 
// Design Name: 
// Module Name:    RAM4 
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
module code_lock(
	input clk,
	input n_rst,
	input codeSet_t,
	input row1,
	input row2,
	input row3,
	input row4,
	output col1,
	output col2,
	output col3,
	output col4,
	output keySured,
	output ledSet,	//最右边4个led：{led13,led1,led2,led3} 
	/*
	output [1:0] 	num2_scan_select,//选择FPGA_NUM1 7段数码管的扫描位
	output [7:0] 	num2_seg7,			//FPGA_NUM1 7段数码管显示DP和a~g
	output [3:0] 	num4_scan_select,//选择FPGA_NUM1 7段数码管的扫描位
	output [7:0] 	num4_seg7,			//FPGA_NUM1 7段数码管显示DP和a~g
	*/
	output ledFinish,
	output ledSuccess
);

wire [23:0] code;
wire [3:0] keyValue;
wire clk_50kHz;
/*	 
seg7_num4		seg1(
				.clk(clk),		
				.rst_n(rst_n),	
				.display_num(code[23:8]),		
				.dtube_cs_n(num4_scan_select),	
				.dtube_data(num4_seg7)	
		);	 

seg7_num2		seg2(
				.clk(clk),		
				.rst_n(rst_n),	
				.display_num(code[7:0]),		
				.dtube_cs_n(num2_scan_select),	
				.dtube_data(num2_seg7)	
		);		
*/
Divider Divider1(
   .clk(clk),
	.n_rst(n_rst),
	.clk_50kHz(clk_50kHz)
    );
	 
codeInput codeInput1(
	.clk(clk_50kHz),
	.n_rst(n_rst),
	.codeSet_t(codeSet_t),
	.keySured(keySured),
	.keyValue(keyValue),
	.codeFinish(ledFinish),
	.success(ledSuccess),
	.ledSet(ledSet)
	);	 
	
keyCheck keyCheck1(
	.clk(clk_50kHz),
	.n_rst(n_rst),
	.row1(row1),
	.row2(row2),
	.row3(row3),
	.row4(row4),
	.col1(col1),
	.col2(col2),
	.col3(col3),
	.col4(col4),
	.key_value(keyValue),
	.keySured(keySured)
	);
endmodule

