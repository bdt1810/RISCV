module GPT(predict, addr, past, taken2, inst);
input [9:0] addr, past;
input taken2;
input [31:0] inst;
integer i;
output predict;
reg [1:0] counter [0:1023];
assign predict = (counter[addr] >= 2) ? 1'b1: 1'b0;
initial
begin
	for (i=0; i<1024; i=i+1)
	begin
		counter[i] <= 2'b11;
	end
end
always @(*)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		if (taken2 === 1'b1)
		begin
//			case(counter[past])
//			2'b01: counter[past] = 2'b00;
//			2'b10: counter[past] = 2'b11;
//			endcase
			counter[past][0] <= !counter[past][1];
			counter[past][1] <=  counter[past][1];
		end
		else
		begin
			counter[past][0] <= !counter[past][0];
			counter[past][1] <= counter[past][0];
//			case(counter[past])
//			2'b00: counter[past] = 2'b01;
//			2'b01: counter[past] = 2'b10;
//			2'b10: counter[past] = 2'b01;
//			2'b11: counter[past] = 2'b10;
//			endcase
		end
	end
end
endmodule
