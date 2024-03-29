module truth(flush2, PCsel2, prediction, flush, inst);
input prediction;
input [1:0] flush; 
input [31:0 ]inst;
output reg PCsel2;
output reg [1:0] flush2;
initial 
begin
	PCsel2 <= 1'b0;
end
always @(*)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		case({prediction,flush})
			2'b000: //PC4
			begin
				PCsel2 <= 1'b1;
				flush2 <= 1'b00;
			end
			2'b011: //ALU
			begin
				PCsel2 <= 1'b0;
				flush2 <= 1'b11;
			end
			2'b100: //PC
			begin
				PCsel2 <= 1'b0;
				flush2 <= 1'b11;
			end
			2'b111: //PC4
			begin
				PCsel2 <= 1'b1;
				flush2 <= 1'b00;
			end
		endcase
	end
	else 
	begin
		flush2 <= flush;
	end
end
endmodule
