`define SW	2'b00
`define SH	2'b01
`define SB	2'b00
module memctr(DataW, MemCtr, DataB);
	parameter n = 32; 
	input [n-1:0] DataB;
	output [n-1:0] DataW;  
	output [1:0] MemCtr;

	assign DataW = (MemCtr === `SW)  ? DataB :
		     (MemCtr === `SH)  ? {{16{DataB[15]}},DataB[15:0]} :
		     (MemCtr === `SB)  ? {{24{DataB[7]}},DataB[7:0]}   : 32'h0000_0000;	
endmodule 

