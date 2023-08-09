`timescale 1ns/1ns

module clock_divider (
    input clk,
    // input divider,
    input rst_n,
    output logic even_divider_4,
    output logic odd_divider_3
);
    // define a counter used for even divider
    logic [1:0] count;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            count <= 2'b0;
        end
        else begin
            if(count == 2'b11) begin
                count <= 2'b00;
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end

    // even divider and divider = 4
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            even_divider_4 <= 1'b0;
        end
        else begin
            if(count == 2'b01 || count == 2'b11) begin
                even_divider_4 <= ~even_divider_4;
            end
            else begin
                even_divider_4 <= even_divider_4;
            end
        end
    end

    // odd divider and divider = 3 and duty ratio = 50%
    // posedge count
    logic [1:0] pos_cnt, neg_cnt;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            pos_cnt <= 2'b00;
        end
        else begin
            if(pos_cnt == 2'b10) begin
                pos_cnt <= 2'b00;
            end
            else begin
                pos_cnt <= pos_cnt + 1'b1;
            end
        end
    end

    always @(negedge clk or negedge rst_n) begin
        if(~rst_n) begin
            neg_cnt <= 2'b00;
        end
        else begin
            if(neg_cnt == 2'b10) begin
                neg_cnt <= 2'b00;
            end
            else begin
                neg_cnt <= neg_cnt + 1'b1;
            end
        end
    end

    // posedge divider
    logic div1, div2;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            div1 <= 1'b0;
        end
        else begin
            if(pos_cnt == 2'b01 || pos_cnt == 2'b10) begin
                div1 <= ~div1;
            end
            else begin
                div1 <= div1;
            end
        end
    end
    // negedge divider
    always @(negedge clk or negedge rst_n) begin
        if(~rst_n) begin
            div2 <= 1'b0;
        end
        else begin
            if(neg_cnt == 2'b01 || neg_cnt == 2'b10) begin
                div2 <= ~div2;
            end
            else begin
                div2 <= div2;
            end
        end
    end

    assign odd_divider_3 = div1 | div2;



endmodule