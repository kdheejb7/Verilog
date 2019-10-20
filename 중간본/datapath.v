module dataPath(instruction, _CLK, RESET, PC);
	input [15:0] instruction;
	input _CLK, RESET;
	output [31:0] PC;

	wire CLK;
	wire [31:0] aluOutput;
	wire [31:0] readData1, readData2;
	wire [31:0] imm;
	wire ALUSrc, MemWrite, MemRead, Branch, MemToReg, RegWrite, Zero;
	wire [2:0] ALUControl;
	wire [31:0] writeData;
	wire [31:0] dataToWrite;
	
	assign dataToWrite = MemToReg ? writeData : aluOutput;
	
	//?? ?? ???? ??? ? ? ?? ? ?? ? ???...?
	//PC pc(Branch, CLK, imm, RESET, PC);
	clockDivider cd(_CLK, CLK);
	ALU alu(readData1, readData2, imm, ALUSrc, ALUControl,Zero, aluOutput);  
	Controller controller(instruction[15:13], instruction[12:10], ALUSrc, MemWrite, MemRead, Branch, MemToReg, RegWrite, ALUControl);
	//memory dataMemory(aluOutput, readData2, MemRead, MemWrite, CLK, RESET, writeData);
	SignExtender se(instruction[9:0], imm);
	Register regsister(CLK, ALUSrc, regWrite, imm, RESET, readData1, readData2);
endmodule
