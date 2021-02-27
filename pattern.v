module pattern(predict, addr, past, clk, taken1, inst);
input [9:0] addr, past;
input clk, taken1;
input [31:0] inst;
output predict;
reg [2:0] counter [0:1023];
assign predict = (counter[addr] >= 4) ? 1'b1: 1'b0;
always @(negedge clk)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		if (taken1 === 1'b1)
		begin
			case(counter[past])
			3'b001: counter[past] = 3'b000;
			3'b010: counter[past] = 3'b001;
			3'b011: counter[past] = 3'b010;
			3'b100: counter[past] = 3'b101;
			3'b101: counter[past] = 3'b110;
			3'b110: counter[past] = 3'b111;
			endcase
		end
		else
		begin
			case(counter[past])
			3'b000: counter[past] = 3'b001;
			3'b001: counter[past] = 3'b010;
			3'b010: counter[past] = 3'b011;
			3'b011: counter[past] = 3'b100;
			3'b100: counter[past] = 3'b011;
			3'b101: counter[past] = 3'b100;
			3'b110: counter[past] = 3'b101;
			3'b111: counter[past] = 3'b110;
			endcase
		end
	end
end
endmodule
