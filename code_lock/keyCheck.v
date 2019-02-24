`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:28 02/18/2019 
// Design Name:    code_lock
// Module Name:    keyCheck 
// Project Name: 
// Target Devices: xc6slx150-3fgg484
// Tool versions:  ISE 14.7
// Description: The keyCheck module is used to confirm which button  
// is pressed and then output the value represented by the button. 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module keyCheck(
	input clk,
	input n_rst,
	input row1,
	input row2,
	input row3,
	input row4,
	output reg col1,
	output reg col2,
	output reg col3,
	output reg col4,
	output reg [3:0] key_value,
	output reg keySured
	);
parameter   TIME_20MS = 1000;
reg [20:0] cnt;
wire [3:0] row;
reg [3:0] col;
reg [3:0] col_reg;
reg [3:0] row_reg;
reg [2:0] state;
assign row={row4,row3,row2,row1};
always @(posedge clk or negedge n_rst) begin
	if (!n_rst) begin
		col<=4'b0000;
		state<=0;
		cnt<=0;
	end
	else begin
		case (state)
		0:
			begin
				col[3:0]<=4'b0000;
				keySured<=1'b0;
				if (row[3:0]!=4'b1111) begin
					state<=6;//keyPressed = true, start debounce.
				end
				else state<=0;
			end

		6:
			begin
				if (cnt >= TIME_20MS-1) begin//delay 20ms
					cnt <= 0;
					if (row[3:0]!=4'b1111) begin
						state<=1;//keyPressed = true, start to determine the location of the key. go to state 1.
						col[3:0]<=4'b1110;//scan from column 1 to column 4. column 1 first.						
					end
					else state<=0;
				end
				else cnt <= cnt + 1'b1;
			end
		
		1:
			begin   
			//delay 1ms
				if (cnt >= 50-1) begin
					cnt <= 0;
					if(row[3:0]!=4'b1111) begin 
						state<=5;
					end
					else  begin 
						state<=2;
						col[3:0]<=4'b1101;//scan column 2.
					end
				end
				else cnt <= cnt + 1'b1;								
			end

		2:
			begin   
				//delay 1ms
				if (cnt >= 50-1) begin
					cnt <= 0;
					if(row[3:0]!=4'b1111) begin 
						state<=5;
					end
					else  begin 
						state<=3;
						col[3:0]<=4'b1011;//scan column 3.
					end
				end
				else cnt <= cnt + 1'b1;	
			end

        3:
				begin   
				//delay 1ms
					if (cnt >= 50-1) begin
						cnt <= 0;
						if(row[3:0]!=4'b1111) begin 
							state<=5;
						end
						else  begin 
							state<=4;
							col[3:0]<=4'b0111;//scan column 4.
						end
					end
					else cnt <= cnt + 1'b1;								
				end

	    4:
				begin   
				//delay 1ms
					if (cnt >= 50-1) begin
						cnt <= 0;
						if(row[3:0]!=4'b1111) begin 
							state<=5;
						end
						else  begin 
							state<=0;//maybe it's a bounce appears in a tiny time.
						end
					end
					else cnt <= cnt + 1'b1;								
				end				

	    5:
	        begin  
	        	if(row[3:0]!=4'b1111) begin
					col_reg<=col;  //save col
					row_reg<=row;  //save row
					state<=5;			
					keySured<=1'b1;					
				end             
        		else begin
        			state<=0;
        		end
        	end  
    	endcase 
		{col1,col2,col3,col4}<={col[0],col[1],col[2],col[3]};
   end 
end

always @(clk or col_reg or row_reg)
begin
	if(keySured==1'b1) begin
	    case ({row_reg,col_reg})
	    	8'b1110_1110:key_value<=0;
	    	8'b1110_1101:key_value<=1;
	    	8'b1110_1011:key_value<=2;
	    	8'b1110_0111:key_value<=3;

	    	8'b1101_1110:key_value<=4;
	    	8'b1101_1101:key_value<=5;
	    	8'b1101_1011:key_value<=6;
	    	8'b1101_0111:key_value<=7;

	    	8'b1011_1110:key_value<=8;
	    	8'b1011_1101:key_value<=9;
	    	8'b1011_1011:key_value<=10;
	    	8'b1011_0111:key_value<=11;

	    	8'b0111_1110:key_value<=12;
	    	8'b0111_1101:key_value<=13;
	    	8'b0111_1011:key_value<=14;
	    	8'b0111_0111:key_value<=15;     
	    endcase 
    end   
end       
endmodule


