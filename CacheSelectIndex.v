module CacheSelectIndex(select, output0, output1, output2, output3, output4, output5, output6, output7, output8, output9, output10, output11, output12, output13, output14, output15);
input [3:0] select;
output reg output0, output1, output2, output3, output4, output5, output6, output7, output8, output9, output10, output11, output12, output13, output14, output15;

always @(*)
begin
case(select)
4'b0000:	begin
		output0 = 1'b1;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0001:	begin
		output0 = 1'b0;
		output1 = 1'b1;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0010:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b1;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0011:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b1;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0100:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b1;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0101:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b1;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0110:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b1;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b0111:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b1;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1000:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b1;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1001:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b1;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1010:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b1;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1011:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b1;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1100:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b1;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1101:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b1;
		output14 = 1'b0;
		output15 = 1'b0;
		end

4'b1110:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b1;
		output15 = 1'b0;
		end

4'b1111:	begin
		output0 = 1'b0;
		output1 = 1'b0;
		output2 = 1'b0;
		output3 = 1'b0;
		output4 = 1'b0;
		output5 = 1'b0;
		output6 = 1'b0;
		output7 = 1'b0;
		output8 = 1'b0;
		output9 = 1'b0;
		output10 = 1'b0;
		output11 = 1'b0;
		output12 = 1'b0;
		output13 = 1'b0;
		output14 = 1'b0;
		output15 = 1'b1;
		end
endcase
end
endmodule


		