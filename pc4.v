module pc4(pc4, pc_out);
	parameter n = 32;
	input  [n-1:0] pc_out;
	output reg[n-1:0] pc4;

	always @(*)
	begin
	 pc4 = pc_out + 4 ;
	end
endmodule
