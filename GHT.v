module GHT(addr, PCsel, inst);
	input PCsel;
	input [31:0] inst;
	output [11:0] addr;
	reg [11:0] GHR;
	initial 
	begin
		GHR[11:0] <= 12'b111111111111; 
	end
	always @(inst)
	begin
		if (inst[6:0] === 7'b1100011)
		begin
			//GHR[11:0] = ((GHR[11:0]<<1) | {{11{1'b0}},PCsel});
			GHR[11:0] = {GHR[10:0],PCsel};
		end
	end   
	assign addr = GHR[11:0];
endmodule
