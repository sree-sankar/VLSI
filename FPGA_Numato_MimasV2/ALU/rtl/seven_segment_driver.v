`timescale 1ns / 1ps


  //       a    
  //      ____
  //   f |    | b
  //     |_g__| 
  //   e |    | c
  //     |____| . h
  //       d
  //	                          .
  module seven_segment_driver(input  [3:0] i_digit,
									   output [7:0] o_sevenSegmentLed );
     
  reg [7:0] r_sevenSegmentLed;			
		
  assign o_sevenSegmentLed = r_sevenSegmentLed;
										 
  always @(i_digit)
  begin
	case(i_digit)
			  0 : r_sevenSegmentLed <= 8'b0000_0011; 
			  1 : r_sevenSegmentLed <= 8'b1001_1111;
			  2 : r_sevenSegmentLed <= 8'b0010_0101;
			  3 : r_sevenSegmentLed <= 8'b0000_1101;
			  4 : r_sevenSegmentLed <= 8'b1001_1001;
			  5 : r_sevenSegmentLed <= 8'b0100_1001;
			  6 : r_sevenSegmentLed <= 8'b0100_0001;
			  7 : r_sevenSegmentLed <= 8'b0001_1111;
			  8 : r_sevenSegmentLed <= 8'b0000_0001;
			  9 : r_sevenSegmentLed <= 8'b0001_1001;
	  default : r_sevenSegmentLed <= 8'b1111_1111;
	endcase
  end
endmodule