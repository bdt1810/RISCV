module pre_add(addr, PC, Imm);
input [31:0] PC, Imm;
output [31:0] addr;
assign addr = PC + Imm - 4;
endmodule
