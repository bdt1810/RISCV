module IMEM1(inst, PC, clk);
parameter	INST_WIDTH_LENGTH = 32;
parameter	PC_WIDTH_LENGTH = 32;
parameter	MEM_WIDTH_LENGTH = 32;
parameter	MEM_DEPTH = 1<<18;
output	reg	[INST_WIDTH_LENGTH-1:0]inst;
input		[PC_WIDTH_LENGTH-1:0]PC;
input 		clk;

/********* Instruction Memmory *************/
reg		[MEM_WIDTH_LENGTH-1:0]IMEM[0:MEM_DEPTH-1];

wire		[17:0]pWord;
wire		[1:0]pByte;

assign		pWord = PC[19:2];
assign		pByte = PC[1:0];

initial begin
	$readmemb("C:/Users/bdt18/OneDrive/Desktop/pltest1.mem",IMEM);
end

always@(posedge clk)
begin
	if (pByte == 2'b00)
		inst <= IMEM[pWord];
	else
		inst <= 'hz;
end
endmodule
