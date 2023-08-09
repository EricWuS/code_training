// `timescale 1ns / 1ns

// module clock_divider (
//     input clk,
//     // input divider,
//     input rst_n,
//     output logic odd_divider
// );
// // reg     [2:0]   cnt;
// // reg             clk_17;
// // reg             clk_17_r;

// // //cnt,计数器
// // always @(posedge clk or negedge rst_n) begin
// //     if(~rst_n)
// //         cnt <= 2'd0;
// //     else if(cnt == 3'd6)
// //         cnt <= 2'd0;
// //     else 
// //         cnt <= cnt + 'd1;
// // end
// // //clk_13,生成时钟1/3占空比的信号
// // always @(posedge clk or negedge rst_n) begin
// //     if(~rst_n)
// //         clk_17 <= 1'b0;
// //     else if(cnt >= 3'd4)
// //         clk_17 <= 1'b1;
// //     else 
// //         clk_17 <= 1'b0;
// // end
// // //clk_13_r,延迟半拍clk_13
// // always @(negedge clk or negedge rst_n) begin
// //     if(~rst_n)
// //         clk_17_r <= 1'b0;
// //     else
// //         clk_17_r <= clk_17;
// // end
// // //freq3,生成3倍频信号
// // assign odd_divider_3 = clk_17 | clk_17_r;

// //*************code***********//
// reg [2:0] cnt;
// always @(posedge clk or negedge rst_n) begin
//     if(~rst_n) begin
//         cnt <= 'b0;
//     end
//     else if(cnt == 3'd6) begin
//         cnt <= 'b0;
//     end
//     else begin
//         cnt <= cnt + 'b1;
//     end
// end

// reg pos_clk, neg_clk;
// always @(posedge clk or negedge rst_n) begin
//     if(~rst_n) begin
//         pos_clk <= 'b0;
//     end
//     else begin
//         pos_clk <= (cnt == 'd3 || cnt == 'd6) ? ~pos_clk : pos_clk;
//     end
// end
// always @(negedge clk or negedge rst_n) begin
//     if(~rst_n) begin
//         neg_clk <= 'b0;
//     end
//     else begin
//         neg_clk <= (cnt == 'd3 || cnt == 'd6) ? ~neg_clk : neg_clk;
//     end
// end
// assign odd_divider = pos_clk | neg_clk;
 
// endmodule


module clock_divider(
    input clk,
    input rst_n,
    output odd_divider_3
);

    // 计数器
    reg [1:0] pos_cnt, neg_cnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            pos_cnt <= 2'b00;
        else
            if(pos_cnt == 2'b10)
                pos_cnt <= 'b0;
            else
                pos_cnt <= pos_cnt + 1'b1;
    end

    always @(negedge clk or negedge rst_n) begin
        if(!rst_n)
            neg_cnt <= 2'b00;
        else begin
            if(neg_cnt == 2'b10)
                neg_cnt <= 'b0;
            else
                neg_cnt <= neg_cnt + 1'b1;
        end
    end

    // 翻转电平
    reg div1, div2;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            div1 <= 1'b0;
        else begin
            if(pos_cnt == 2'b00 || pos_cnt == 2'b01)
                div1 <= ~div1;
            else
                div1 <= div1;
        end
    end

    always @(negedge clk or negedge rst_n) begin
        if(!rst_n)
            div2 <= 1'b0;
        else begin
            if(neg_cnt == 2'b00 || neg_cnt == 2'b01)
                div2 <= ~div2;
            else
                div2 <= div2;
        end
    end

    assign odd_divider_3 = div1 | div2;

endmodule
