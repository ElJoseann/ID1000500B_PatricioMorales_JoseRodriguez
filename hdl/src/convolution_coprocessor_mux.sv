/******************************************************************
* Description
*
* 2 to 1 Mux with parametetized WIDTH
*
* Author: Jose Rodriguez
* email : TAE2024.1@cinvestav.mx	
* Date  : 05/02/2024	
******************************************************************/

module convolution_coprocessor_mux 
#(
	parameter DATA_WIDTH = 6)
(
	input  [DATA_WIDTH-1: 0] re_A,
	input  [DATA_WIDTH-1: 0] re_B,
	input 					 sel,
	output [DATA_WIDTH-1: 0] re_out
);

	reg signed [DATA_WIDTH -1: 0] temp_RA;
	reg signed [DATA_WIDTH -1: 0] temp_RB;
	
	wire signed [DATA_WIDTH-1: 0] temp_RE;
	
	always@(re_A, re_B)
	begin
		temp_RA = re_A;
		temp_RB = re_B;
	end 
	
	assign temp_RE = (sel) ? temp_RB : temp_RA;
	
	assign re_out = temp_RE;
	
endmodule 