`timescale 1ns / 1ps


module clock_divider #(parameter FREQ = 1,
							  parameter DEFAULT_CLK = 100000000
							  )(input i_clk,
								 input i_rst,
								 output o_clk);
    reg r_clk;
    integer r_counter;
    
    assign o_clk = r_clk;
    
    always @(posedge i_clk or negedge i_rst)
    begin
		if(!i_rst) begin
			  r_counter <= 0;
			  r_clk <= 0;
		 end
		 else begin
			r_counter <= r_counter + 1;
			if(r_counter >= ((DEFAULT_CLK/(2*FREQ))-1)) // default clk of device divided by 2 * Required frequency - 1 
			begin
				r_counter <= 0;
				r_clk <= ~r_clk;
			end
		end
   end  
endmodule
