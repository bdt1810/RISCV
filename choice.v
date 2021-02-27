
module choice(choice, addr, past, taken1, taken2, clk, inst);
input taken1, taken2, clk;
input [31:0] inst;
input [11:0] addr, past;
output choice;
reg [1:0] counter [0:4095];
assign choice = (counter[addr] >= 2) ? 1'b1: 1'b0;
always @(clk)
begin
	if (inst[6:0]===7'b1100011)
	case (counter[past])
	2'b00: 
	begin
		if (~taken1 && taken2)
			counter[past] <= 2'b01;
	end
	
	2'b01:
	begin
		if (taken1 && ~taken2)
			counter[past] <= 2'b00;
		else if (~taken1 && taken2)
			counter[past] <= 2'b10;
	end

	2'b10:
	begin
		if (taken1 && ~taken2)
			counter[past] <= 2'b01;
		else if (~taken1 && taken2)
			counter[past] <= 2'b11;
	end
	 
	2'b11: 
	begin
		if (taken1 && ~taken2)
			counter[past] <= 2'b10;
	end
	endcase
end
endmodule