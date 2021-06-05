`timescale 1ns / 1ps

module timer(input i_clk,
				 input i_rst,
				 input i_startStop,
				 output [3:0] o_digit1,
				 output [3:0] o_digit2,
				 output [3:0] o_digit3);
	
	localparam START = 1'b0;
	localparam STOP  = 1'b1;

	reg r_startStopPrev;
	reg r_currentState;
	reg [3:0] r_counter1;
	reg [3:0] r_counter2;
	reg [3:0] r_counter3;

	assign o_digit1 = r_counter1;
	assign o_digit2 = r_counter2;
	assign o_digit3 = r_counter3;
	
	always @(posedge i_clk or negedge i_rst) 
	begin
		if(!i_rst)begin
			r_currentState	 <= 0;
			r_startStopPrev <= 1;
		end
		else begin
			r_startStopPrev <= i_startStop;
			if(i_startStop && !r_startStopPrev) r_currentState <=  ~r_currentState;
		end
	end
	
	always @(posedge i_clk or negedge i_rst)
	begin
		if(!i_rst)begin
			r_counter1 <= 4'b0000;
			r_counter2 <= 4'b0000;
			r_counter3 <= 4'b0000;
		end
		else begin
			case(r_currentState)
			START : begin
					  r_counter1 <= r_counter1 + 1;
						if(r_counter3 >= 4'b1001 && r_counter2 >= 4'b0101 && r_counter1 >= 4'b1001)begin
							r_counter1 <= 4'b0000;
							r_counter2 <= 4'b0000;
							r_counter3 <= 4'b0000;
						end	 
						
						else if(r_counter2 >= 4'b0101 && r_counter1 >= 4'b1001)begin
							r_counter1 <= 4'b0000;
							r_counter2 <= 4'b0000;
							r_counter3 <= r_counter3 + 1;
						end
							
						else if(r_counter1 >= 4'b1001)begin
							r_counter1 <= 4'b0000;
							r_counter2 <= r_counter2 + 1;
						end
						end
			STOP : begin
					 r_counter1 <= r_counter1;
					 r_counter2 <= r_counter2;
					 r_counter3 <= r_counter3;
					 end
			endcase
		end
    end
endmodule
