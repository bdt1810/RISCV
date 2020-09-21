`define SW	2'b00
`define SH	2'b01
`define SB	2'b00
module memctr(in, out, MemCtr);
	parameter n = 32; 
	input [n-1:0] in;
	output [n-1:0] out;  
	output [1:0] MemCtr;

	assign out = (MemCtr === `SW)  ? in :
		     (MemCtr === `SH)  ? {{16{in[15]}},in[15:0]} :
		     (MemCtr === `SB)  ? {{24{in[7]}},in[7:0]}   : 32'h0000_0000;	
endmodule 