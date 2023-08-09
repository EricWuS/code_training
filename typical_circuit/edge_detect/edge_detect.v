/******手撕代码5：实现单bit信号的边沿检测，包括上升沿，下降沿，双边沿**********/

module edge_detect (
    input clk,
    input rst_n,
    input din,
    output reg pos_edge,
    output reg neg_edge,
    output reg bi_edge
);
    reg [1:0] din_r;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            din_r <= 2'b00;
        end
        else begin
            din_r <= {din_r[0], din};
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pos_edge <= 'b0;
            neg_edge <= 'b0;
            bi_edge <= 'b0;
        end
        else begin
            pos_edge <= ~din_r[1] & din_r[0];
            neg_edge <= din_r[1] & ~din_r[0];
            bi_edge <= pos_edge | neg_edge;
        end
    end

endmodule