`define R		5'b01100
`define I		5'b00100
`define L		5'b00000
`define S		5'b01000
`define B		5'b11000
`define JAR		5'b11011
`define JALR		5'b11001
`define LUI		5'b01101
`define AUIPC		5'b00101
	
`define PC1		1'b0
`define ALU1		1'b1 

`define ENABLE  	1'b1
`define DISABLE		1'b0

`define REGISTER	1'b1
`define PC		1'b0
`define IMM		1'b0

`define ADD		4'b0000
`define SUB		4'b0001	
`define COM		4'b0010
`define COMU		4'b0011
`define XOR		4'b0100
`define OR		4'b0101
`define AND		4'b0110
`define SRL		4'b0111
`define SLL		4'b1000
`define SRA		4'b1001

`define SE20_UI 	3'b001
`define SE12_LI 	3'b010
`define SE05    	3'b011
`define SE12_BR 	3'b100
`define SE12_ST 	3'b101
`define SE20_JP 	3'b110

`define PC2		2'b10
`define ALU2		2'b01
`define MEM		2'b00

`define LW   		3'b000 
`define LH   		3'b001 
`define LB   		3'b010 
`define LHU  		3'b011 
`define LBU  		3'b100 

`define SW		2'b00
`define SH		2'b01
`define SB		2'b00

module rom (ins, BrEq, BrLT, PCsel, Immsel, BrUN, Asel, Bsel, ALUsel, MemRW, RegWEn, Memsel, MemCtr, WBsel,temp);
	input [8:0] ins;
	input BrEq, BrLT;
	output reg PCsel, BrUN, Asel, Bsel, MemRW, RegWEn;
	output reg [3:0] ALUsel;
	output reg [2:0] Immsel, Memsel;
	output reg [1:0] WBsel, MemCtr;
	output reg [19:0] temp;
	
	always @(*)
	begin
		case(ins[4:0])
			`R:	case(ins[7:5])						// R TYPE
					3'b000: case(ins[8]) 				// ADD + SUB
							1'b0:	begin			// ADD
								BrUN = 1'b0;
								PCsel = `PC1;
								Immsel = 0'b000;
								RegWEn = `ENABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = `ALU2;	
								end
		  					
	
						 	1'b1:	begin			// SUB
								BrUN = 1'b0;
								PCsel = `PC1;
								Immsel = 0'b000;
								RegWEn = `ENABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `SUB;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = `ALU2;
								end	
						endcase	
					3'b001: begin					// SLL
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = 0'b000;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `REGISTER;	
						ALUsel = `SLL;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b010: begin					// SLT
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = 0'b000;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `REGISTER;	
						ALUsel = `COM;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b011: begin					// SLTU
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = 0'b000;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `REGISTER;	
						ALUsel = `COMU;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b100: begin					// XOR
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = 0'b000;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `REGISTER;	
						ALUsel = `XOR;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b101: case(ins[8])				// SRL + SRA
							1'b0: 	begin			// SRL
								BrUN = 1'b0;
								PCsel = `PC1;
								Immsel = 0'b000;
								RegWEn = `ENABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `SRL;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = `ALU2;
								end

							1'b1:	begin			// SRA
								BrUN = 1'b0;
								PCsel = `PC1;
								Immsel = 0'b000;
								RegWEn = `ENABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `SRA;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = `ALU2;
								end
						endcase
					
					3'b110: begin					// OR
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = 0'b000;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `REGISTER;	
						ALUsel = `OR;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end
					
					3'b111: begin					// AND
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = 0'b000;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `REGISTER;	
						ALUsel = `AND;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end
				endcase
	
			`I:	case(ins[7:5])						// I TYPE
					3'b000:	begin					// ADDI
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b010:	begin					// SLTI
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `COM;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end
					
					3'b011:	begin					// SLTIU
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `COMU;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end
					
					3'b100:	begin					// XORI
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `XOR;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b110:	begin					// ORI
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `OR;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b000:	begin					// ANDI
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `AND;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end

					3'b001:	begin					// SLLI
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE05;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `SLL;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = 3'b000;
						WBsel = `ALU2;
						end
				
					3'b101: case(ins[8])				// SRLI + SRAI
							1'b0:	begin			// SRLI					
								BrUN = 1'b0;
								PCsel = `PC1;
								Immsel = `SE05;
								RegWEn = `ENABLE;		
								Asel = `REGISTER;					
								Bsel = `IMM;	
								ALUsel = `SRL;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = `ALU2;
								end
							
							1'b1:	begin			// SRAI
								BrUN = 1'b0;
								PCsel = `PC1;
								Immsel = `SE05;
								RegWEn = `ENABLE;		
								Asel = `REGISTER;					
								Bsel = `IMM;	
								ALUsel = `SRA;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = `ALU2;		
								end
						endcase
				endcase

			`L:	case(ins[7:5])						// L TYPE
					3'b000: begin					// LB
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = `LB;
						WBsel = `MEM;
						end

					3'b001: begin					// LH
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = `LH;
						WBsel = `MEM;
						end
					
					3'b010: begin					// LW
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = `LW;
						WBsel = `MEM;
						end
					
					3'b100: begin					// LBU
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = `LBU;
						WBsel = `MEM;
						end

					3'b101: begin					// LHU
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_LI;
						RegWEn = `ENABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = 2'b00;
						MemRW =	`DISABLE;
						Memsel = `LHU;
						WBsel = `MEM;
						end
				endcase		
			
			`S:	case(ins[7:5])						// S TYPE
					3'b000: begin					// SB
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_ST;
						RegWEn = `DISABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = `SB;
						MemRW =	`ENABLE;
						Memsel = 3'b000;
						WBsel = 2'b00;
						end

					3'b001: begin					// SH
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_ST;
						RegWEn = `DISABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = `SH;
						MemRW =	`ENABLE;
						Memsel = 3'b000;
						WBsel = 2'b00;
						end
					
					3'b010: begin					// SW
						BrUN = 1'b0;
						PCsel = `PC1;
						Immsel = `SE12_ST;
						RegWEn = `DISABLE;		
						Asel = `REGISTER;					
						Bsel = `IMM;	
						ALUsel = `ADD;		
						MemCtr = `SW;
						MemRW =	`ENABLE;
						Memsel = 3'b000;
						WBsel = 2'b00;
						end
				endcase		

			`B:	case(ins[7:5])						// B TYPE 
					3'b000: case(BrEq)				// BREQ
							1'b0:	begin			// NOT EQUAL
								BrUN = `DISABLE;
								PCsel = `PC1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end

							1'b1:	begin			// EQUAL
								BrUN = `DISABLE;
								PCsel = `ALU1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end
						endcase

					3'b001: case(BrEq)				// BRNE
							1'b0: 	begin			// NOT EQUAL	
								BrUN = `DISABLE;
								PCsel = `ALU1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end	
							
							1'b1:	begin			// EQUAL
								BrUN = `DISABLE;
								PCsel = `PC1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end
						endcase

					3'b100: case(BrLT)				// BRLT
							1'b0: 	begin			// GREATER OR EQUAL	
								BrUN = `DISABLE;
								PCsel = `PC1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end	
							
							1'b1:	begin			// LESS THAN
								BrUN = `DISABLE;
								PCsel = `ALU1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end
						endcase		

					3'b101: case(BrLT)				// BRGE
							1'b0: 	begin			// GREATER OR EQUAL	
								BrUN = `DISABLE;
								PCsel = `ALU1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end	
							
							1'b1:	begin			// LESS THAN
								BrUN = `DISABLE;
								PCsel = `PC1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end
						endcase	
					
					3'b110: case(BrLT)				// BRLTU
							1'b0:	begin			// GREATER OR EQUAL
								BrUN = `ENABLE;
								PCsel = `PC1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;	
								end

							1'b1: 	begin			// LESS THAN
								BrUN = `ENABLE;
								PCsel = `ALU1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end
						endcase

					3'b111: case(BrLT)				// BRGEU
							1'b0:	begin			// GREATER OR EQUAL
								BrUN = `ENABLE;
								PCsel = `ALU1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;	
								end

							1'b1: 	begin			// LESS THAN
								BrUN = `ENABLE;
								PCsel = `PC1;
								Immsel = `SE12_BR;
								RegWEn = `DISABLE;		
								Asel = `REGISTER;					
								Bsel = `REGISTER;	
								ALUsel = `ADD;		
								MemCtr = 2'b00;
								MemRW =	`DISABLE;
								Memsel = 3'b000;
								WBsel = 2'b00;
								end
						endcase
				endcase			

			`JAR:	begin							// JAR
				BrUN = 1'b0;
				PCsel = `ALU1;
				Immsel = `SE20_JP;
				RegWEn = `ENABLE;		
				Asel = `PC;					
				Bsel = `IMM;	
				ALUsel = `ADD;		
				MemCtr = 2'b00;
				MemRW =	`DISABLE;
				Memsel = 3'b000;
				WBsel = `PC2;
				end

			`JALR: 	begin							// JALR	
				BrUN = 1'b0;
				PCsel = `ALU1;
				Immsel = `SE12_LI;
				RegWEn = `ENABLE;		
				Asel = `REGISTER;					
				Bsel = `IMM;	
				ALUsel = `ADD;		
				MemCtr = 2'b00;
				MemRW =	`DISABLE;
				Memsel = 3'b000;
				WBsel = `PC2;
				end

			`LUI: 	begin							// LUI
				BrUN = 1'b0;
				PCsel = `PC1;
				Immsel = `SE20_UI;
				RegWEn = `ENABLE;		
				Asel = `REGISTER;					
				Bsel = `IMM;	
				ALUsel = `ADD;		
				MemCtr = 2'b00;
				MemRW =	`DISABLE;
				Memsel = 3'b000;
				WBsel = `ALU2;
				end

			`AUIPC: begin							// AUIPC
				BrUN = 1'b0;
				PCsel = `PC1;
				Immsel = `SE20_UI;
				RegWEn = `ENABLE;		
				Asel = `PC;					
				Bsel = `IMM;	
				ALUsel = `ADD;		
				MemCtr = 2'b00;
				MemRW =	`DISABLE;
				Memsel = 3'b000;
				WBsel = `ALU2;
				end

			default:	begin
					BrUN = 1'b0;
					PCsel = `PC1;
					Immsel = 3'b000;
					RegWEn = `DISABLE;
					Asel = 1'b0;
					Bsel = 1'b0;
					ALUsel = 4'b0000;
					MemCtr = 2'b00;
					MemRW = `DISABLE;
					Memsel = 3'b000;
					WBsel = 2'b00;
					end	
		endcase
	end
endmodule
