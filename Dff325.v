module Dff325(out, clear, in, clk);
	input [31:0] in;
	input clear; // 1 is clear, 0 is not clear
	input clk;
	output reg[4:0] out;
	initial	
	begin
		 out <= 5'h0;
	end

	always @(posedge clk)
	begin
		//out = (clear)? 32'h0 : in;
		out <= in[11:7];
end
endmodule

