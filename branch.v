module branch(in0, in1, BrUn, BrEq, BrLT);
	parameter n = 32;
	input BrUn;
	input [n-1:0] in0, in1;
	output reg BrEq, BrLT; 
	assign BrUn = 1'b0;
	assign in0 = 32'h00000001;
	assign in1 = 32'h80000001;
	always @(*) begin
		if (BrUn === 1'b1) begin
			BrEq = (in0 === in1) ? 1 : 0;
			BrLT = (in0 < in1) ? 1: 0; 
		end
		else begin 
			BrEq = (in0 === in1) ? 1 : 0;
			BrLT = ($signed(in0) < $signed(in1)) ? 1: 0; 
		end
	end
endmodule
