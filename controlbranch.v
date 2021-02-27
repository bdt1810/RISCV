`define R_TYPE		7'b0110011 	//Rs1, Rs2, Rd
`define B_TYPE		7'b1100011 	//Rs1, Rs2
`define S_TYPE		7'b0100011 	//Rs1, Rs2
`define I_TYPE		7'b0010011	//Rs1,      Rd
`define L_TYPE 		7'b0000011	//Rs1,      Rd
`define JAL		7'b1101111	//          Rd
`define JALR		7'b1100111	//          Rd
`define LUI		7'b0110111	//          Rd
`define AUIPC		7'b0010111  	//          Rd

module controlbranch(inst1, inst2, inst3, outA, outB);
input [31:0] inst1, inst2, inst3;
output reg[1:0] outA, outB;

wire [4:0] rs1_inst1, rs2_inst1, rd_inst2, rd_inst3;
wire [4:0] rd_inst1, rs1_inst0, rs2_inst0;
wire [6:0] opcode0, opcode1, opcode2, opcode3;

assign rs1_inst1 = inst1[19:15];
assign rs2_inst1 = inst1[24:20];
assign rd_inst1 = inst1[11:7];

assign rd_inst2 = inst2[11:7];
assign rd_inst3 = inst3[11:7];

assign opcode1 = inst1[6:0];
assign opcode2 = inst2[6:0];
assign opcode3 = inst3[6:0];

always @(*)
	begin
	if(opcode1 === `B_TYPE)
		begin
		if (opcode2 === `R_TYPE || opcode2 === `I_TYPE || opcode2 === `L_TYPE || opcode2 === `JAL || opcode2 === `JALR || opcode2 === `LUI || opcode2 === `AUIPC)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC || opcode3 === 7'b0000000)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 === rs2_inst1))				// =
				begin
					outA = 2'b10;
					outB = 2'b10;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 === rs2_inst1))			// =
				begin
					outA = 2'b01;
					outB = 2'b01;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b10;
					outB = 2'b00;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst2)&&(rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b01;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b00;
					outB = 2'b10;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b01;
					outB = 2'b01;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b10;
					outB = 2'b01;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b01;
					outB = 2'b10;
				end
				else
				begin
					outA = 2'b00;
					outB = 2'b00;
				end
			end
			else if(opcode3 === `S_TYPE || opcode3 === `B_TYPE || opcode3 === 7'b0000000)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b10;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b00;
					outB = 2'b10;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b10;
					outB = 2'b10;
				end
				else
				begin
					outA = 2'b00;
					outB = 2'b00;
				end
			end
			else 
			begin	
					outA = 2'b00;
					outB= 2'b00;
			end
		end
		else if (opcode2 === `S_TYPE || opcode2 === `B_TYPE)
		begin
			if(opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC)
				begin
				if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b01;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b01;
					outB = 2'b00;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b01;
					outB = 2'b01;
				end
			else if (opcode3 === 7'b0000000)
				begin	
					if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b10;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b00;
					outB = 2'b10;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outA = 2'b10;
					outB = 2'b10;
				end
			else
				begin
					outA = 2'b00;
					outB = 2'b00;
				end
			end
		end
		else
			begin
			outA = 2'b00;
			outB = 2'b00;
			end
		end
end
		else
		begin
		outA = 2'b00;
		outB = 2'b00;
	end
	end
	endmodule
