module glitch_free (
    input clk0,
    input clk1,
    input sel,
    input rst_n,
    output clk_out
);
    reg     out1;
    reg     out0;
    always @(negedge clk1 or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            out1 <= 0;
        end
        else begin
            out1 <= ~out0 & sel;
        end
    end

    always @(negedge clk0 or negedge rst_n)begin
        if(rst_n == 1'b0)begin
            out0 <= 0;
        end
        else begin
            out0 <= ~sel & ~out1;
        end
    end
 
    assign clk_out = (out1 & clk1) | (out0 & clk0);

endmodule