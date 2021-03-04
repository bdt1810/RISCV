module dynamic(addr, PC, inst, PCsel, clk, past);
input [31:0] PC, inst;
input PCsel, clk;
input [9:0] past;
integer i;
output [9:0] addr;
reg [9:0] LHT[0:1023];
initial
begin
	for (i=0; i<1024; i=i+1)
	begin
		LHT[i] <= 10'b1111111111;
	end
end
always @(*)
begin
	if (inst[31:0] === 7'b1100011)
	begin
		LHT[past] = (LHT[past] << 1) | PCsel; 
	end
end
assign addr = LHT[PC[11:2]];
endmodule
