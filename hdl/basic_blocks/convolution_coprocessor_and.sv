/******************************************************************
* Description
*
* AND gate
*
*   
*
* Author:
* email :	TAE2024.1@cinvestav.mx
* Date  :	05/07/2020
******************************************************************/


module convolution_coprocessor_and
(
		input  logic A_i,		
		input  logic B_i,
		output logic A_and_B_o	   
);

assign A_and_B_o = A_i & B_i;

endmodule