// 手撕代码题 4 ：检测序列10110，要求每检测到一次该序列输出两个周期的高电平信号，采用低功耗的方式

module seq_check (
    input clk,
    input rst_n,
    input din,
    output reg result
);
    localparam S0 = 5'b00000;
    localparam S1 = 5'b00001;
    localparam S2 = 5'b00010;
    localparam S3 = 5'b00100;
    localparam S4 = 5'b01000;
    localparam S5 = 5'b10000;

    reg [4:0] cur_sta, next_sta;

    // 状态转移
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cur_sta <= 'b0;
        else begin
            cur_sta <= next_sta;
        end
    end

    always @(*) begin
        case (cur_sta)
            S0: next_sta = din ? S1 : S0;
            S1: next_sta = din ? S1 : S2;
            S2: next_sta = din ? S3 : S0;
            S3: next_sta = din ? S4 : S2;
            S4: next_sta = din ? S1 : S5;
            S5: next_sta = din ? S3 : S0;
            default: next_sta = S0;
        endcase
    end

    // reg result_r;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            result <= 'b0;
        end
        else begin
            result <= (cur_sta == S5) ? 1'b1 : 1'b0;
            repeat(1) @(posedge clk);
        end
    end
endmodule