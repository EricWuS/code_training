`timescale 1ns/1ps
module seq_check_tb;

    // 参数
    parameter PERIOD = 10; // 时钟周期为10个时间单位

    // 信号
    reg clk;           // 仿真时钟信号
    reg reset;         // 复位信号
    reg data_in;       // 输入数据信号
    wire out_signal;   // 输出信号

    // DUT (Design Under Test) 实例化
    seq_check dut (
        .clk(clk),
        .rst_n(reset),
        .din(data_in),
        .result(out_signal)
    );

    // 时钟生成
    always #((PERIOD)/2) clk = ~clk;

    // 仿真初始化
    initial begin
        clk = 1;
        reset = 1;
        data_in = 0;
        #((PERIOD)*2) reset = 0; // 复位持续2个时钟周期
        #((PERIOD)*2) reset = 1; // 失能复位持续2个时钟周期
        #((PERIOD)*2) data_in = 1; // 模拟输入10110序列
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 1;
        #(PERIOD) data_in = 0;
        #(PERIOD) data_in = 0; // 输入完毕，应检测到10110序列
        #((PERIOD)*3) $finish; // 仿真结束
    end

    // 打印输出信号的变化
    // always @(posedge clk)
    //     $display("Time: %0t, Data_in: %b, Out_signal: %b", $time, data_in, out_signal);

endmodule
