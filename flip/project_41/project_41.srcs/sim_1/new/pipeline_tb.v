`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2023 17:42:22
// Design Name: 
// Module Name: pipeline_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipeline_tb;
reg clk1,clk2;
wire [31:0]MEM_WB_ALUOUT,MEM_WB_IR,EX_MEM_ALUOUT;
integer k;
pipe_mips32 A1(clk1,clk2,MEM_WB_ALUOUT,MEM_WB_IR,EX_MEM_ALUOUT);
initial
begin
clk1=0;clk2=0;
repeat(20)
begin
#5 clk1=1;
#5 clk1=0;
#5 clk2=1;
#5 clk2=0;
end
end

initial
begin
for(k=0;k<31;k=k+1)
pipe_mips32.Reg[k]=k;
pipe_mips32.Mem[0]=32'h2801000a;
pipe_mips32.Mem[1]=32'h28020014;
pipe_mips32.Mem[2]=32'h28030019;
pipe_mips32.Mem[3]=32'h0ce77800;
pipe_mips32.Mem[4]=32'h0ce77800;
pipe_mips32.Mem[5]=32'h00222000;
pipe_mips32.Mem[6]=32'h0ce77800;
pipe_mips32.Mem[7]=32'h00832800;
pipe_mips32.Mem[8]=32'hfc000000;


pipe_mips32.HALTED=0;
pipe_mips32.PC=0;
pipe_mips32.TAKEN_BRANCH=0;

#280
for(k=0;k<6;k=k+1)
$display("R%1d - %2d",k,pipe_mips32.Reg[k]);
end

initial
begin
$dumpfile("mips.vcd");
$dumpvars(0,pipeline_tb);
#300
$finish;
end
endmodule

