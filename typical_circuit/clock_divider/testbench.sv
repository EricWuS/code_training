`timescale 1ns/1ns
module tb;
    logic clk;
    logic rst_n;
    //logic even_out;
    logic odd_out;

    clock_divider dut(
        .clk(clk),
        .rst_n(rst_n),
        // .divider(divider),
        // .even_divider_4(even_out),
        .odd_divider_3(odd_out)
    );
    
    // clock generator
    initial begin 
        clk <= 0;
        forever begin
        #5 clk <= !clk;
        end
    end

    // reset trigger
    initial begin 
        #10 rst_n <= 0;
        repeat(10) @(posedge clk);
        rst_n <= 1;
    end
endmodule