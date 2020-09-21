`define ALU  2'b01
`define PC4   2'b10
`define DMEM 2'b00
module mux31 (WB, WBsel, pc, alu, mem);
	parameter n = 32;
	input [n-1:0] pc, alu, mem;
	input [1:0] WBsel;
	output [n-1:0] WB;
	

	assign WB = (WBsel == `DMEM) ? mem:
		(WBsel == `ALU) ? alu:
		(WBsel == `PC4) ? pc:
		32'b0;
endmodule
