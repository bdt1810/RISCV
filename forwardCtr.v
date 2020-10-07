`define ALU_Out		2'b00
`define tmpA		2'b01
`define DataD		2'b10
module forwardCtr(out, inst1, inst2, inst3);
input [31:0] inst1, inst2, inst3;
output reg [1:0] out;
wire [4:0] rd_inst1, rs1_inst2, rs2_isnt2, rs1_inst3, rs2_inst3;

assign rd_inst1 = inst1[11:7];
assign rs1_inst2 = inst2[25:19];
assign rs2_inst2 = inst2[24:20];
assign rs1_inst3 = inst3[25:19];
assign rs2_inst3 = inst3[24:20];

always @(*)
begin 
	if (rd_inst1 === rs1_inst2 || rd_inst1 === rs2_inst2)
		out <= `ALU_Out;
	else if (rd_inst1 === rs1_inst3 || rd_inst1 === rs2_inst3)
		out <= `DataD;
	else 
		out <= `tmpA;
end
endmodule
