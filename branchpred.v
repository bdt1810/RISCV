`define	BEQ 	3'b000
`define	BNE	3'b001
`define BLT	3'b100
`define BGE	3'b101
`define BLTU	3'b110
`define BGEU	3'b111
`define ALU	1'b1
`define PC	1'b0
module prediction (opcode, type, BrEq, BrLT, flush, pcsel);
	input [6:0] opcode;
	input [2:0] type;
	input BrEq, BrLT;
	output reg flush, pcsel;
	always @(*)
	begin
		if (opcode === 7'b1100011)
		begin
			case(type)
			`BEQ:
			begin
				if (BrEq === 1'b1)
				begin
					flush = 1'b1;
					pcsel = `ALU;
				end
				else
				begin 
					flush = 1'b0;
					pcsel = `PC;
				end 
			end

			`BNE:
			begin
				if (BrEq === 1'b0)
				begin
					flush = 1'b1;
					pcsel = `ALU;
				end
				else 
				begin
					flush = 1'b0;
					pcsel = `PC;
				end
			end

			`BLT:
			begin
				if (BrLT === 1'b1)
				begin
					flush = 1'b1;
					pcsel = `ALU;
				end
				else
				begin
					flush = 1'b0;
					pcsel = `PC;
				end
			end

			`BGE:
			begin
				if (BrLT === 1'b0)
				begin
					flush = 1'b1;
					pcsel = `ALU;
				end
				else
				begin
					flush = 1'b0;
					pcsel = `PC;
				end
			end

			`BLTU:
			begin
				if (BrLT === 1'b1)
				begin
					flush = 1'b1;
					pcsel = `ALU;
				end
				else
				begin
					flush = 1'b0;
					pcsel = `PC;
				end
			end
			
			`BGEU:
			begin
				if (BrLT === 1'b0)
				begin
					flush = 1'b1;
					pcsel = `PC;
				end
				else
				begin
					flush = 1'b0;
					pcsel = `PC;
				end
			end
			endcase
		end
	end
endmodule
