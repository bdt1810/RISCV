`timescale 1ps / 1ps
module tb_RISCV;
	reg clk;
	initial 
	begin
		clk=0;
		forever #250
		clk= ~clk;
	end
	RISCV RISCV(clk);

endmodule
