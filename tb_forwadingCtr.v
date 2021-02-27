module mux41_2sel3(out, sel1, sel2, in1, in2, in3, in4);
input [31:0] in1, in2, in3, in4;
input sel1;
input [1:0]sel2;
output reg [31:0] out;
assign check = {sel1,sel2};
assign sel1 = 1'b1;
assign sel2 = 2'b00;
assign in1 = 8'h1;
assign in2 = 8'h2;
assign in3 = 8'h3;
assign in4 = 8'h4;
always @(*)
begin
	case(check)
	3'b100: 
	out = in1; //Pc
	3'b000:
	out = in2; //Reg
	3'b110:	
	out = in3; //DMEM
	3'b010:	
	out = in3; //DMEM
	3'b001:
	out = in4; //WB
	3'b101:
	out = in4; //WB
	endcase
end
endmodule
	
