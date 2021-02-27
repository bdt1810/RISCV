 module Dffrom(out, clear, outI, in1, in2, clk);
	parameter n = 9;
	input [n-1:0] in1, in2;
	input [1:0] clear; // 1 is clear, 0 is not clear
	input clk, outI;
	output reg [n-1:0] out;
initial	
	begin
		out <= 9'b000000000;
	end
always @(posedge clk)
	begin
		if (outI === 1'b0)
		begin
		case(clear)
		2'b00: out <= in1;
		2'b10: out <= in2;
		2'b01: out <= in2;
		2'b11: out <= 9'b000011111;
		endcase
		end
		else
		begin
		case(clear)
		2'b00: out <= in1;
		2'b10: out <= in2;
		2'b01: out <= in2;
		2'b11: out <= 9'b000011101;
		endcase
		end	
	end
endmodule

