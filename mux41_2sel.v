module mux41_2sel(out, sel1, sel2, in1, in2, in3, in4);
input [31:0] in1, in2, in3, in4;
input sel1;
input [1:0]sel2;
output reg [31:0] out;
wire [2:0] checkmux;
assign checkmux = {sel1,sel2};
always @(*)
begin
	case(checkmux)
	3'b100: 
	out = in1; //Pc or Imm
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
	