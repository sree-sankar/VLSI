`timescale 1ns / 1ps

module bin2bcd( input i_clk,i_rst,
					input [7:0] i_Binary,
					output[3:0] o_Ones,o_Tens,o_Hundreds);


		reg [3:0]  r_Ones,r_Tens,r_Hundreds;
		reg [3:0]  r_temp_Ones,r_temp_Tens,r_temp_Hundreds;

		reg [3:0]  r_counter = 0;
		reg [19:0] r_shift_Register;
		reg [7:0]  r_temp_Val = 0;
		
		assign o_Ones = r_Ones;
		assign o_Tens = r_Tens;
		assign o_Hundreds = r_Hundreds;


		always @(posedge i_clk or negedge i_rst)begin
			if(!i_rst) begin
				r_shift_Register = 19'b0;
				r_counter 		  = 0;
				r_temp_Val 		  = 0;
				r_temp_Ones		  = 0;
				r_temp_Tens		  = 0;
				r_temp_Hundreds  = 0;
			end
			else begin
				if(r_counter == 0 && (r_temp_Val != i_Binary)) begin
					r_shift_Register      = 19'b0;
					r_temp_Val		  		 = i_Binary;
					r_shift_Register[7:0] = i_Binary;
					r_temp_Ones				 = r_shift_Register[11:8];
					r_temp_Tens				 = r_shift_Register[15:12];
					r_temp_Hundreds		 = r_shift_Register[19:16];
					r_counter				 = r_counter + 1;
				end
				if (r_counter < 9 && r_counter > 0) begin
					if(r_temp_Ones >=5) r_temp_Ones = r_temp_Ones + 3;
					if(r_temp_Tens >=5) r_temp_Tens = r_temp_Tens + 3;
					if(r_temp_Hundreds >=5) r_temp_Hundreds = r_temp_Hundreds + 3;
					r_shift_Register[19:8] ={r_temp_Hundreds,r_temp_Tens,r_temp_Ones};
					r_shift_Register = r_shift_Register<<1;
					
					r_temp_Ones			 = r_shift_Register[11:8];
					r_temp_Tens			= r_shift_Register[15:12];
					r_temp_Hundreds		 = r_shift_Register[19:16];
					
					r_counter = r_counter + 1;
				end
				if (r_counter == 9) begin 
					r_counter = 0;
					r_Ones = r_temp_Ones;
					r_Tens = r_temp_Tens;
					r_Hundreds = r_temp_Hundreds;
				end
			end
		end
endmodule