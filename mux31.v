`define ALU  2'b01
`define PC4   2'b10
`define DMEM 2'b00
module mux31(DataD, WBSel, memsel_out, ALU_Out, pc4);
	parameter n = 32;
	input [n-1:0] pc4, ALU_Out, memsel_out;
	input [1:0] WBSel;
	output [n-1:0] DataD;
	

	assign DataD = (WBSel === `DMEM) ? memsel_out: //00
		(WBSel === `ALU) ? ALU_Out: //01
		(WBSel === `PC4) ? pc4: //10
		pc4;
endmodule

//In1 00
//In2 01
//In3 10