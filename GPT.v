module GPT(predict, addr, past, clk, taken2, inst);
input [11:0] addr, past;
input clk, taken2;
input [31:0] inst;
output predict;
reg [1:0] counter [0:4095];
assign predict = (counter[addr] >= 2) ? 1'b1: 1'b0;
always @(negedge clk)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		if (taken2 === 1'b1)
		begin
			case(counter[past])
			2'b01: counter[past] = 2'b00;
			2'b10: counter[past] = 2'b11;
			endcase
		end
		else
		begin
			case(counter[past])
			2'b00: counter[past] = 2'b01;
			2'b01: counter[past] = 2'b10;
			2'b10: counter[past] = 2'b01;
			2'b11: counter[past] = 2'b10;
			endcase
		end
	end
end
endmodule
