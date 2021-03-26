module dynamic(addr, PC, inst, PCsel, pastPC);
input [31:0] PC, inst, pastPC;
input PCsel;
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
always @(inst)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		LHT[pastPC[11:2]][9:0] = {LHT[pastPC[11:2]][8:0],PCsel};
		//LHT[past][0] <= PCsel; 
	end
end
assign addr[9:0] = LHT[(PC[11:2])][9:0];
endmodule
