module Stack(CLK, push, pop, d, q);
	parameter WIDTH = 32;		//register size
	parameter DEPTH = 16;		//the number of register
	
	input CLK;
	input [1:0] push, pop;
	input [WIDTH-1:0] d;
	output reg[WIDTH-1:0] q;
	
	reg [DEPTH-1:0] ptr;
	reg [WIDTH-1:0] stack[0:DEPTH-1];	
	integer i;
	initial begin
		for(i=0; i<DEPTH; i=i+1)
			stack[i]=0;
		stack[0] = 32'b11;
		stack[1] = 32'b100;
		q = stack[1];
		ptr = 2;
	end
	always@(pop or push or posedge CLK)begin
		$display("pop %b", pop);
		if(push) ptr <= ptr+1;
		else if(pop) ptr <= ptr-1;	

		if(push||pop) begin
			if(push) stack[ptr] <= d;
			else stack[ptr-1] <= 32'b0;
			q <= stack[ptr-1];
			
		end
	end
/*
	always@(pop or push or posedge CLK)begin
		if(push||pop) begin
			if(push) stack[ptr] <= d;
			else stack[ptr-1] <= 32'b0;
			q <= stack[ptr-1];
			
		end
	end
*/
endmodule

module Register (CLK, ALUSrc, regWrite, imm ,RESET, readData1, readData2);
	input regWrite, CLK, RESET;
	input ALUSrc, regWrite;
	input [31:0] imm;
	//input [31:0] regWriteData;
	output reg[31:0] readData1, readData2;
	wire _CLK;
	reg [1:0] _push, _pop;
	reg [31:0] _d,temp;
	wire [31:0] _q;
/*
	initial begin  
		_CLK=0; _push=1; _pop=0; _d=32'b11;
		#5 _CLK=1;
		#5 _CLK=0; _push=1; _pop=0; _d=32'b100;
		#5 _CLK=1;
		#5 _CLK =0;

	end
	*/
	assign _CLK=CLK;	
	always@(posedge CLK)begin
		_pop = 1; _push = 0; assign readData1 = _q;
	end
	always@(posedge CLK)begin
		if(ALUSrc) readData2 = imm;
		else begin
			if(1) _pop<=11; _push<=0; readData2 <= readData1;
			//readData2 = temp; 
			$display($time,"is current time^^");
			//readData2 = _q;
		end 

	end
		

	/*	
		if(ALUSrc) readData2 = imm;
		else begin
			#5 _pop=11; _push=0; readData1 = _q;
			$display($time,"is current time^^");
			//readData2 = _q;
		end
*/
		
	
		

	Stack S1(_CLK, _push, _pop, _d, _q);
endmodule

/*
module testbench();
	reg _CLK, _push, _pop;
	reg [31:0] _d;
	wire [31:0] _q;

	initial begin
		_CLK=0; _push=1; _pop=0; _d=32'b11;
		#5 _CLK=1;
		#5 _CLK=0; _push=1; _pop=0; _d=32'b100;
		#5 _CLK=1;
		#5 _CLK=0; _push=1; _pop=0; _d=32'b111;
		#5 _CLK=1;
		#5 _CLK=0; _push=0; _pop=1; _d=32'b100;
		#5 _CLK=1;
		#5 _CLK=0; _push=0; _pop=1; _d=32'b100;
		#5 _CLK=1;

	end
	Stack S1(_CLK, _push, _pop, _d, _q);
endmodule
*/
module register(
	input [5:4] read_register1,
	input [3:2] read_register2,
	input [1:0] destination_register,
	input regdst,
	input [7:0] regWriteData,
	input regWrite,
	input CLK,
	input RESET,
	
	output [7:0] readData1,
	output [7:0] readData2
	);
	reg [7:0] registers[0:3];
	assign readData1 = registers[read_register1];
	assign readData2 = registers[read_register2];
	
	always@(posedge CLK or posedge RESET)begin
		if(RESET) begin
			registers[0] = 0;
			registers[1] = 0;
			registers[2] = 0;
			registers[3] = 0;		
		end
		else begin
			if(regWrite)begin
				registers[regdst ? destination_register: read_register2] = regWriteData;
			end		
		end
	end
endmodule
