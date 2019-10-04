`timescale 1ns/1ps

module instruction16Bit(instruction, f);
	input [15:0] instruction;
	output f;

	wire [2:0] op1, op2;
	wire [9:0] imm;
	assign imm = instruction[9:0];
	assign op2 = insturction[12:10];	//operation
	assign op1 = instruction[15:13];	//group
	always@(op1 or op2 or imm)begin
		case(op1):
			3'b000 or 3'b001: group1_2 g1(op1, op2, imm);
			3'b010: stack s1(.push(1), .pop(0), .d({22'b0,imm}));
			//3'b011: //pop
			3'b100: group5 g5(op2);
			3'b101: group6 g6(op2);
			//3'b110: //push_pc
			//3'b111: //pop_pc
		endcase
	end
		
endmodule

module group1_2(opcode1, opcode2, imm, f);
	input[2:0] opcode1, opcode2;
	input[9:0] imm;
	wire[31:0] s1, s2;
	output f;
	assign s1 = stack s1(.push(0), .pop(1));
	#5;
	initial begin
		if(opcode1==3'b000) assign s2 = stack s2(.push(0), .pop(1)); //group1
		else assign s2 = {22'b0,imm};	//group2, 22+10=32
	end
	case(op2):
		3'b000: assign f = s1 + s2;	
		3'b001: assign f = s1 - s2;
		3'b010: assign f = s1;	//neg how?
		3'b011: assign f = s1 * s2;
		3'b100: assign f = s1 & s2;
		3'b101: assign f = s1 | s2;
		3'b110: assign f = s1 ^ s2;
		3'b111: assign f = ~s1;	//not
	endcase
	stack s3(.push(1), .pop(0), .d(f));

endmodule

module group5(opcode2, f);
	input[2:0] opcode2;
	wire[31:0] s1, s2;
	output f;

	assign s1 = stack s1(.push(0), .pop(1));
	#5;
	assign s2 =stack s2(.pus(0), .pop(1));

	case(op2):
		3'b000: assign f = (s1==s2)? 1 : 0;
		3'b001: assign f = (s1 > s2)? 1: 0;
		3'b010: assign f = (s1==s2)? 0 : 1;
	endcase	
	stack s1(.push(1), .pop(0), .d({31'b0, f}));
endmodule

module group6(opcode2, f);
	input[2:0] opcode2;
	output f;
	case(op2):
		3'b000: pop_2 p1(op2);	
		3'b001: pop_1 p2(op2);
	endcase
endmodule

module stack(push, pop, d, q);
	parameter DEPTH = 10;
	input push, pop;
	input[31:0] d;	//push data
	output[31:0] q;	//pop data
	
	reg[(DEPTH-1):0] top_ptr;
	reg [31:0] stack[0:(DEPTH-1)];

	always@*begin
		if(push) top_ptr <= top_ptr+1;
		else if(pop) top_ptr <= top_ptr-1;
	end
	always@*begin
		if(push||pop) begin
			if(push) stack[top_ptr] <= d;
		q <= stack[top_ptr-1];
	end
endmodule


