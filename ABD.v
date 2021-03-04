module ABD(input1, input2, inst, pinst, output1);
input [31:0] input1, input2, inst, pinst;
output reg [31:0] output1;

always @(*)
begin
	if((pinst[6:0] === 7'b1101111) || (pinst[6:0] === 7'b1100111))
	begin
			output1 <= input1;
	end
	else
	begin
		if (inst[6:0] === 7'b1100011)
		begin
			output1 <= input2;
		end
		else 
		begin
			output1 <= input1;
		end
	end
end
endmodule