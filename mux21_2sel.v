module mux21_2sel(C, sel, A, B);
	input [1:0]sel;
	input [31:0] A, B;
	output reg[31:0] C;
	always @(*)
	begin
	case(sel)
	2'b00: C <= A;
	2'b10: C <= B-4;
	2'b01: C <= B-4;
	default: C <= A;
	endcase
	end


endmodule
