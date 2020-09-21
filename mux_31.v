`define ALU  2'b01
`define PC4   2'b10
`define DMEM 2'b00
module mux31 (DataD, WBSel, pc4, ALU_Out, memsel_out);
	parameter n = 32;
	input [n-1:0] pc4, ALU_Out, memsel_out;
	input [1:0] WBSel;
	output [n-1:0] WB;
	

	assign WB = (WBSel == `DMEM) ? memsel_out:
		(WBSel == `ALU) ? ALU_Out:
		(WBSel == `PC4) ? pc4:
		32'b0;
endmodule
