/********************交通灯(计数器实现）***********************/
module traffic_light (
    input clk,
    input pass_request,
    input rst_n,
    output wire [7:0] clock,
    output reg red,
    output reg yellow,
    output reg green
);
    // 使用 1 个计数器，根据计数值的范围分别表示红、黄、绿
    // 0~9： 红色 10
    // 10~14：黄色 5
    // 15~74：绿色 60
    reg [6:0] count75;
    reg flag;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            count75 <= 'b0;
            flag <= 'b0;
        end
        else begin
            // 有行人按下，则最多倒计时10个时钟周期
            if(pass_request) begin
                if(count75 <= 65) begin
                    count75 <= 65;
                end
                else begin
                    count75 <= count75 + 'b1;
                end
            end
            else begin
                if(flag == 'b0) begin
                    if(count75 == 'd2) begin
                        flag <= 'b1;
                        count75 <= 'b0;
                    end
                    else begin
                        count75 <= count75 + 'b1;
                    end
                end
                else begin
                    if(count75 == 'd74) begin
                        count75 <= 'b0;
                    end
                    else begin
                        count75 <= count75 + 'b1;
                    end
                end
            end
        end
    end

    // 红 黄 绿 三种灯的跳转
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            red <= 1'b0;
            yellow <= 1'b0;
            green <= 1'b0;
        end
        else begin
            if(count75 >= 'd0 && count75 < 'd9 || count75 == 'd74) begin        // red light
                if(flag == 'b0 && count75 != 'd2) begin // 2个时钟的复位释放周期
                    red <= 1'b0;
                end
                else begin
                    red <= 1'b1;
                end
                yellow <= 'b0;
                green <= 'b0;
            end
            else if(count75 >= 'd9 && count75 < 'd14) begin    // yellow light
                red <= 1'b0;
                yellow <= 1'b1;
                green <= 1'b0;
            end
            else if(count75 >= 'd14 && count75 < 'd74) begin  // green light
                red <= 1'b0;
                yellow <= 1'b0;
                green <= 1'b1;
            end
            else begin
                red <= red;
                yellow <= yellow;
                green <= green;
            end
        end
    end
    
    // clock 倒计时 组合逻辑
    reg [7:0] clock_t;
    always @(rst_n, count75, pass_request, flag) begin
        if(~rst_n) begin
            clock_t = 'd10;
        end
        else begin
            if(count75 >= 'd0 && count75 <= 'd9) begin // red light count down:10 9 8 ... 1
                clock_t = 'd10 - count75;
            end
            else if(count75 >= 'd10 && count75 <='d14) begin // yellow light count down : 5 4 3 2 1
                clock_t = 'd15 - count75; 
            end
            else if(count75 >= 'd15 && count75 <= 'd74) begin // green light count down : 60 59 ... 1
                clock_t = 'd75 - count75;
            end
            else begin
                clock_t = clock_t;
            end
        end
    end

    assign clock = clock_t;

endmodule