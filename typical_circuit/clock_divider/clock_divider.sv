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
    // define a counter used for odd divider
    logic [1:0] odd_count;
    logic tff1_en, tff2_en;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            odd_count <= 2'b00;
        end
        else begin
            if(odd_count == 2'b10) begin
                odd_count <= 2'b00;
            end
            else begin
                odd_count <= odd_count + 1'b1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            tff1_en <= 1'b1;
            tff2_en <= 1'b0;
        end
        else begin
            case (odd_count)
                2'b10: begin
                    tff1_en <= 1'b1;
                    tff2_en <= 1'b0;
                end
                2'b01: begin
                    tff2_en <= 1'b1;
                    tff1_en <= 1'b0;
                end
                default: begin
                    tff1_en <= 1'b0;
                    tff2_en <= 1'b0;
                end
            endcase
            // tff1_en = (odd_count == 2'b00);
            // tff2_en = (odd_count == 2'b10);
        end
    end

    logic div1, div2;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            div1 <= 1'b0;
        end
        else begin
            div1 = (tff1_en) ? ~div1 : div1;
        end
    end

    always @(negedge clk or negedge rst_n) begin
        if(~rst_n) begin
            div2 <= 1'b0;
        end
        else begin
            div2 = (tff2_en) ? ~div2 : div2;
        end
    end

    assign odd_divider_3 = div1 ^ div2;



endmodule