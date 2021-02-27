`timescale 1ps / 1ps
module CacheFinalTest;
	reg clk;
	
	initial 
	begin
		clk=1;
		forever #400
		clk= ~clk;
	end
	begin
	CacheTestFullPath1 VL(clk);
	end

endmodule
