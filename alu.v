module alu(
    input [31:0] A,B,  // ALU 32-bit Inputs                 
    input [3:0] ALU_Sel,// ALU Selection
    output [31:0] ALU_Out);
    reg [31:0] ALU_Result;
    wire [32:0] tmp;
    wire signed [31:0] A_signed;
    assign A_signed = A;
    assign ALU_Out = ALU_Result; // ALU out
    always @(*)
    begin
        case(ALU_Sel)
        4'b0000: // Addition
           	ALU_Result = A + B ; 
        4'b0001: // Subtraction
           	ALU_Result = A - B ;
        4'b0010: //  Logical and 
           	ALU_Result = A & B;
        4'b0011: //  Logical or
           	ALU_Result = A | B;
        4'b0100: //  Logical xor 
           	ALU_Result = A ^ B;
	4'b0101: //  Shift left logical
	   	ALU_Result = A << B;
	4'b0110: // Shift right logical
	   	ALU_Result = A >> B;
	4'b0111: // Shitf right arithmetic with A signed;
       		ALU_Result = A_signed >>> B;
	4'b1001: // Signed compare 
		ALU_Result = (A<B)?32'b1:32'b0;
	4'b1010: // Unsigned compare
		ALU_Result = ($unsigned(A) < $unsigned (B)) ? 32'b1:32'b0;
        default: ALU_Result = 32'hzzzz_zzzz; 
        endcase

    end

endmodule
