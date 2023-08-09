module simple(

    input sel,//sel==1'b1时，输出clka，否则，输出clkb
    input clka,
    input clkb,
    
    output clkout

    );
    
    assign clkout = (clka && sel) || (clkb && ~sel);
    
endmodule