`timescale 1ps / 1ps
module tb_pl_RISCV;
	reg clk;
	initial 
	begin
		clk=0;
		forever #200
		clk= ~clk;
	end
	ForwardingPath d2(clk);

endmodule
