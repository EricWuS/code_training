`timescale 1ns/1ps

module edge_detect_tb;

    parameter PERIOD = 10;

    reg clk;
    reg reset;
    reg data_in;
    wire pos_edge;
    wire neg_edge;
    wire bi_edge;

    edge_detect dut(
        .clk(clk),
        .rst_n(reset),
        .din(data_in),
        .pos_edge(pos_edge),
        .neg_edge(neg_edge),
        .bi_edge(bi_edge)
    ); 

    always #(PERIOD/2) clk = ~clk;


    // 仿真初始化
    initial begin
        clk = 1;
        reset = 1;
        data_in = 0;
        #((PERIOD)*2) reset = 0; // 复位持续2个时钟周期
        #((PERIOD)*2) reset = 1; // 失能复位持续2个时钟周期
        #((PERIOD)*2) data_in = 1; // 模拟输入
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0; // 输入完毕
        #((PERIOD)*3) $finish; // 仿真结束
    end
    
endmodule