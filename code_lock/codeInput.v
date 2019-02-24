`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:45 01/18/2019 
// Design Name:    code_lock
// Module Name:    codeInput 
// Project Name: 
// Target Devices: xc6slx150-3fgg484
// Tool versions:  ISE 14.7
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module codeInput(
	input clk,
	input n_rst,
	input codeSet_t,
	input keySured,
	input [3:0] keyValue,
	output reg codeFinish,
	output reg success,
	output reg ledSet
	);

reg  pre_keySured;
reg [23:0] code;
reg [3:0] cnt; 
reg [3:0] newCodeCnt;
reg [1:0] waitCnt;
reg [3:0] ram[5:0];
reg [3:0] CSRam[5:0];
reg       codeSet; //set password
reg [2:0] state;
reg pre_codeSet_t;
reg verify;//verify state
reg judge_allow;//allow judge

always @(posedge clk or negedge n_rst) 
begin
	if (!n_rst) begin
		codeSet <=0;
		code <=0;
		cnt <=4'h0;
		newCodeCnt <=4'h0;
		waitCnt <= 2'b00;
		codeFinish <= 1'b1;
		success <= 1'b0;
		ledSet <= 1'b1;
		state <= 0;
		verify <= 1'b0;
		judge_allow <= 1'b0;
		{ram[0],ram[1],ram[2],ram[3],ram[4],ram[5]}<=0;
		{CSRam[0],CSRam[1],CSRam[2],CSRam[3],CSRam[4],CSRam[5]}<=24'h012345;
	end
	else begin
		pre_keySured<=keySured;
		pre_codeSet_t<=codeSet_t;

		if({pre_codeSet_t,codeSet_t}==2'b01) begin
			verify <= 1;
			cnt <= 0;
		end
	
		case (state)
		0:	begin
				if ({pre_keySured,keySured}==2'b01)	//Ready to store when entering the rising edge
					state <= 1;
				else state<=0;
			end
		1: 	begin
				if (waitCnt >= 2) begin //Wait several cycles for keyValue to be ready
					waitCnt <= 0;
					state<=2;
				end
				else waitCnt <= waitCnt + 1'b1;
			end
		2: 	begin
				if (codeSet==1) begin
					CSRam[newCodeCnt]<=keyValue;
					newCodeCnt <= newCodeCnt + 1'b1;
				end
				else begin
					ram[cnt] <= keyValue;
					cnt <= cnt + 1'b1;
					success<=1'b0;   //Isn't successful				
				end
				codeFinish<=1'b1;//Input is not over
				judge_allow <= 1'b0;//Prohibit judgment
				state<=0;
			end
		endcase
		
		if(newCodeCnt==6) begin
			newCodeCnt<=0;
			codeSet<=0;         //End of password setting
			ledSet<=1'b1;       //The password setting light is off and the password setting is completed.
		end
		
		if (cnt==6) 
		begin
			cnt <= 0;           
			codeFinish<=1'b0;   //End of password entry
			judge_allow <= 1'b1;
		end
		
		if (judge_allow==1'b1) begin
			code<={ram[0],ram[1],ram[2],ram[3],ram[4],ram[5]};
			if (code=={CSRam[0],CSRam[1],CSRam[2],CSRam[3],CSRam[4],CSRam[5]}) 
			begin
				if(verify==1) begin
					verify <= 0;
					codeSet <= 1;
					ledSet <= 1'b0;
				end
				else success<=1'b1;				
			end
			{ram[0],ram[1],ram[2],ram[3],ram[4],ram[5]}<=0;
			code<=0;
		end
	end
end
endmodule
