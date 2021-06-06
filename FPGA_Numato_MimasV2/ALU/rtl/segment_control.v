`timescale 1ns / 1ps


module segment_control(input [1:0] i_refresh_counter,
							  output reg [2:0] o_segmentEnable);
	 	
	always @(i_refresh_counter)
	begin
		case(i_refresh_counter)
			2'b00 : o_segmentEnable <= 3'b110;
			2'b01 : o_segmentEnable <= 3'b101;
			2'b10 : o_segmentEnable <= 3'b011;
		 default : o_segmentEnable <= 3'b111;		 
		endcase
	end
endmodule
