/****************synchronous fifo**************/

/************dual port ram*******************/
module dual_port_ram #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
) (
    input wclk,
    input rclk,
    input [WIDTH-1 : 0] wdata,
    input [$clog2(DEPTH)-1 : 0] waddr,
    input [$clog2(DEPTH)-1 : 0] raddr,
    input wenc,
    input renc,
    output [WIDTH-1 : 0] rdata
);

    reg [WIDTH-1 : 0] ram_mem [0:DEPTH-1];

    always @(posedge wclk) begin
        if(wenc) begin
            ram_mem[waddr] <= wdata;
        end
    end

    always @(posedge rclk) begin
        if(renc) begin
            rdata <= ram_mem[raddr];
        end
    end
    
endmodule


/**************synchronous fifo logic design*****************/
module sfifo #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
) (
    input clk,
    input rst_n,
    input winc,
    input rinc,
    input [WIDTH-1:0] wdata,
    output wire [WIDTH-1:0] rdata,
    output reg wfull,
    output reg rempty
);
    localparam ADDR_WIDTH = $clog2(DEPTH);

    reg [ADDR_WIDTH:0] waddr, raddr;

    // read logic
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            raddr <= 'b0;
        end
        else begin
            if(rinc && ~rempty) begin
                raddr <= raddr + 'b1;
            end
            else begin
                raddr <= raddr;
            end
        end
    end

    // write logic
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            waddr <= 'b0;
        end
        else begin
            if(winc && ~wfull) begin
                waddr <= waddr + 'b1;
            end
            else begin
                waddr <= waddr;
            end
        end
    end

    // wfull and rempty logic
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            wfull <= 'b0;
            rempty <= 'b0;
        end
        else begin
            wfull = (waddr[ADDR_WIDTH] ^ raddr[ADDR_WIDTH]) && (waddr[ADDR_WIDTH-1:0] == raddr[ADDR_WIDTH-1:0]);
            rempty = (waddr == raddr);
        end
    end
    
    dual_port_ram #(.DEPTH(DEPTH), .WIDTH(WIDTH)) sram(
        .wclk(clk), .rclk(clk), .wenc(winc && ~wfull), .renc(rinc && ~rempty), .rdata(rdata), 
        .wdata(wdata), .waddr(waddr[ADDR_WIDTH-1:0]),  .raddr(raddr[ADDR_WIDTH-1:0]));
endmodule