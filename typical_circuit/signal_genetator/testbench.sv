`timescale 1ns/1ns
module testbench();

	reg clk,rst_n;
	reg [1:0]wave_choise;
	wire [4:0]wave;

	
initial begin
	// $dumpfile("out.vcd");
	// $dumpvars(0,testbench);
	clk = 0;
	rst_n = 0;
    wave_choise = 2'b00;
    #1 rst_n = 1'b1;
end

// clock generation
initial begin 
    clk <= 0;
    forever begin
    #1 clk <= !clk;
    end
end

initial begin
	forever begin
		#100 wave_choise = wave_choise + 1;
	end
end
// always #100 wave_choise = wave_choise + 1'b1;
// always @(posedge clk or negedge rst_n) begin
//     if(~rst_n) begin
//         wave_choise <= 2'b00;
//     end
//     else begin
//         wave_choise <= wave_choise + 1'b1;
//     end
// end



signal_generator dut(
	.clk(clk),
	.rst_n(rst_n),
	.wave_choise(wave_choise),
	.wave(wave)
	);
endmodule