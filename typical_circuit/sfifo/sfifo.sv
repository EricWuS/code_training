`timescale 1ns/1ns
/**********************************RAM************************************/
module dual_port_RAM #(parameter DEPTH = 16,
					   parameter WIDTH = 8)(
	 input wclk
	,input wenc
	,input [$clog2(DEPTH)-1:0] waddr  //深度对2取对数，得到地址的位宽。
	,input [WIDTH-1:0] wdata      	//数据写入
	,input rclk
	,input renc
	,input [$clog2(DEPTH)-1:0] raddr  //深度对2取对数，得到地址的位宽。
	,output reg [WIDTH-1:0] rdata 		//数据输出
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
	if(wenc)
		RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) begin
	if(renc)
		rdata <= RAM_MEM[raddr];
end 

endmodule  

/**********************************SFIFO************************************/
module sfifo#(
	parameter	WIDTH = 8,
	parameter 	DEPTH = 16
)(
	input 					clk		, 
	input 					rst_n	,
	input 					winc	,
	input 			 		rinc	,
	input 		[WIDTH-1:0]	wdata	,

	output reg				wfull	,
	output reg				rempty	,
	output wire [WIDTH-1:0]	rdata
);

localparam ADDR_WIDTH = $clog2(DEPTH);

reg [ADDR_WIDTH : 0] waddr;
reg [ADDR_WIDTH : 0] raddr;

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		raddr <= 'b0;
	end
	else begin
		if(rinc && ~rempty) begin
			raddr <= raddr + 1'b1;
		end
		else begin
			raddr <= raddr;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		waddr <= 'b0;
	end
	else begin
		if(winc && ~wfull) begin
			waddr <= waddr + 1'b1;
		end
		else begin
			waddr <= waddr;
		end
	end
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		wfull <= 'b0;
		rempty <= 'b0;
	end
	else begin
		wfull <= (raddr == {~waddr[ADDR_WIDTH], waddr[ADDR_WIDTH-1 : 0]});
		rempty <= (raddr == waddr);
	end
end

dual_port_RAM #(.DEPTH(DEPTH), .WIDTH(WIDTH)) sfifo_inst(
	.wclk(clk), .wenc(winc && ~wfull), .waddr(waddr[ADDR_WIDTH-1 : 0]), .wdata(wdata),
	.rclk(clk), .renc(rinc && ~rempty), .raddr(raddr[ADDR_WIDTH-1 : 0]), .rdata(rdata) 
);




endmodule