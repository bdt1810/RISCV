module mux16to1_4bit(input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, select, output0);
input[3:0] input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15;
input [3:0] select;
output reg [3:0] output0;

always @(*)
begin
case(select)
4'b0000:	output0 = input0;
4'b0001:	output0 = input1;
4'b0010:	output0 = input2;
4'b0011:	output0 = input3;
4'b0100:	output0 = input4;
4'b0101:	output0 = input5;
4'b0110:	output0 = input6;
4'b0111:	output0 = input7;
4'b1000:	output0 = input8;
4'b1001:	output0 = input9;
4'b1010:	output0 = input10;
4'b1011:	output0 = input11;
4'b1100:	output0 = input12;
4'b1101:	output0 = input13;
4'b1110:	output0 = input14;
4'b1111:	output0 = input15;
endcase
end
endmodule
