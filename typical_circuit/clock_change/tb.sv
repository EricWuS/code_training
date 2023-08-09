`timescale 1ns/1ps

module test ;
    reg          clk_100mhz, clk_200mhz ;
    reg          rstn ;
    reg          sel ;
    wire         clk_out_simple ;
    wire         clk_out_free;


    always #(2.5)    clk_200mhz  = ~clk_200mhz ;
    always @(posedge clk_200mhz)
                        clk_100mhz  = #1 ~clk_100mhz ;


    initial begin
        clk_100mhz  = 0 ;
        clk_200mhz  = 0 ;
        rstn        = 0 ;
        sel         = 1 ;
        #11 rstn    = 1 ;
        #36.2 sel   = ~sel ;
        #119.7 sel   = ~sel ;
    end

    simple u_simple(
        .sel(sel),
        .clka(clk_100mhz),
        .clkb(clk_200mhz),
        .clkout(clk_out_simple)
    );

    glitch_free u_glitch_free(
        .clk0(clk_100mhz),
        .clk1(clk_200mhz),
        .sel(sel),
        .rst_n(rstn),
        .clk_out(clk_out_free)
    );

    initial begin
        forever begin
            #100;
            if ($time >= 10000)  $finish ;
        end
    end
endmodule