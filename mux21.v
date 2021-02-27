module mux21(C, sel, A, B);
	parameter N = 32;
	input sel;
	input [N-1:0] A, B;
	output wire[N-1:0] C;
	assign C = sel ? A : B;
endmodule
