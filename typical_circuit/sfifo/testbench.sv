`timescale  1ns/1ps
module sync_fifo_tb;

  // Parameters
  parameter WIDTH = 8;
  parameter DEPTH = 16;

  // Inputs
  reg clk;
  reg rstn;
  reg wr_en;
  reg rd_en;

  // Outputs
  reg [WIDTH-1:0] wr_data;
  reg [WIDTH-1:0] rd_data;
  wire full;
  wire empty;
//   wire [DEPTH-1:0] occupancy;

  // Instantiate the DUT
  sfifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifo (
    .clk(clk),
    .rst_n(rstn),
    .winc(wr_en),
    .rinc(rd_en),
    .wdata(wr_data),
    .wfull(full),
    .rempty(empty),
    .rdata(rd_data)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initialize inputs
  initial begin
    clk = 0;
    rstn = 0;
    wr_en = 0;
    rd_en = 0;
    wr_data = 0;
    rd_data = 0;
    #10 rstn = 1;
  end

  // Write test
  integer i;
  initial begin
    for (i = 0; i < DEPTH; i++) begin
      wr_en = 1;
      wr_data = i;
      #5;
    end
    wr_en = 0;
  end

  // Read test
  integer j;
  initial begin
    #50;
    for (j = 0; j < DEPTH; j++) begin
      rd_en = 1;
      #5;
      if (!empty) begin
        $display("Read data: %d", rd_data);
      end
    end
    rd_en = 0;
  end

  // Full test
  initial begin
    wr_en = 1;
    wr_data = DEPTH + 1;
    #5;
    if (full) begin
      $display("FIFO is full");
    end
    wr_en = 0;
  end

  // Empty test
  initial begin
    rd_en = 1;
    // #105;
    if (empty) begin
      $display("FIFO is empty");
    end
    rd_en = 0;
  end

endmodule