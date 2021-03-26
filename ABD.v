module ABD(input1, input2, inst, pinst, stall, true, output1);
input stall, true;
input [31:0] input1, input2, inst, pinst;
output  [31:0] output1;
//initial 
//begin
//	output1 = 32'd0; 
//end

//always @(input1)
//begin
//	if((pinst[6:0] === 7'b1101111) || (pinst[6:0] === 7'b1100111))
//	begin
//			output1 <= input1;
//	end
//	else
//	begin
//		if (stall === 1'b1)
//			output1 <= input1;
//		else 
//		begin	
//			if (inst[6:0] === 7'b1100011)
//			begin
//				output1 <= input2;
//			end
//			else 
//			begin
//				output1 <= input1;
//			end
//		end
//	end
//end
assign output1 = ((pinst[6:0] === 7'b1101111) || (pinst[6:0] === 7'b1100111)) ? input1 : 
		 (((pinst[6:0] === 7'b1100011) && (true === 1'b0)) ? input1 : 
		 (stall === 1'b1 ? input1 : (inst[6:0] === 7'b1100011 ? input2 : input1)));	
endmodule