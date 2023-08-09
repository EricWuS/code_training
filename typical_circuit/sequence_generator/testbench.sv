`timescale 1ns/1ns

module seq_tb;
    reg clk;
    reg rst_n;
    wire seq;

    initial begin
        clk = 0;
        rst_n = 0;
        #10 rst_n = 1;
    end
    
    // clock generation
    initial begin 
        clk <= 0;
        forever begin
        #5 clk <= !clk;
        end
    end
    
    seq u_seq(
    .clk(clk),
    .rst_n(rst_n),
    .seq(seq)
    );

endmodule