 `define R		5'b01100
`define I		5'b00100
`define L		5'b00000
`define S		5'b01000
`define B		5'b11000
`define JAR		5'b11011
`define JALR		5'b11001
`define LUI		5'b01101
`define AUIPC		5'b00101
	
/*
`define PC1		1'b0
`define ALU1		1'b1 C:/Users/bdt18/OneDrive/Desktop/New folder/control.v

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
`define SE12_BR 	3'b100C:/Users/bdt18/OneDrive/Desktop/New folder/control.v
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
*/

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
							1'b0:	temp = 20'h04001;	// ADD
		  					
	
						 	1'b1:	temp = 20'h04101;	// SUB	
						endcase	

					3'b001: temp = 20'h04801;			// SLL

					3'b010: temp = 20'h04201;			// SLT

					3'b011: temp = 20'h04301;			// SLTU

					3'b100: temp = 20'h04401;			// XOR

					3'b101: case(ins[8])				// SRL + SRA
							1'b0: 	temp = 20'h04701;	// SRL

							1'b1:	temp = 20'h04901;	// SRA
						endcase
					
					3'b110:	temp = 20'h04501;			// OR
					
					3'b111: temp = 20'h04601;			// AND
				endcase
	
			`I:	case(ins[7:5])						// I TYPE
					3'b000:	temp = 20'h15001;			// ADDI

					3'b010:	temp = 20'h15201;			// SLTI
					
					3'b011:	temp = 20'h15301;			// SLTIU
					
					3'b100:	temp = 20'h15401;			// XORI

					3'b110:	temp = 20'h15501;			// ORI

					3'b000:	temp = 20'h15601;			// ANDI

					3'b001:	temp = 20'h1D801;			// SLLI
				
					3'b101: case(ins[8])				// SRLI + SRAI
							1'b0:	temp = 20'h1D701;	// SRLI
							
							1'b1:	temp = 20'h1D901;	// SRAI
						endcase
				endcase

			`L:	case(ins[7:5])						// L TYPE
					3'b000: temp = 20'h15008;			// LB

					3'b001: temp = 20'h15004;			// LH
					
					3'b010: temp = 20'h15000;			// LW
					
					3'b100: temp = 20'h15010;			// LBU

					3'b101: temp = 20'h1500C;			// LHU
				endcase
			
			`S:	case(ins[7:5])						// S TYPE
					3'b000: temp = 20'h29020;			// SB

					3'b001: temp = 20'h29060;			// SH
					
					3'b010: temp = 20'h290A0;			// SW
				endcase		

			`B:	case(ins[7:5])						// B TYPE 
					3'b000: case(BrEq)				// BREQ
							1'b0:	temp = 20'h20000;	// NOT EQUAL

							1'b1:	temp = 20'h60000;	// EQUAL
						endcase

					3'b001: case(BrEq)				// BRNE
							1'b0: 	temp = 20'h60000;	// NOT EQUAL
							
							1'b1:	temp = 20'h20000;	// EQUAL
						endcase

					3'b100: case(BrLT)				// BRLT
							1'b0: 	temp = 20'h20000;	// GREATER OR EQUAL	
							
							1'b1:	temp = 20'h60000;	// LESS THAN
						endcase		

					3'b101: case(BrLT)				// BRGE
							1'b0: 	temp = 20'h60000;	// GREATER OR EQUALC:/Users/bdt18/OneDrive/Desktop/New folder/control.v
							
							1'b1:	temp = 20'h20000;	// LESS THAN
						endcase	
					
					3'b110: case(BrLT)				// BRLTU
							1'b0:	temp = 20'hA0000;	// GREATER OR EQUAL

							1'b1: 	temp = 20'hE0000;	// LESS THAN
						endcase

					3'b111: case(BrLT)				// BRGEU
							1'b0:	temp = 20'hE0000;	// GREATER OR EQUAL

							1'b1: 	temp = 20'hA0000;	// LESS THAN
						endcase
				endcase			

			`JAR:	temp = 20'h77002;					// JAR

			`JALR: 	temp = 20'h55002;					// JALR

			`LUI: 	temp = 20'h0D001;					// LUI

			`AUIPC: temp = 20'h0F001;					// AUIPC

			default:	temp = 20'h00000;				// DEFAULT
		endcase
		
		BrUN 	= temp[19];
		PCsel 	= temp[18];
		Immsel	= temp[17:15];
		RegWEn 	= temp[14];
		Asel 	= temp[13];
		Bsel	= temp[12];
		ALUsel	= temp[11:8];
		MemCtr	= temp[7:6];
		MemRW	= temp[5];
		Memsel	= temp[4:2];
		WBsel	= temp[1:0];
	end
endmodule
