module register(AddrD,AddrA,AddrB,DataD,RegWEn,DataA,DataB,clk);

input wire[4:0] AddrD,AddrA,AddrB;
input wire[31:0] DataD;
input clk;
input RegWEn;
output reg[31:0] DataA,DataB;
reg [31:0] R [0:31];
integer i;

initial 
begin
	for (i=0; i<32; i=i+1)
		R[i] <= 32'h0;	
end
          
always @(negedge clk)
begin
	if (RegWEn == 1 && AddrD !== 5'h0)                     
        begin                     
		R[AddrD] <= DataD;
        end
end

always @(posedge clk)
begin
	DataA <= R[AddrA];
	DataB <= R[AddrB];
end
endmodule
