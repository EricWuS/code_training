`timescale 1ns / 1ns
//////////////////////////////////////
// 作者: FPGA探索者，FPGA_Explorer
//////////////////////////////////////
module triffic_light_tb;
    reg rst_n; //异位复位信号，低电平有效
    reg clk; //时钟信号
    reg pass_request;

    wire [7:0]clock;
    wire red;
    wire yellow;
    wire green;

    initial begin
        clk = 0;
        rst_n = 0;
        pass_request = 0;
        #15;
        rst_n = 1;
        #1000;
        pass_request = 1;
        #10;
        pass_request = 0;
        #500;
        $stop;
    end
    
    always #5 clk = ~clk;
    
    traffic_light triffic_light_U0(
        .rst_n(rst_n), //异位复位信号，低电平有效
        .clk(clk), //时钟信号
        .pass_request(pass_request),
        .clock(clock),
        .red(red),
        .yellow(yellow),
        .green(green)
    );
endmodule