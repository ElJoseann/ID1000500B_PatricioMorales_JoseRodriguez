/*
Description: AIP interface	(between aip and coprocessor)
*/

module ID1000500B_convolution_coprocessor
(
    clk,
    rst_a,
    en_s,
    data_in, //different data in information types
    data_out, //different data out information types
    write, //Used for protocol to write different information types
    read, //Used for protocol to read different information types
    start, //Used to start the IP-core
    conf_dbus, //Used for protocol to determine different actions types
    int_req //Interruption request
);

    localparam DATA_WIDTH = 'd32; //define data length
    localparam MEM_ADDR_MAX_WIDTH = 'd16;
    localparam ADDR_WIDTH_MEMI = 'd5; //define Memory In depth
    localparam ADDR_WIDTH_MEMO = 'd6; //define Memory Out depth
    localparam SIZE_CR = 'd1; //define Configuration Register depth
    localparam STATUS_WIDTH = 'd8; //define status length
    localparam INT_WIDTH = 'd8; //define status length

    input wire clk;
    input wire rst_a;
    input wire en_s;
    input wire [DATA_WIDTH-1:0] data_in; //different data in information types
    output wire [DATA_WIDTH-1:0] data_out; //different data out information types
    input wire write; //Used for protocol to write different information types
    input wire read; //Used for protocol to read different information types
    input wire start; //Used to start the IP-core
    input wire [4:0] conf_dbus; //Used for protocol to determine different actions types
    output wire int_req; //Interruption request

    wire [DATA_WIDTH-1:0] data_MemIn0; //data readed for memory in 0
    wire [MEM_ADDR_MAX_WIDTH-1:0] rd_addr_MemIn0; //address read for memory in 0

    wire [DATA_WIDTH-1:0] data_ConfigReg; //data readed for configuration register

    wire [DATA_WIDTH-1:0] data_MemOut0; //data to write for memory out 0
    wire [MEM_ADDR_MAX_WIDTH-1:0] wr_addr_MemOut0; //address write for memory out 0
    wire wr_en_MemOut0; //enable write for memory out 0

    wire start_IPcore; //Used to start the IP-core

    wire [STATUS_WIDTH-1:0] status_IPcore; //data of IP-core to set the flags value
    wire [INT_WIDTH-1:0] int_IPcore;

    ID1000500B_aip
    INTERFACE
    (
        .clk (clk),
        .rst (rst_a),
        .en (en_s),

        .dataInAIP (data_in),
        .dataOutAIP (data_out),
        .configAIP (conf_dbus),
        .readAIP (read),
        .writeAIP (write),
        .startAIP (start),
        .intAIP (int_req),

        .rdDataMemIn_0 (data_MemIn0),
        .rdAddrMemIn_0 (rd_addr_MemIn0),

        .wrDataMemOut_0 (data_MemOut0),
        .wrAddrMemOut_0 (wr_addr_MemOut0),
        .wrEnMemOut_0 (wr_en_MemOut0),

        .rdDataConfigReg (data_ConfigReg),

        .statusIPcore_Busy (status_IPcore[0]),
        .intIPCore_Done (int_IPcore[0]),

        .startIPcore (start_IPcore)
    );

    ID1000500B_convolution_coprocessor_core
    CORE
    (
        .clk (clk),
        .rstn (rst_a),
        //.en_s (en_s),
		  
		  .dataY(data_MemIn0[7:0]),
		  .sizeY(data_ConfigReg[4:0]),
		  .start(start_IPcore),
		  
		  .memY_addr(rd_addr_MemIn0[ADDR_WIDTH_MEMI-1:0]),
		  
		  .dataZ(data_MemOut0[15:0]),
		  .memZ_addr(wr_addr_MemOut0[ADDR_WIDTH_MEMO-1:0]),
		  .writeZ(wr_en_MemOut0),
		  .busy(status_IPcore[0]),
		  .done(int_IPcore[0])
		  
    );

endmodule