module Dffx(out, clear, in, clk);
	parameter n= 32;
	input [n-1:0] in;
	input clear; // 1 is clear, 0 is not clear
	input clk;
	output reg [n-1:0] out;
initial	
	begin
		out <= 32'h0;
	end
always @(posedge clk)
	begin
		out <= clear? 32'd0 : in;
	end
endmodule
