module truth(flush2, flush1, PCsel2, prediction, flush, inst, stall);
input prediction, stall;
input [1:0] flush; 
input [31:0 ]inst;
output reg PCsel2;
output reg [1:0] flush2, flush1;
initial 
begin
	PCsel2 <= 1'b0;
end
always @(*)
begin
	if (inst[6:0] === 7'b1100011)
	begin
		case({prediction,flush})
			3'b000: //PC4
			begin
				PCsel2 <= 1'b1;
				flush2 <= 2'b00;
				flush1 <= 2'b00;
			end
			3'b011: //ALU
			begin
				PCsel2 <= 1'b0;
				flush2 <= 2'b11;
				flush1 <= 2'b11;
			end
			3'b100: //PC
			begin
				PCsel2 <= 1'b0;
				flush2 <= 2'b11;
				flush1 <= 2'b11;
			end
			3'b111: //PC4
			begin
				PCsel2 <= 1'b1;
				flush2 <= 2'b00;
				flush1 <= 2'b00;
			end
		endcase
	end
	else if (inst[6:0] === 7'b1101111)
	begin
		PCsel2 <= 1'b0;
		flush2 <= 2'b11; 
		flush1 <= 2'b11;
	end
	else if (inst[6:0] === 7'b1100111)
	begin
		PCsel2 <= 1'b0;
		flush2 <= 2'b11;
		flush1 <= 2'b11;
	end
	else 
	begin
		if (stall === 1'b1)
		begin
			PCsel2 <= 1'b1;
			flush2 <= 2'b11;
			flush1 <= 2'b10;
		end
		else
		begin
			PCsel2 <= 1'b1;
			flush2 <= flush;
			flush1 <= flush;
		end
	end
end
endmodule
