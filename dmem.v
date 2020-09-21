module dmem(DataR, ALU_Out, MemRW, DataW, clk );
	parameter n = 32;
	parameter a = 1<<27;
	input MemRW, clk;
	input [n-1:0] ALU_Out;
	input [n-1:0] DataW;
	output reg[n-1:0] DataR;
	reg [n-1:0]DMEM[0:a-1];


	always @(posedge clk)
	begin
	case(MemRW)
	1'b1: 
		DMEM[ALU_Out] <= DataW;
	1'b0: 
		DataR <= DMEM[ALU_Out]; 
	endcase
	end
endmodule
