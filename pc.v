module pc (clk, pcin, pcout);
	parameter n = 32;
	input clk;
	input [n-1:0] pcin;
	output reg [n-1:0] pcout;
	
	initial
	begin
		pcout <= 32'h0;
	end  

	always @(posedge clk)
	begin
		pcout <= pcin;
	end
endmodule 