`define  LW   3'b000 
`define  LH   3'b001 
`define  LB   3'b010 
`define  LHU  3'b011 
`define  LBU  3'b100 
module memsel(memsel_out, Memsel, DataR);	
	parameter n = 32;
	input [2:0] Memsel;
	input [n-1:0] DataR;
	output [n-1:0] memsel_out;
	assign memsel_out = (Memsel === `LW)  ? DataR :
		     (Memsel === `LH)  ? {{16{DataR[15]}},DataR[15:0]} :
		     (Memsel === `LB)  ? {{24{DataR[7]}},DataR[7:0]}   :
		     (Memsel === `LHU) ? {{16{1'b0}},DataR[15:0]}   :
		     (Memsel === `LBU) ? {{24{1'b0}},DataR[7:0]} : 32'h0000_0000;	
endmodule 
