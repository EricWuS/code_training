/***************vending machine 2 ******************/
module vending_machine2 (
    input wire clk,
	input wire rst,
	input wire d1,
	input wire d2,
	input wire sel,
	
	output reg out1,
	output reg out2,
	output reg out3 
);

    // FSM
    parameter IDLE = 4'b0000;    // 0
    parameter S0   = 4'b0001;    // 0.5
    parameter S1   = 4'b0010;    // 1
    parameter S2   = 4'b0100;    // 1.5
    parameter S3   = 4'b1000;    // 2
    
    reg [3:0] cs,ns;
    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            cs <= IDLE;
        end
        else begin
            cs <= ns;
        end
    end

    // transition condition:sel == 0 out1 ; sel == 1 out2
    always @(rst, d1, d2, sel) begin
        if(~rst) begin
            ns = IDLE;
            cs = IDLE;
        end
        else begin
            if(!sel) begin
                // buy out1
                case (cs)
                    IDLE: begin
                        case({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = S0;
                            2'b01: ns = S1;
                            default: ns = IDLE;   
                        endcase
                    end
                    S0: begin
                        case ({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = S1;
                            2'b01: ns = IDLE;
                            default: ns = IDLE;
                        endcase
                    end
                    S1: begin
                        case ({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = IDLE;
                            2'b01: ns = IDLE;
                            default: ns = IDLE;
                        endcase
                    end
                    default: ns = IDLE;
                endcase
            end
            else begin
                // buy out2
                case (cs)
                    IDLE: begin
                        case({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = S0;
                            2'b01: ns = S1;
                            default: ns = IDLE;
                        endcase
                    end
                    S0: begin
                        case ({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = S1;
                            2'b01: ns = S2;
                            default: ns = IDLE;
                        endcase
                    end
                    S1: begin
                        case ({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = S2;
                            2'b01: ns = S3;
                            default: ns = IDLE;
                        endcase
                    end
                    S2: begin
                        case ({d1, d2})
                            2'b00: ns = ns;
                            2'b10: ns = S3;
                            2'b01: ns = IDLE;
                            default: ns = IDLE;
                        endcase
                    end
                    S3: begin
                        ns = ({d1, d2} == 2'b00) ? ns : IDLE;
                    end
                    default: ns = IDLE;
                endcase
            end
        end
    end 

    // out1 out2 out3 logic
    reg out1_r, out2_r, out3_r;
    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            out1_r <= 'b0;
            out2_r <= 'b0;
            out3_r <= 'b0;
        end
        else begin
            if(~sel) begin
                // buy out1
                out2_r <= 1'b0;
                out3_r <= 1'b0;
                case (cs)
                    S0: begin
                        out1_r <= ({d1, d2} == 2'b01) ? 1'b1 : 1'b0;
                        out3_r <= 1'b0; 
                    end
                    S1: begin
                        out1_r <= {d1, d2} != 2'b00 ? 1'b1 : 1'b0;
                        out3_r <= {d1, d2} == 2'b01 ? 1'b1 : 1'b0;
                    end
                    default: begin
                        out1_r <= 1'b0;
                        out3_r <= 1'b0;
                    end
                endcase
            end
            else begin
                // buy out2
                out1_r <= 1'b0;
                out3_r <= 1'b0;
                case (cs)
                    S2: begin
                        out2_r <= ({d1, d2} == 2'b01) ? 1'b1 : 1'b0;
                        out3_r <= 1'b0; 
                    end
                    S3: begin
                        out2_r <= {d1, d2} != 2'b00 ? 1'b1 : 1'b0;
                        out3_r <= {d1, d2} == 2'b01 ? 1'b1 : 1'b0;
                    end
                    default: begin
                        out2_r <= 1'b0;
                        out3_r <= 1'b0;
                    end
                endcase
            end
        end
    end

    // 打一拍
    always @(posedge clk or negedge rst) begin
        if(~rst) begin
            out1 <= 'b0;
            out2 <= 'b0;
            out3 <= 'b0;
        end
        else begin
            out1 <= out1_r;
            out2 <= out2_r;
            out3 <= out3_r;
        end
    end
endmodule