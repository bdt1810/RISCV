module add4(in1, out);
	parameter n = 32;
	input  [n-1:0] in1;
	output  [n-1:0] out;

	assign out = in1 + 4 ;
endmodule