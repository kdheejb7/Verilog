module datapathTest;
	//input
	reg [15:0] instruction;
	reg _CLK;
	reg RESET;

	//output
	wire [7:0] PC;

	//Instantiate the Unit Under Test(UUT)
	dataPath uut(
		.instruction(instruction),
		._CLK(_CLK),
		.RESET(RESET),
		.PC(PC)
	);

	reg[15:0] instructions[0:5];	
	initial begin
		instructions[0] = 16'b0000000000000000;	//group1, add
		instructions[1] = 16'b0000010000000000;	//group1, sub
		instructions[2] = 16'b1000000000001101; //group2, addi
		instructions[3] = 16'b1000010000000111; //group2, subi
		instructions[4] = 16'b0100111111111111; //group6, branch zero
		instructions[5] = 16'b0000001110101011;	//group1, add

		forever #10 _CLK = ~_CLK;
	end

	initial begin
		//initialize inputs
		instruction = 0;
		_CLK = 0;
		RESET = 0;

		//wait 100ns for global reset to finish
		#100;
		#20 RESET = 1;
		#10;
		RESET = 0;
	end

	always@(posedge _CLK) begin
		instruction = instructions[PC];
	end
endmodule 