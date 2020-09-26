module dmem(DataR, ALU_Out, MemRW, DataW, clk );
	parameter n = 32;
	parameter a = 1<<20;
	input MemRW, clk;
	input [n-1:0] ALU_Out;
	input [n-1:0] DataW;
	output reg[n-1:0] DataR;
	reg [n-1:0]DMEM[0:a-1];
	integer i;
initial 
begin
	for (i=0; i<a; i=i+1)
		DMEM[i] <= 32'h0;	
end
	always @(posedge clk)
	begin
	if (MemRW === 1'b1)
		begin
		DMEM[ALU_Out] <= DataW;
		end
	end
always @(ALU_Out)
begin
	DataR <= DMEM[ALU_Out];
end
endmodule
