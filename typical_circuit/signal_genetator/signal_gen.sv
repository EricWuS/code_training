`timescale 1ns/1ns
module signal_generator(
	input clk,
	input rst_n,
	input [1:0] wave_choise,
	output reg [4:0]wave
	);

	reg [4:0] count;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			count <= 5'b0;
		end
		else begin
            if(wave_choise == 2'b00) begin
                if(count == 5'd19) begin
                    count <= 5'b0;
                end
                else begin
                    count <= count + 1'b1;
                end   
            end
			else begin
				count <= count;
			end
		end
	end

	reg flag;
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			wave <= 5'b0;
			flag <= 1'b1;
		end
		else begin
			case(wave_choise)
				2'b00: begin
					if(count == 5'd9) begin
						wave <= 5'd20;
					end
					else if(count >= 5'd19) begin
						wave <= 5'b0;
					end
					else begin
						wave <= wave;
					end
				end

				2'b01: begin
					if(wave >= 5'd20) begin
						wave <= 5'b0;
					end
					else begin
						wave <= wave + 1'b1;
					end
				end

				2'b10: begin
					if(flag == 1'b0) begin
						if(wave >= 5'd20) begin
							flag <= 1'b1;
							wave <= wave - 1'b1;
						end
						else begin
							wave <= wave + 1'b1;
						end
					end
					else begin
						if(wave == 5'b0) begin
							flag <= 1'b0;
							wave <= wave + 1'b1;
						end
						else begin 
							wave <= wave - 1'b1;
						end
					end
				end
				default: wave <= 5'b0;
			endcase
		end
	end
  
endmodule