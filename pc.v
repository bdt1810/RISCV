module pc (pcout, pcin, sel, clk);
	parameter n = 32;
	input clk, sel;
	input [n-1:0] pcin;
	output reg [n-1:0] pcout;
	
	initial 
	begin	
	pcout <= 32'd0;
	end
	always @(posedge clk)
	begin
	case(sel)
	1'b0:
		pcout <= pcin;
	1'b1:
		pcout <= pcin - 4;
	endcase
	end
endmodule 
