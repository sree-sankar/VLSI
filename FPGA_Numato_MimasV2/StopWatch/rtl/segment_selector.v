`timescale 1ns / 1ps


module segment_selector(input  [3:0] i_digit1,i_digit2,i_digit3,
					  input  [1:0] i_refreshCounter,
					  output [3:0] o_digit);
							 
	reg [3:0] r_digit;				 
						 
	assign o_digit = r_digit; 
	
	always @(i_refreshCounter)
	begin
		case(i_refreshCounter)
			0 : r_digit <= i_digit1;
			1 : r_digit <= i_digit2;
			2 : r_digit <= i_digit3;
		endcase
	end
endmodule
