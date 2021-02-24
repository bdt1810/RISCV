module GHT(addr, PCsel, inst, clk);
	input PCsel, clk;
	input [31:0] inst;
	output [11:0] addr;
	reg [11:0] GHR;
	always @(negedge clk)
	begin
		if (inst[6:0] == 7'b1100011)
		begin
			GHR[11:0] <= (GHR[11:0]<<1) | PCsel;
		end
	end   
	assign addr = GHR[11:0];
endmodule