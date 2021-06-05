`timescale 1ns / 1ps


module top(input i_clk, 									// INPUT CLOCK 
			  input i_rst,									  	// INPUT RESET
			  input i_startStop,								// STOP TIMER 
			  output [7:0] o_SevenSegment,				// OUTPUT SEVENSEGMENT LED
			  output [2:0] o_SevenSegmentEnable);		// OUTPUT TO ENABLE SEVENSEGMENT LED
			  
			  wire w_clk10KHz;								
			  wire w_clk1Hz;
			  wire [1:0] w_refreshCounter;
			  wire [3:0] w_digit;
			  wire [3:0] w_digit1;
			  wire [3:0] w_digit2;
			  wire [3:0] w_digit3;
			  wire [2:0] w_sevenSegmentEnable;
			  wire [7:0] w_sevenSegment;
			  
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

	timer TIMER(.i_clk(w_clk1Hz),
					.i_rst(i_rst),
					.i_startStop(i_startStop),
				   .o_digit1(w_digit1),
					.o_digit2(w_digit2),
					.o_digit3(w_digit3));
	
	segment_selector SEGMENT_SELECTOR(.i_digit1(w_digit1),
											.i_digit2(w_digit2),
											.i_digit3(w_digit3),
											.i_refreshCounter(w_refreshCounter),
											.o_digit(w_digit));
	
	seven_segment_driver SEVEN_SEGMENT(.i_digit(w_digit),
												  .o_sevenSegmentLed(w_sevenSegment));
	
endmodule
