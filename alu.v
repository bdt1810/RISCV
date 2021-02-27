module alu(ALU_Out, ALU_Sel, tmpA, tmpB);
    input [31:0] tmpA, tmpB;  // ALU 32-bit Inputs                 
    input [3:0] ALU_Sel;// ALU Selection
    output reg[31:0] ALU_Out;	
    always @(*)
    begin
        case(ALU_Sel)
        4'b0000: // Addition
           	ALU_Out = tmpA + tmpB ; 
        4'b0001: // Subtraction
           	ALU_Out = tmpA - tmpB ;
        4'b0010: //  Logical and 
           	ALU_Out = tmpA & tmpB;
        4'b0011: //  Logical or
           	ALU_Out = tmpA | tmpB;
        4'b0100: //  Logical xor 
           	ALU_Out = tmpA ^ tmpB;
	4'b0101: //  Shift left logical
	   	ALU_Out = tmpA << tmpB;
	4'b0110: // Shift right logical
	   	ALU_Out = tmpA >> tmpB;
	4'b0111: // Shitf right arithmetic with A signed;
		ALU_Out = $signed(tmpA) >>> $unsigned(tmpB);
	4'b1001: // Signed compare 
		ALU_Out = ($signed(tmpA) < $signed(tmpB)) ? 32'd1:32'd0;
	4'b1010: // Unsigned compare
		ALU_Out = ($unsigned(tmpA) < $unsigned (tmpB)) ? 32'd1:32'd0;
	4'b1111:
		ALU_Out = 32'd0;
        default: ALU_Out = 32'd0; 
        endcase
    end

endmodule
