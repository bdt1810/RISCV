module taken(true, taken1, taken2, inst, prediction, predict1, predict2, PCsel, clk);
input [31:0] inst;
input prediction, predict1, predict2, PCsel, clk;
output reg taken1, taken2, true;
always @(posedge clk)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		taken1 <= (PCsel === predict1) ? 1'b0 : 1'b1;
		taken2 <= (PCsel === predict2) ? 1'b0 : 1'b1;
		true <= (PCsel === prediction) ? 1'b0 : 1'b1;
	end
	else 
	begin
		true <= 1'b0;
	end 
end
endmodule
