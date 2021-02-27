module Dff2(out, clear, in, clk);
	parameter n = 2;
	input [n-1:0] in;
	input clear; // 1 is clear, 0 is not clear
	input clk;
	output reg [n-1:0] out;
initial	
	begin
		out <= 2'b00;
	end
always @(posedge clk)
	begin
		out <= clear? 2'b00 : in;
	end
endmodule

