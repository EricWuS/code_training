/************序列发生器**************/

module seq (
    input clk,
    input rst_n,
    output seq
);

    // reg [2:0] counter;
    // // counter defination
    // always @(posedge clk or negedge rst_n) begin
    //     if(!rst_n) begin
    //         counter <= 'b0;
    //     end
    //     else begin
    //         counter <= counter + 1;
    //     end
    // end
    // // 产生序列 0001_0111
    // assign seq = ~((~counter[1] & ~counter[0]) || (~counter[2] & ~counter[1]) || (~counter[2] & ~counter[0]));
    reg [7:0] seq_r;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            seq_r = 'b00010111;
        end
        else begin
            seq_r <= {seq_r[6:0], seq_r[7]};
        end
    end
    assign seq = seq_r[7];

endmodule