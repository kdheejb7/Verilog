module ALU_R(inst, f);
	input [31:0] inst;
	output f;

	wire[31:0] iword;		//instruction unit
	wire[3:0] rd, rs1, rs2; 	//register
	wire[15:0] imm;			//immediate
	wire[3:0] fn;			//secondary opcode
	wire[3:0] opcode; 		//opcode

	assign opcode = iword[3:0];
	assign fn = iword[7:4];
	assign imm = iword[23;8];
	assign rs2 = iword[20:23];
	assign rs1 = iword[27:24];
	assign rd1 = iword[28:31];

