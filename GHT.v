module GHT(addr, PCsel, inst);
	input PCsel;
	input [31:0] inst;
	output [9:0] addr;
	reg [9:0] GHR;
	initial 
	begin
		GHR[9:0] <= 10'b1111111111; 
	end
	always @(inst)
	begin
		if (inst[6:0] === 7'b1100011)
		begin
			//GHR[11:0] = ((GHR[11:0]<<1) | {{11{1'b0}},PCsel});
			GHR[9:0] = {GHR[8:0],PCsel};
		end
		else
			GHR[9:0] <= GHR[9:0];
	end   
	assign addr = GHR[9:0];
endmodule
