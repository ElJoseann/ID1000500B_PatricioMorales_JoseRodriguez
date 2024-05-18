/******************************************************************
* Description
*
* FSM for 1D convolution coprocessor 
*
* Reset: Async active low
*
* Author: Jose Rodriguez
* email : TAE2024.1@cinvestav.mx	
* Date  : 05/01/2024	
******************************************************************/

module convolution_coprocessor_fsm (
	/******* Ctrl FSM inputs ********/
	input logic  clk,
	input logic  rstn,
	/****** Flow ctrl FSM inputs ****/
	input logic  start,
	input logic  comp_i_out,
	input logic  comp_j_out,
	input logic  comp_indexH_out,
	/*********** FSM output *********/
	output logic sel_j,
	output logic j_enable,
	output logic sel_i,
	output logic i_enable,
	output logic currentZ_en,
	output logic cunrrentZ_clr,
	output logic writeZ,
	output logic done,
	output logic busy
);

// State definition
typedef enum logic [3:0] {S1, S2, S4, S6, S7, S8, S10, S11, S13, XX = 'x} state_t;

// typed definitions
state_t state;
state_t next;

// (1) State register (sequential side)
always_ff@(posedge clk or negedge rstn)
	if(!rstn) state <= S1;
	else state <= next;

// (2) Combinational next state logic
always_comb begin 
	next = XX;
	unique case(state)
		S1: if(start) next = S2;
			else next = S1;
		S2: if(comp_i_out) next = S4;
			else next = S11;
		S4: begin
			if(!comp_j_out) next = S8;
			else begin
				if(comp_indexH_out) next = S6;
				else next = S7;
			end
		end
		S6: next = S7;
		S7: begin 
			if(!comp_j_out) next = S8;
			else begin
				if (comp_indexH_out) next = S6;
				else next = S7;
			end
		end
		S8: next = S10;
		S10: if (comp_i_out) next = S4;
			 else next = S11;
		S11: next = S13;
		S13: if(start) next = S13;
			  else next = S1;
		default: next = XX;
	endcase 
end

// (3) Registered output logic
always_ff@(posedge clk or negedge rstn) begin 
	if(!rstn) begin
		busy <= 1'b0;
		sel_j <= 1'b0;
		j_enable <= 1'b0; 
		sel_i <= 1'b0;
		i_enable <= 1'b0;
		currentZ_en <= 1'b0;
		cunrrentZ_clr <= 1'b0;
		writeZ <= 1'b0;
		done <= 1'b0;
	end
	else begin 
		// Default values
		sel_j <= 1'b0;
		j_enable <= 1'b0; 
		sel_i <= 1'b0;
		i_enable <= 1'b0;
		currentZ_en <= 1'b0;
		cunrrentZ_clr <= 1'b0;
		writeZ <= 1'b0;
		done <= 1'b0;
		busy <= 1'b1;
		unique case(next)
			S1:		busy <= 1'b0;
			S2: begin 
					sel_i <= 1'b1;
					i_enable <= 1'b1;
				end
			S4: begin 
					cunrrentZ_clr <= 1'b1;
					sel_j <= 1'b1;
					j_enable <= 1'b1;
				end 
			S6: 	currentZ_en <= 1'b1;
			S7: 	j_enable <= 1'b1;
			S8: 	writeZ <= 1'b1;
			S10:  i_enable <= 1'b1;
			S11: begin 
					busy <= 0;
					done <= 1;
				 end
			S13: 	busy <= 0;
		endcase
	end 
end

endmodule 