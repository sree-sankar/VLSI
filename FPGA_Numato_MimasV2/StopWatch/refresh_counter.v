`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:13 05/01/2021 
// Design Name: 
// Module Name:    refresh_counter 
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
module refresh_counter(input i_refresh_clk,
							  input i_rst,
							  output [1:0] o_refreshCounter);

	reg [1:0] r_ref_count;
	
	assign o_refreshCounter = r_ref_count;
	
	always @(posedge i_refresh_clk) 
	begin
	if(!i_rst)
		r_ref_count <= 0;
	else
		r_ref_count <= r_ref_count + 1;
		if(r_ref_count >= 2)
			r_ref_count <= 0;
	end

endmodule
