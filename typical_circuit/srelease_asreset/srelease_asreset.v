/*********手撕代码6：同步释放，异步复位*********/

module srelease_asreset (
    input clk,
    input rst_async_n,
    output rst_sync_n
);

    reg q1, q2;
    always @(posedge clk or negedge rst_async_n) begin
        if(!rst_async_n) begin
            q1 <= 'b0;
            q2 <= 'b0;
        end
        else begin
            q1 <= 'b1;
            q2 <= q1;
        end
    end

    assign rst_sync_n = q2;
    
endmodule