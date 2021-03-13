module ABC(input1, input2, select, inst, clk, output1);
input [31:0] input1, input2, inst;
input select, clk;
output  [31:0] output1;

//always @(posedge clk)
//	begin
//	if(inst[6:0] === 7'b1100011)
//		begin
//		case(select)
//		1'b0:	begin
//			output1 <= input1;		
//			end
//		1'b1:
//			begin
//			output1 <= input2;
//			end
//		endcase
//		end
//	else
//		output1 <= input1;
//	end
assign output1 = (inst[6:0] === 7'b1100011) ? ((select ===1'b1) ? input2 : input1) : input1;
endmodule
