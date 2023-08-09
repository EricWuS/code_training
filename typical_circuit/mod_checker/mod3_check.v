module mod3_check (
    input clk,
    input rst_n,
    input din,
    output flag_y
);

localparam IDLE = 2'b00;
localparam S0   = 2'b01;
localparam S1   = 2'b10;
localparam S2   = 2'b11;

reg [1:0] cur_sta, next_sta;
// reg flag_y_r;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        cur_sta <= IDLE;
    end
    else begin
        cur_sta <= next_sta;
    end
end

always @(*) begin
    case (cur_sta)
        IDLE: next_sta = din ? S1 : S0;
        S0  : next_sta = din ? S1 : S0;
        S1  : next_sta = din ? S0 : S2;
        S2  : next_sta = din ? S2 : S1;
        default: next_sta = IDLE;
    endcase
end

assign flag_y = (cur_sta == S0) ? 1'b1 : 1'b0; // 不打拍实现

// 打一拍时序实现
// always @(posedge clk or negedge rst_n) begin
//     if(!rst_n) begin
//         flag_y_r <= 1'b0;
//     end
//     else begin
//         flag_y_r <= (cur_sta == S0) ? 1'b1 : 1'b0;
//     end
// end

// assign flag_y = flag_y_r;
    
endmodule