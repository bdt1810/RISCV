module branch(BrEq, BrLT, DataA, DataB, BrUn);
	parameter n = 32;
	input BrUn;
	input [n-1:0] DataA, DataB;
	output reg BrEq, BrLT; 
	assign BrUn = 1'b0;
	always @(*) begin
		if (BrUn === 1'b1) begin
			BrEq = (DataA === DataB) ? 1 : 0;
			BrLT = (DataA < DataB) ? 1: 0; 
		end
		else begin 
			BrEq = (DataA === DataB) ? 1 : 0;
			BrLT = ($signed(DataA) < $signed(DataB)) ? 1: 0; 
		end
	end
endmodule
