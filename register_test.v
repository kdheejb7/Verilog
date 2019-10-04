`timescale 1ns/1ps

module register_test;

 	reg CLK, RegW, RESET;
	reg [3:0] reg_destination, reg_sr1, reg_sr2;
	reg [31:0] Reg_in;

	wire [31:0] ReadReg1, ReadReg2;

	register r1(
		.CLK(CLK),
		.RegW(RegW),
		.RESET(RESET),
		.DR(reg_destination),
		.SR1(reg_sr1),
		.SR2(reg_sr2),
		.Reg_in(Reg_in),
		.ReadReg1(ReadReg1),
		.ReadReg2(ReadReg2)
	);
	
	initial begin
		forever #25 CLK = ~CLK;
	end

	initial begin
		CLK = 0;
		RESET = 0;
		RegW = 0;
		reg_destination = 0;
		reg_sr1 = 0;
		reg_sr2 = 0;
		Reg_in = 0;

		#100;

		//testcode
	end
endmodule
