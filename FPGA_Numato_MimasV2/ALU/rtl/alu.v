`timescale 1ns / 1ps

module alu( input [7:0] i_A,i_B,
				input i_Sub,i_Mult,i_And,i_Or,i_Compare,
				output reg [7:0] o_result);

	always @(*)
	begin
		if(!i_Sub)  	  		o_result <= (i_A > i_B) ? i_A - i_B : i_B - i_A ;
		else if(!i_Mult) 		o_result <= i_A * i_B;
		else if(!i_And)  		o_result <= i_A & i_B;
		else if(!i_Or)   		o_result <= i_A | i_B;
		else if(!i_Compare)  o_result <= (i_A == i_B) ? 8'b1 : 8'b0;
		else 						o_result <= i_A + i_B;
	end
	
endmodule
