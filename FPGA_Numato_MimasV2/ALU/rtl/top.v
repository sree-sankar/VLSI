`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:47:08 05/09/2021 
// Design Name: 
// Module Name:    top 
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
module top( input i_clk,i_rst,
				input[7:0] i_dataIn,
				input i_Sub,i_Mult,i_And,i_Or,i_Compare,
			   output [7:0] o_SevenSegment,
			   output [2:0] o_SevenSegmentEnable);
			  
	wire [3:0] w_A;
	wire [3:0] w_B;
	wire w_clk10KHz;								
   wire w_clk1Hz;
   wire [1:0] w_refreshCounter;
   wire [3:0] w_digit;
   wire [3:0] w_digit1;
   wire [3:0] w_digit2;
   wire [3:0] w_digit3;
   wire [2:0] w_sevenSegmentEnable;
   wire [7:0] w_sevenSegment;
	wire [7:0] w_result;
	
			  
	assign o_SevenSegmentEnable[2] = i_rst && w_sevenSegmentEnable[2];
	assign o_SevenSegmentEnable[1] = i_rst && w_sevenSegmentEnable[1];
	assign o_SevenSegmentEnable[0] = i_rst && w_sevenSegmentEnable[0];
			  
	assign o_SevenSegment[7] = i_rst && w_sevenSegment[7];
	assign o_SevenSegment[6] = i_rst && w_sevenSegment[6];
	assign o_SevenSegment[5] = i_rst && w_sevenSegment[5];
	assign o_SevenSegment[4] = i_rst && w_sevenSegment[4];
	assign o_SevenSegment[3] = i_rst && w_sevenSegment[3];
	assign o_SevenSegment[2] = i_rst && w_sevenSegment[2];
	assign o_SevenSegment[1] = i_rst && w_sevenSegment[1];
	assign o_SevenSegment[0] = i_rst && w_sevenSegment[0];
			  			  

	clock_divider #(.FREQ(1),.DEFAULT_CLK(100000000)) CLOCK_GENERATOR_1Hz(.i_clk(i_clk),
																 .i_rst(i_rst),
												             .o_clk(w_clk1Hz));
																 
	clock_divider #(.FREQ(10000),.DEFAULT_CLK(100000000)) CLOCK_GENERATOR_10KHz(.i_clk(i_clk),
																		.i_rst(i_rst),
																		.o_clk(w_clk10KHz));
	
	refresh_counter REFRESH_COUNTER(.i_rst(i_rst),
											  .i_refresh_clk(w_clk10KHz),
											  .o_refreshCounter(w_refreshCounter));

	segment_control SEGMENT_CONTROL(.i_refresh_counter(w_refreshCounter),
											  .o_segmentEnable(w_sevenSegmentEnable));

	alu ALU(.i_A({4'b0000,~i_dataIn[0],~i_dataIn[1],~i_dataIn[2],~i_dataIn[3]}),
			  .i_B({4'b0000,~i_dataIn[4],~i_dataIn[5],~i_dataIn[6],~i_dataIn[7]}),
			  .i_Or(i_Or),
			  .i_Sub(i_Sub),
			  .i_Mult(i_Mult),
			  .i_And(i_And),
			  .i_Compare(i_Compare),
			 .o_result(w_result));
				
	bin2bcd BIN2BCD( .i_clk(i_clk),
						  .i_rst(i_rst),
						  .i_Binary(w_result),
						  .o_Ones(w_digit1),
						  .o_Tens(w_digit2),
						  .o_Hundreds(w_digit3));
	
	
	segment_selector SEGMENT_SELECTOR(.i_digit1(w_digit1),
									  .i_digit2(w_digit2),
									  .i_digit3(w_digit3),
									  .i_refreshCounter(w_refreshCounter),
									  .o_digit(w_digit));
	
	seven_segment_driver SEVEN_SEGMENT(.i_digit(w_digit),
									   .o_sevenSegmentLed(w_sevenSegment));
	


endmodule
