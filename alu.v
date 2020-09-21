module alu(ALU_Out, ALU_Sel, tmpA, tmpB);
    input [31:0] tmpA, tmpB;  // ALU 32-bit Inputs                 
    input [3:0] ALU_Sel;// ALU Selection
    output [31:0] ALU_Out;	
    reg [31:0] ALU_Result;
    assign ALU_Out = ALU_Result; // ALU out
    always @(*)
    begin
        case(ALU_Sel)
        4'b0000: // Addition
           	ALU_Result = tmpA + tmpB ; 
        4'b0001: // Subtraction
           	ALU_Result = tmpA - tmpB ;
        4'b0010: //  Logical and 
           	ALU_Result = tmpA & tmpB;
        4'b0011: //  Logical or
           	ALU_Result = tmpA | tmpB;
        4'b0100: //  Logical xor 
           	ALU_Result = tmpA ^ tmpB;
	4'b0101: //  Shift left logical
	   	ALU_Result = tmpA << tmpB;
	4'b0110: // Shift right logical
	   	ALU_Result = tmpA >> tmpB;
	4'b0111: // Shitf right arithmetic with A signed;
		ALU_Result = $signed(tmpA) >>> $unsigned(tmpB);
	4'b1001: // Signed compare 
		ALU_Result = ($signed(tmpA)<$signed(tmpB))?32'b1:32'b0;
	4'b1010: // Unsigned compare
		ALU_Result = ($unsigned(tmpA) < $unsigned (tmpB)) ? 32'b1:32'b0;
        default: ALU_Result = 32'h0; 
        endcase
    end

endmodule
