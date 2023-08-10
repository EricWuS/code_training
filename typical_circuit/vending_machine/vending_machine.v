/**************vending machine**************/
`timescale 1ns/1ns
module vending_machi (
    input wire clk,
    input wire rst,
    input wire d1,   // 0.5 元
    input wire d2,   // 1元
    input wire d3,   // 2元
    output reg out1, // 饮料买到没有
    output reg [1:0] out2  // 找零 只找0.5元面额的
);

    parameter IDLE = 2'b00;   // 付款后剩余钱数 0
    parameter S0 = 2'b01;     // 付款后剩余钱数 0.5
    parameter S1 = 2'b10;     // 付款后剩余钱数 1

    reg [1:0] cur_sta, next_sta;
    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            cur_sta <= IDLE;
        end
        else begin
            cur_sta <= next_sta;
        end
    end
    
    // 状态转移条件
    always @(d1, d2, d3, rst) begin
        if(~rst) begin
            next_sta = IDLE;
        end
        else begin
            case(cur_sta)
                IDLE: begin
                    case ({d1, d2, d3})
                        3'b000: next_sta = next_sta;
                        3'b100: next_sta = S0;
                        3'b010: next_sta = S1;
                        3'b001: next_sta = IDLE;
                        default: next_sta = IDLE;
                    endcase
                end
                S0: begin
                    case ({d1, d2, d3})
                        3'b000: next_sta = next_sta;
                        3'b100: next_sta = S1;
                        3'b010: next_sta = IDLE;
                        3'b001: next_sta = IDLE;
                        default: next_sta = IDLE;
                    endcase
                end
                S1: begin
                    case ({d1, d2, d3})
                        3'b000: next_sta = next_sta;
                        3'b100: next_sta = IDLE;
                        3'b010: next_sta = IDLE;
                        3'b001: next_sta = IDLE;
                        default: next_sta = IDLE;
                    endcase
                end
                default: next_sta = ({d1, d2, d3} == 3'b000) ? next_sta : IDLE;
            endcase
        end
    end

    // 输出逻辑
    reg out1_t;
    reg [1:0] out2_t;

    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            out1_t <= 'b0;
            out2_t <= 'b0;
        end
        else begin
            case(cur_sta)
                IDLE: begin
                    out1_t <= ({d1, d2, d3} == 3'b001) ? 1'b1 : 1'b0;
                    out2_2 <= ({d1, d2, d3} == 3'b001) ? 2'b01 : 2'b00; 
                end
                S0: begin
                    out1_t <= (({d1, d2, d3} == 3'b010) || ({d1, d2, d3} == 3'b001)) ? 1'b1 : 1'b0;
                    out2_t <= ({d1, d2, d3} == 3'b010) ? 2'b00 : (({d1, d2, d3} == 3'b001) ? 2'b10 : 2'b00);
                end
                S1: begin
                    out1_t <= ({d1, d2, d3} == 3'b000) ? 1'b0 : 1'b1;
                    out2_t <= ({d1, d2, d3} == 3'b100) ? 2'b00 : (({d1, d2, d3} == 3'b010) ? 2'b01 : (({d1 ,d2, d3} == 3'b001) ? 2'b11 : 2'b00));
                end
                default: begin
                    out1_t <= 1'b0;
                    out2_t <= 2'b00;
                end
            endcase
        end
    end

    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            out1 <= 'b0;
            out2 <= 'b0;
        end
        else begin
            out1 <= out1_t;
            out2 <= out2_t;
        end
    end

endmodule