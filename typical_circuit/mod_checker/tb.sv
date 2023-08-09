`timescale 1ns/1ns

module mod3_check_tb;
    reg clk;
    reg rst_n;
    reg ser_in;
    wire flag_y;

    mod3_check mod3_check_u(
        .clk(clk),
        .rst_n(rst_n),
        .din(ser_in),
        .flag_y(flag_y)
    );
    // reset trigger
    // initial begin 
    //     #10 rst_n <= 0;
    //     repeat(10) @(posedge clk);
    //     rst_n <= 1;
    // end

    initial begin
        clk = 1;
        rst_n = 1;
        ser_in = 0;
        #20 rst_n = 0; // Assert reset
        #20 rst_n = 1; // Deassert reset

        // Test cases
        #10 ser_in = 1;
        #10 ser_in = 1; // flag_y should be 1 here
        #10 ser_in = 0; // flag_y should be 1 here
        #10 ser_in = 1;
        #10 ser_in = 1; // flag_y should be 1 here 
        #10 ser_in = 0; // flag_y should be 1 here
        #10 ser_in = 1;
        #10 ser_in = 0;

        // End simulation
        #10 $finish;
    end
    
    // clock generation
    initial begin 
        forever begin
            #5 clk <= !clk;
        end
    end
    

endmodule