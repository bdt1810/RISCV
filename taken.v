module taken(true, taken1, taken2, inst, pprediction, predict1, predict2, PCsel, clk);
input [31:0] inst;
input pprediction, predict1, predict2, PCsel, clk;
output reg taken1, taken2, true;
always @(*)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		taken1 <= (PCsel === predict1) ? 1'b0 : 1'b1;
		taken2 <= (PCsel === predict2) ? 1'b0 : 1'b1;
		true <= (PCsel === pprediction) ? 1'b0 : 1'b1;
	end
	else 
	begin
		true <= 1'b0;
	end 
end
endmodule
