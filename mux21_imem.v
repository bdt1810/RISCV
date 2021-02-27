module mux21_imem(C, sel, A, B);
	parameter N = 32;
	input sel;
	input [N-1:0] A, B;
	output reg[N-1:0] C;
	
	always@(*)
	begin
	case (sel)
	1'b0:
	C <= A;
	1'b1:
	C <= A - 4;
	endcase
	end
endmodule
