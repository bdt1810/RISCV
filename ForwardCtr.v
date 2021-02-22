`define R_TYPE		7'b0110011 	//Rs1, Rs2, Rd
`define B_TYPE		7'b1100011 	//Rs1, Rs2
`define S_TYPE		7'b0100011 	//Rs1, Rs2
`define I_TYPE		7'b0010011	//Rs1,      Rd
`define L_TYPE 		7'b0000011	//Rs1,      Rd
`define JAL		7'b1101111	//          Rd
`define JALR		7'b1100111	//          Rd
`define LUI		7'b0110111	//          Rd
`define AUIPC		7'b0010111  	//          Rd

`define	BEQ 	3'b000
`define	BNE	3'b001
`define BLT	3'b100
`define BGE	3'b101
`define BLTU	3'b110
`define BGEU	3'b111
`define ALU	1'b1
`define PC	1'b0

module fforwardCtrlab(outI, outA, outB, outC1, outC2, outC3, outD, outPC, inst0, inst1, inst2, inst3, type, BrEq, BrLT);
input [31:0] inst1, inst2, inst3, inst0;
input [2:0] type;
input BrEq, BrLT;
output reg[1:0] outA, outB, outC1, outC2, outC3, outD;
output reg outPC, outI;
wire [4:0] rs1_inst1, rs2_inst1, rd_inst2, rd_inst3;
wire [4:0] rd_inst1, rs1_inst0, rs2_inst0; //for Load instructrion
wire [6:0] opcode0, opcode1, opcode2, opcode3;
assign rs1_inst1 = inst1[19:15];
assign rs2_inst1 = inst1[24:20];
assign rd_inst1 = inst1[11:7];

assign rd_inst2 = inst2[11:7];
assign rd_inst3 = inst3[11:7];

assign rs1_inst0 = inst0[19:15];
assign rs2_inst0 = inst0[24:20];

reg stall;

assign opcode1 = inst1[6:0];
assign opcode2 = inst2[6:0];
assign opcode3 = inst3[6:0];
assign opcode0 = inst0[6:0];
assign type = inst1[14:12];

always @(*)
begin
	if (opcode1 === `I_TYPE)
	begin
		if (opcode2 === `R_TYPE || opcode2 === `I_TYPE || opcode2 === `L_TYPE || opcode2 === `JAL || opcode2 === `JALR || opcode2 === `LUI || opcode2 === `AUIPC)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `LUI || opcode3 === `AUIPC)
			begin
				if (rs1_inst1 === rd_inst2)
					begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end
				else if(rs1_inst1 === rd_inst3)
					begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end
				else
					begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end
			end
			else if	(opcode3 === `S_TYPE || opcode3 === `B_TYPE)
			begin
				if (rs1_inst1 === rd_inst2)
					begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end
			else if(opcode3 === `JAL || opcode3 === 7'b0000000)
			begin
				if (rs1_inst1 === rd_inst2)
					begin	
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end
				else if (rs1_inst1 === rd_inst3)
					begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end				
			end
				else 		
					begin	
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
					end
			end
			else
				begin
				outI = 1'b0;	
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b00;
				outD = 2'b00;
				outPC = 1'b0;
				end
		end
		else if (opcode2 === `S_TYPE || opcode2 === `B_TYPE)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `L_TYPE || opcode3 === `LUI || opcode3 === `AUIPC|| opcode3 === 7'b0000000)
			begin
				if(rs1_inst1 === rd_inst3)
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			else 
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
		end
	else
	begin		
				outI = 1'b0;		
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b00;
				outD = 2'b00;
				outPC = 1'b0;
	end
	end
	else if(opcode1 === `B_TYPE)
	begin
		begin
	if (opcode2 === `R_TYPE || opcode2 === `I_TYPE || opcode2 === `L_TYPE || opcode2 === `JAL || opcode2 === `JALR || opcode2 === `LUI || opcode2 === `AUIPC || opcode2 === 7'd0)
		begin
			if (opcode3 === `L_TYPE || opcode3 === `R_TYPE || opcode3 === `I_TYPE|| opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 === rs2_inst1))				// =
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b10;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 === rs2_inst1))			// =
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b01;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst2)&&(rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b10;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b01;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b01;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b01;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b10;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
				end
			end
			else if(opcode3 === `S_TYPE || opcode3 === `B_TYPE || opcode3 === 7'b0000000 || opcode3 === `JAL )
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b10;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b10;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
				end
			end
			else stall = 1'b1;
		end
	else if (opcode2 === `S_TYPE || opcode2 === `B_TYPE)
		begin
			if(opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC)
				begin
				if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b01;
				end
			else if (opcode3 === 7'b0000000)
				begin	
					if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b10;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b10;
				end
			else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
				end
			end
		end
		else
			begin
					outI = 1'b0;
				outA = 2'b00;
					outB = 2'b00;
			end
		end
	end
		begin
		if(type ===`BEQ)
			begin
			if (BrEq === 1'b1)
					begin
					outC1 = 2'b00;
					outC2 = 2'b11;
					outC3 = 2'b11;
					outPC = 1'b1;			
					end
				else 
					begin
					outC1 = 2'b00;
					outC2 = 2'b00;
					outC3 = 2'b00;
					outPC = 1'b0;
					end
		end
		else if (type === `BNE)
		begin
			if(BrEq === 1'b0)	
				begin
					outC1 = 2'b00;
					outC2 = 2'b11;
					outC3 = 2'b11;
					outPC = 1'b1;
				end
			else
				begin
					outC1 = 2'b00;
					outC2 = 2'b00;
					outC3 = 2'b00;
					outPC = 1'b0;
				end
		end
		else if( type === `BLT || type === `BLTU)
		begin
			if( BrLT === 1'b1)
			begin
					outC1 = 2'b00;
					outC2 = 2'b11;
					outC3 = 2'b11;
					outPC = 1'b1;
			end
			else
				begin
					outC1 = 2'b00;
					outC2 = 2'b00;
					outC3 = 2'b00;
					outPC = 1'b0;
				end
		end
		else if (type === `BGE || type === `BGEU)
		begin
			if (BrLT === 1'b0)
					outC1 = 2'b00;
					outC2 = 2'b11;
					outC3 = 2'b11;
					outPC = 1'b1;
				end
	
			else
				begin
					outC1 = 2'b00;
					outC2 = 2'b00;
					outC3 = 2'b00;
					outPC = 1'b0;
				end
		end
	end
	else if(opcode1 === `L_TYPE)
	begin
		if (opcode0 === `R_TYPE || opcode0 === `B_TYPE || opcode0 === `S_TYPE)
			begin
				if( rs2_inst0 === rd_inst1 || rs1_inst0 === rd_inst1 ) 
				begin
					outI = 1'b1;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b10;
					outC2 = 2'b11;
					outC3 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outC3 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
		else if(opcode0 === `I_TYPE || opcode0 === `JAL || opcode0 === `JALR)
			begin
				if(rd_inst1 === rs1_inst0)
				begin
					outI = 1'b1;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b10;
					outC2 = 2'b11;
					outC3 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outC3 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
		else 
			begin
			outI = 1'b0;
			outA = 2'b00;
			outB = 2'b00;
			outC1 = 2'b00;
			outC2 = 2'b00;
			outC3 = 2'b00;
			outD = 2'b00;
			outPC = 1'b0;
			end
		
	end
	else if(opcode1 === `JAL)
	begin 
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outPC = 1'b1;
					outC2  = 2'b11;
					outD = 2'b00;
	end
	
	else if(opcode1 === `JALR)
	begin
		if (opcode2 === `R_TYPE || opcode2 === `I_TYPE || opcode2 === `L_TYPE || opcode2 === `JAL || opcode2 === `JALR || opcode2 === `LUI || opcode2 === `AUIPC)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC|| opcode3 === 7'b0000000)
			begin
				if (rs1_inst1 === rd_inst2)
					begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outD = 2'b00;
					outC2 = 2'b11;
					outPC = 1'b1;
					end
				else if(rs1_inst1 === rd_inst3)
					begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC2 = 2'b11;
					outC1 = 2'b00;
					outD = 2'b00;
					outPC = 1'b1;
					end
				else
					begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b11;
					outD = 2'b00;
					outPC = 1'b1;
					end
			end
			else if	(opcode3 === `S_TYPE || opcode3 === `B_TYPE|| opcode3 === 7'b0000000)
			begin
				if (rs1_inst1 === rd_inst2)
					begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b11;
					outD = 2'b00;
					outPC = 1'b1;
					end
				else 		
					begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b11;
					outD = 2'b00;
					outPC = 1'b1;
					end
			end
			else
				begin	
				outI = 1'b0;
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b11;
				outD = 2'b00;
				outPC = 1'b1;
				end
		end
		else if (opcode2 === `S_TYPE || opcode2 === `B_TYPE)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `L_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC|| opcode3 === 7'b0000000)
			begin
				if(rs1_inst1 === rd_inst3)
				begin
					outI = 1'b0;
				outA = 2'b01;
				outB = 2'b00;
				outC1 = 2'b00;
				outD = 2'b00;
				outC2 = 2'b11;
				outPC = 1'b1;
				end
			else 
				begin
					outI = 1'b0;
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b11;
				outD = 2'b00;
				outPC = 1'b1;
				end
			end
		end
		else
		begin		
					outI = 1'b0;		
		outA = 2'b00;
		outB = 2'b00;
		outC1 = 2'b00;
		outC1 = 2'b11;
		outD = 2'b00;
		outPC = 1'b1;
		end
	end
	else if (opcode1 === `S_TYPE)
	begin
		if (opcode2 === `R_TYPE || opcode2 === `I_TYPE || opcode2 === `L_TYPE || opcode2 === `JAL || opcode2 === `JALR || opcode2 === `LUI || opcode2 === `AUIPC)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC || opcode3 === 7'b0000000)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 === rs2_inst1))				// =
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b10;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 === rs2_inst1))			// =
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b01;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst2)&&(rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b10;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b01; 
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b01;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b10;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
			else if(opcode3 === `S_TYPE || opcode3 === `B_TYPE || opcode3 === 7'b0000000)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b10;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b10;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
			else stall = 1'b1;
		end
		else if (opcode2 === `S_TYPE || opcode2 === `B_TYPE)
		begin
			if(opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC|| opcode3 === 7'b0000000)
				begin
				if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b01;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				end
		end
		else
			begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
			end
		end
	else if (opcode1 === `R_TYPE || opcode1 === `JALR || opcode1 === `LUI || opcode1 === `AUIPC)
	begin
		if (opcode2 === `R_TYPE || opcode2 === `I_TYPE || opcode2 === `L_TYPE || opcode2 === `JAL || opcode2 === `JALR || opcode2 === `LUI || opcode2 === `AUIPC)
		begin
			if (opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 === rs2_inst1))				// =
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 === rs2_inst1))			// =
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b01;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst2)&&(rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b01;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b01;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b01;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
			else if(opcode3 === `S_TYPE || opcode3 === `B_TYPE || opcode3 === 7'b0000000)
			begin
				if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
			else stall = 1'b1;
		end
		else if (opcode2 === `S_TYPE || opcode2 === `B_TYPE)
		begin
			if(opcode3 === `R_TYPE || opcode3 === `I_TYPE || opcode3 === `JAL || opcode3 === `JALR || opcode3 === `LUI || opcode3 === `AUIPC)
				begin
				if ((rs1_inst1 === rd_inst3) && (rs2_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst3) && (rs1_inst1 !== rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst3) && (rs2_inst1 === rd_inst3) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b01;
					outB = 2'b01;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			else if (opcode3 === 7'b0000000)
				begin	
					if ((rs1_inst1 === rd_inst2) && (rs2_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs2_inst1 === rd_inst2) && (rs1_inst1 !== rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
				else if ((rs1_inst1 === rd_inst2) && (rs2_inst1 === rd_inst2) && (rs1_inst1 !== rs2_inst1))
				begin
					outI = 1'b0;
					outA = 2'b10;
					outB = 2'b10;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			else
				begin
					outI = 1'b0;
					outA = 2'b00;
					outB = 2'b00;
					outC1 = 2'b00;
					outC2 = 2'b00;
					outD = 2'b00;
					outPC = 1'b0;
				end
			end
		end
		else
			begin
			outI = 1'b0;
			outA = 2'b00;
			outB = 2'b00;
			outC1 = 2'b00;
			outC2 = 2'b00;
			outD = 2'b00;
			outPC = 1'b0;
			end
		end
	end
	else if(opcode1 === 7'd0)
	begin
		if(opcode2 === `JAL || opcode2 === `B_TYPE)
			if( opcode3 === `L_TYPE)
			begin
				outI = 1'b1;
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b00;
				outC3 = 2'b00;
				outD = 2'b00;
				outPC = 1'b0;
			end
			else
			begin
				outI = 1'b0;
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b00;
				outC3 = 2'b00;
				outD = 2'b00;
				outPC = 1'b0;
			end
		else
			begin
				outI = 1'b0;
				outA = 2'b00;
				outB = 2'b00;
				outC1 = 2'b00;
				outC2 = 2'b00;
				outC3 = 2'b00;
				outD = 2'b00;
				outPC = 1'b0;
			end
	end
	else
	begin
		outI = 1'b0;
		outA = 2'b00;
		outB = 2'b00;
		outC1 = 2'b00;
		outC2 = 2'b00;
		outC3 = 2'b00;
		outD = 2'b00;
		outPC = 1'b0;
	end
end
endmodule
