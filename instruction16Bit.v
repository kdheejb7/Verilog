`timescale 1ns/1ps

module instruction16Bit(instruction, f);
	input [15:0] instruction;
	output [31:0] f;

	wire [2:0] op1, op2;
	wire [9:0] imm;
	assign imm = instruction[9:0];
	assign op2 = instruction[12:10];	//operation
	assign op1 = instruction[15:13];	//group
	wire [31:0] temp;
	stack S1(.push(0), .pop(0), .d(0), .reset(1));
	

	always@(op1) begin
		case(op1)
			3'b000: group1_2 g1(op1, op2, imm);
			3'b001: group1_2 g2(op1, op2, imm);
			3'b010: stack S1(.push(1), .pop(0), .d({22'b0,imm}), .q(f), .reset(0));
			//3'b011: //pop
			3'b100: group5 g5(op2);
			3'b101: group6 g6(op2);
			//3'b110: //push_pc
			//3'b111: //pop_pc
			default: ;
		endcase
	end
		
endmodule

module group1_2(opcode1, opcode2, imm, f);
	input[2:0] opcode1, opcode2;
	input[9:0] imm;
	reg[31:0] s1, s2;
	
	wire [31:0] temp;
	output f;	
	stack ST1(.push(0), .pop(1), .d(0), .q(s1));

	always@(*)begin
		if(opcode1==3'b000) stack ST2(.push(0), .pop(1), .d(0), .q(s2), .reset(0)); //group1
		else s2 <= {22'b0,imm};	//group2, 22+10=32
		case(opcode2)
			3'b000: f = s1 + s2;	
			3'b001: f = s1 - s2;
			3'b010: f = s1;	//neg how?
			3'b011: f = s1 * s2;
			3'b100: f = s1 & s2;
			3'b101: f = s1 | s2;
			3'b110: f = s1 ^ s2;
			3'b111: f = ~s1;	//not
		endcase
	end
	stack S3(.push(1), .pop(0), .d(f));

endmodule

module group5(opcode2, f);
	input[2:0] opcode2;
	wire[31:0] s1, s2;
	output f;
	initial begin
		stack S1(.push(0), .pop(1), .d(0), .q(s1));
		stack S2(.push(0), .pop(1), .d(0), .q(s2));
	end
	always@(*)begin
		case(opcode2)
			3'b000: f = (s1==s2)? 1 : 0;
			3'b001: f = (s1 > s2)? 1: 0;
			3'b010: f = (s1==s2)? 0 : 1;
		endcase	
	end
	stack S1(.push(1), .pop(0), .d({32'b0, f}));
endmodule

module group6(opcode2, f);
	input[2:0] opcode2;
	output f;
	/*
	always@(*)begin
		case(opcode2)
			3'b000: pop_2 p1(opcode2);	
			3'b001: pop_1 p2(opcode2);
		endcase
	end
	*/
endmodule

module stack(push, pop, d, q, reset);
	parameter WIDTH = 32;
	parameter DEPTH = 7;
	
	input reset, push, pop;
	input [WIDTH-1:0] d;
	output reg[WIDTH-1:0] q;

	reg [DEPTH-1:0] ptr;
	reg [WIDTH-1:0] stack[0:(1<<DEPTH)-1];

	always@(push or pop or reset or d)begin
		if(reset) ptr <=0;
		else if(push) ptr <= ptr+1;
		else if(pop) ptr <= ptr-1;	
	end
	always@(push or pop or reset or d)begin
		if(push||pop) begin
			if(push) stack[ptr] <= d;
			q <= stack[ptr-1];
		end
	end

module
