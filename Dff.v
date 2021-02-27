module Dff(out, clear, in1, in2, clk);
	input [31:0] in1;
	input [31:0] in2;
	input [1:0] clear; 
	input clk;
	output reg[31:0] out;

	initial	
	begin
		 out <= 32'h0;
	end

	always @(posedge clk)
	begin
		case(clear)
		2'b00: out <= in1;	// 00 is normal
		2'b01: out <= in2;	// 01 is stall
		2'b10: out <= in2;	// 10 is stall
		2'b11: out <= 32'd0; 	// 11 is flush
		endcase
	end
endmodule

