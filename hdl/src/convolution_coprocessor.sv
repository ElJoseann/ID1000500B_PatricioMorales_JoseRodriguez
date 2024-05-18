/******************************************************************
* Description
*
* Top design 1D convolution coprocessor with internal signal stored in ROM
*
* Reset: Async active low
*
* Author: Jose Rodriguez
* email : TAE2024.1@cinvestav.mx	
* Date  : 05/02/2024	
******************************************************************/

module ipm_ID1000500B_convolution_coprocessor (
	/********* Ctrl inputs **********/
	input logic  	    clk,
	input logic        rstn,
	/** Convolution coprocessor inputs **/
	input logic  [7:0]  dataY,
	input logic  [4:0]  sizeY,
	input logic 	     start,
	/** Convolution coprocessor outputs */
	output logic [4:0]  memY_addr,
	output logic [15:0] dataZ,
	output logic [5:0]  memZ_addr,
	output logic 		  writeZ,
	output logic 		  busy,
	output logic		  done
);

`define SIZE_MEM_H 5'd5

// Parameter definitios
parameter DATA_WIDTH_MEMH = 8;
parameter ADDR_WIDTH_MEMH = 5;
parameter DATA_WIDTH_MEMZ = 16;
parameter ADDR_WIDTH_MEMZ = 6;
parameter DATA_WIDTH_J = 5;
parameter DATA_WIDTH_I = 6;

// FSM wires 
wire comp_i_out_wire;
wire comp_j_out_wire;
wire comp_indexH_out_wire;
wire sel_j_wire;
wire j_enable_wire;
wire sel_i_wire;
wire i_enable_wire;
wire currentZ_en_wire;
wire cunrrentZ_clr_wire;

// i counter wires
wire [DATA_WIDTH_I-1:0] i_wire;
wire [DATA_WIDTH_I-1:0]   i_adder_wire;
wire [DATA_WIDTH_I-1:0] i_mux_wire;

// j counter wires
wire [DATA_WIDTH_J-1:0] j_wire;
wire [DATA_WIDTH_J-1:0] j_adder_wire;
wire [DATA_WIDTH_J-1:0] j_mux_wire;

// sizeZ wires
wire [DATA_WIDTH_J-1:0] sizeH;
assign sizeH = `SIZE_MEM_H;
wire [DATA_WIDTH_I-1:0]sizeY_plus_sizeH_wire;
wire [DATA_WIDTH_I-1:0]sizeZ_wire;

// sizeZ wires
wire [DATA_WIDTH_I-1:0]i_minus_j_wire;

// indexH wires
wire indexH_less_than_sizeH_wire;
wire indexH_less_than_zero_wire;
wire indexH_greater_or_equal_to_zero_wire;

// MemoryH wires
wire [DATA_WIDTH_MEMH-1:0] dataH;

// currenZ wires
wire [DATA_WIDTH_MEMZ-1:0] dataH_times_dataY_wire;
wire [DATA_WIDTH_MEMZ-1:0] currentZ_sum_wire;

// Optimization elements
// Input memories size comparation
wire size_comp_wire;

// Upper second counter source selection
wire [DATA_WIDTH_J-1:0]size_second_counter;
wire [DATA_WIDTH_J-1:0]memH_addr;

wire [DATA_WIDTH_J-1:0]index_comp_wire;

//****************************************************************
// FSM Instance
//****************************************************************

convolution_coprocessor_fsm FSM(
	.clk(clk),
	.rstn(rstn),
	
	.start(start),
	.comp_i_out(comp_i_out_wire),
	.comp_j_out(comp_j_out_wire),
	.comp_indexH_out(comp_indexH_out_wire),
	
	.sel_j(sel_j_wire),
	.j_enable(j_enable_wire),
	.sel_i(sel_i_wire),
	.i_enable(i_enable_wire),
	.currentZ_en(currentZ_en_wire),
	.cunrrentZ_clr(cunrrentZ_clr_wire),
	
	.writeZ(writeZ),
	.done(done),
	.busy(busy)
);

//****************************************************************
// i counter instances
//****************************************************************

convolution_coprocessor_realAdder 
#(.DATA_WIDTH(DATA_WIDTH_I)) i_adder(
	.re_A(i_wire), 
	.re_B(6'd1),  
	.re_out(i_adder_wire)
);

convolution_coprocessor_mux 
#(.DATA_WIDTH(DATA_WIDTH_I)) i_mux(
	.re_A(i_adder_wire), 
	.re_B(6'd0), 
	.sel(sel_i_wire),
	.re_out(i_mux_wire)
);

convolution_coprocessor_register
#(.DATA_WIDTH(DATA_WIDTH_I)) i_reg(
	.clk(clk),
	.rstn(rstn),
	.clrh(1'b0),
	
	.enh(i_enable_wire),
	
	.data_i(i_mux_wire),
	.data_o(i_wire)
);

//****************************************************************
// j counter instances
//****************************************************************

convolution_coprocessor_realAdder 
#(.DATA_WIDTH(DATA_WIDTH_J)) j_adder(
	.re_A(j_wire), 
	.re_B(5'd1),  
	.re_out(j_adder_wire)
);

convolution_coprocessor_mux 
#(.DATA_WIDTH(DATA_WIDTH_J)) j_mux(
	.re_A(j_adder_wire), 
	.re_B(5'd0), 
	.sel(sel_j_wire),
	.re_out(j_mux_wire)
);

convolution_coprocessor_register
#(.DATA_WIDTH(DATA_WIDTH_J)) j_reg(
	.clk(clk),
	.rstn(rstn),
	.clrh(1'b0),
	
	.enh(j_enable_wire),
	
	.data_i(j_mux_wire),
	.data_o(j_wire)
);

//****************************************************************
// sizeZ calculation instance
//****************************************************************

convolution_coprocessor_realAdder 
#(.DATA_WIDTH(DATA_WIDTH_I)) sizeZ_adder(
	.re_A({1'b0,sizeY}), 
	.re_B({1'b0,sizeH}),  
	.re_out(sizeY_plus_sizeH_wire)
);

convolution_coprocessor_realAdder 
#(.DATA_WIDTH(DATA_WIDTH_I)) sizeZ_substractor(
	.re_A(sizeY_plus_sizeH_wire), 
	.re_B(6'b11_1111), // -1 in two's complement   
	.re_out(sizeZ_wire)
);

//****************************************************************
// (i - j) instance
//****************************************************************

convolution_coprocessor_substractor 
#(.DATA_WIDTH(DATA_WIDTH_I)) i_minus_j(
	.re_A(i_wire), 
	.re_B({1'b0,j_mux_wire}),  
	.re_out(i_minus_j_wire)
);

//****************************************************************
// i comparator Instance
//****************************************************************

convolution_coprocessor_comparatorLessThan
#(.DATA_WIDTH(DATA_WIDTH_I)) i_comp(
	.A_i(i_mux_wire),
	.B_i(sizeZ_wire),
	.A_less_than_B_o(comp_i_out_wire)
);

//****************************************************************
// j comparator Instance
//****************************************************************

convolution_coprocessor_comparatorLessThan
#(.DATA_WIDTH(DATA_WIDTH_J)) j_comp(
	.A_i(j_mux_wire),
	.B_i(size_second_counter),
	.A_less_than_B_o(comp_j_out_wire)
);

//****************************************************************
// comparator indexH Instance
//****************************************************************

convolution_coprocessor_comparatorLessThan
#(.DATA_WIDTH(DATA_WIDTH_I)) indexH_less_than_sizeH(
	.A_i(i_minus_j_wire),
	.B_i({1'b0,index_comp_wire}),
	.A_less_than_B_o(indexH_less_than_sizeH_wire)
);

convolution_coprocessor_comparatorLessThan
#(.DATA_WIDTH(DATA_WIDTH_I)) indexH_less_than_zero(
	.A_i(i_minus_j_wire),
	.B_i(6'd0),
	.A_less_than_B_o(indexH_less_than_zero_wire)
);

convolution_coprocessor_not indexH_greater_or_equal_to_zero(
	.A_i(indexH_less_than_zero_wire),
	.not_A_o(indexH_greater_or_equal_to_zero_wire)
);

convolution_coprocessor_and indexH(
	.A_i(indexH_less_than_sizeH_wire),
	.B_i(indexH_greater_or_equal_to_zero_wire),
	.A_and_B_o(comp_indexH_out_wire)
);

//****************************************************************
// MemoryH Instance
//****************************************************************

convolution_coprocessor_simple_rom_sv
#(.DATA_WIDTH(DATA_WIDTH_MEMH),
  .ADDR_WIDTH(ADDR_WIDTH_MEMH),
  .TXT_FILE("/home/joserodriguez/ID1000500B_PatricioMorales_JoseRodriguez/sw/MemoryH.txt")
) memoryH (
	.clk(clk),
	.read_addr_i(memH_addr),
	.read_data_o(dataH)
);

//****************************************************************
// currentZ Instance
//****************************************************************

convolution_coprocessor_mult
#(.DATA_WIDTH(DATA_WIDTH_MEMH)) currentZ_mult(
	.re_A(dataH), 
	.re_B(dataY),  
	.re_out(dataH_times_dataY_wire)
);

convolution_coprocessor_realAdder
#(.DATA_WIDTH(DATA_WIDTH_MEMZ)) currentZ_sum(
	.re_A(dataH_times_dataY_wire), 
	.re_B(dataZ),  
	.re_out(currentZ_sum_wire)
);

convolution_coprocessor_register
#(.DATA_WIDTH(DATA_WIDTH_MEMZ)) currentZ_reg(
	.clk(clk),
	.rstn(rstn),
	.clrh(cunrrentZ_clr_wire),
	
	.enh(currentZ_en_wire),
	
	.data_i(currentZ_sum_wire),
	.data_o(dataZ)
);

//****************************************************************
// MemoryZ and MemoryY adress conections
//****************************************************************

// assign memY_addr = j_mux_wire;
assign memZ_addr = i_wire;

//****************************************************************
// Optimization intstance
//****************************************************************

// Input memories size comparaation
convolution_coprocessor_comparatorLessThan
#(.DATA_WIDTH(DATA_WIDTH_J)) size_comp(
	.A_i(sizeY),
	.B_i(sizeH),
	.A_less_than_B_o(size_comp_wire)
);

// Upper limit second counter source selection
convolution_coprocessor_mux 
#(.DATA_WIDTH(DATA_WIDTH_J)) upper_limit_mux(
	.re_A(sizeH), 
	.re_B(sizeY), 
	.sel(size_comp_wire),
	.re_out(size_second_counter)
);

// Index comparaation
convolution_coprocessor_mux 
#(.DATA_WIDTH(DATA_WIDTH_J)) index_comp_mux(
	.re_A(sizeH), 
	.re_B(sizeY), 
	.sel(~size_comp_wire),
	.re_out(index_comp_wire)
);

// MemoryY address source selection
convolution_coprocessor_mux 
#(.DATA_WIDTH(DATA_WIDTH_J)) memY_addr_mux(
	.re_A(i_minus_j_wire[4:0]), 
	.re_B(j_mux_wire), 
	.sel(size_comp_wire),
	.re_out(memY_addr)
);

// MemoryH address source selection
convolution_coprocessor_mux 
#(.DATA_WIDTH(DATA_WIDTH_J)) memH_addr_mux(
	.re_A(i_minus_j_wire[4:0]), 
	.re_B(j_mux_wire), 
	.sel(~size_comp_wire),
	.re_out(memH_addr)
);

endmodule 