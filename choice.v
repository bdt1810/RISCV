
module choice(choice, addr, past, taken1, taken2, inst);
input taken1, taken2;
input [31:0] inst;
input [9:0] addr, past;
integer i;
output choice;
reg [1:0] counter2 [0:1023];
assign choice = (counter2[addr] >= 2) ? 1'b1: 1'b0;
initial
begin
	for (i=0; i<1024; i=i+1)
	begin
		counter2[i] <= 2'b00;
	end
end
always @(*)
begin
	if (inst[6:0]===7'b1100011)
	begin
		if (taken1 && !taken2 && (counter2[past] === 2'b01))
			counter2[past] <= 2'b00;
		else if ((taken1 ^ taken2) && !counter2[past][0])
			counter2[past] <= 2'b01;
		else if ((taken1 ^ taken2) && counter2[past][0])
			counter2[past] <= 2'b10;
		else if (!taken1 && taken2 && (counter2[past] === 2'b10))
			counter2[past] <= 2'b11;
		else
			counter2[past] <= counter2[past];
//	case (counter2[past])
//	2'b00: 
//	begin
//		if (~taken1 && taken2)
//			counter2[past] <= 2'b01;
//	end
//	
//	2'b01:
//	begin
//		if (taken1 && ~taken2)
//			counter2[past] <= 2'b00;
//		else if (~taken1 && taken2)
//			counter2[past] <= 2'b10;
//	end
//
//	2'b10:
//	begin
//		if (taken1 && ~taken2)
//			counter2[past] <= 2'b01;
//		else if (~taken1 && taken2)
//			counter2[past] <= 2'b11;
//	end
//	 
//	2'b11: 
//	begin
//		if (taken1 && ~taken2)
//			counter2[past] <= 2'b10;
//	end
//	endcase
	end
end
endmodule