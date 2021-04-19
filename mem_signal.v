module mem_signal(inst, cs, rd_n, wr_n, be);
input [31:0] inst;
//input valid, request;
output reg [3:0] be;
output reg cs, rd_n, wr_n;

always @(inst)
begin
	if (inst[6:0] === 7'b0000011)
	begin
		cs <= 1'b1;
		rd_n <= 1'b0;
		wr_n <= 1'b1;
		be <= 4'b1111;
	end
	else if (inst[6:0] === 7'b0100011)
	begin
		cs <= 1'b1;
		rd_n <= 1'b1;
		wr_n <= 1'b0;
		be <= 4'b1111;
	end
	else
	begin
		cs <= 1'b0;
		rd_n <= 1'b1;
		wr_n <= 1'b1;
		be <= 4'b0000;
	end
end
endmodule
