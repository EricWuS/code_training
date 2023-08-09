`timescale 1ns/1ps // 设置时间刻度

module testbench;

    // 输入信号
    reg [1:0] A, B;
    reg cin;

    // 输出信号
    wire [1:0] S;
    wire cout;

    // DUT (Design Under Test)
    adder dut(
        .A(A),  // 第一位输入
        .B(B), // 第二位输入
        .cin(cin), // 进位输入
        .S(S),     // 各位和输出
        .cout(cout) // 进位输出
    );
    // 时钟信号
    reg clk = 0;

    // 定义时钟周期
    parameter CYCLE_DELAY = 10; // 假设一个周期为10个时间单位

    always #(CYCLE_DELAY/2) clk = ~clk; // 时钟周期取反

    // 初始化输入信号
    initial begin
        A = 2'b10;
        B = 2'b11;
        cin = 1; // 设置进位输入

        // 持续模拟输入信号
        repeat(5) begin
            #CYCLE_DELAY A = ~A; // 第一位输入取反
            #CYCLE_DELAY B = ~B; // 第二位输入取反
        end

        // 结束仿真
        $finish;
    end

    // 监视输出信号
    always @(posedge clk) begin
        $display("A=%b, B=%b, cin=%b, S=%b, cout=%b", A, B, cin, S, cout);
    end
endmodule
