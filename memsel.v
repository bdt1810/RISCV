`define  LW   3'b000 
`define  LH   3'b001 
`define  LB   3'b010 
`define  LHU  3'b011 
`define  LBU  3'b100 
module memsel(in, Memsel, out);	
	parameter n = 32;
	input [2:0] Memsel;
	input [n-1:0] in;
	output [n-1:0] out;

	assign out = (Memsel === `LW)  ? in :
		     (Memsel === `LH)  ? {{16{in[15]}},in[15:0]} :
		     (Memsel === `LB)  ? {{24{in[7]}},in[7:0]}   :
		     (Memsel === `LHU) ? {{16{1'b0}},in[15:0]}   :
		     (Memsel === `LBU) ? {{24{1'b0}},in[7:0]} : 32'h0000_0000;	
endmodule 