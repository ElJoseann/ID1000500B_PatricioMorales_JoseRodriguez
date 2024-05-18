/******************************************************************
* Description
*
* NOT gate
*
*   
*
* Author:
* email :	TAE2024.1@cinvestav.mx
* Date  :	05/07/2020
******************************************************************/


module convolution_coprocessor_not
(
		input  logic A_i,	
		output logic not_A_o   
);

assign not_A_o = !A_i;

endmodule