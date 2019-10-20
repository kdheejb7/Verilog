module ALU(readData1, readData2, sign_extended, aluSrc, aluControl, zero, result);
	input [31:0] readData1, readData2, sign_extended;
	input aluSrc;
	input [2:0] aluControl;
	output zero;
	output [31:0] result;
	reg [31:0] res;
	reg [31:0] temp1, temp2;

	assign result = res;
	always@(*)begin
		case(aluControl)
		3'b000:begin	//add, addi, 
			temp1 = readData1;
			temp2 = aluSrc? sign_extended : readData2;
		end
		3'b001:begin	//sub, subi
			temp1 = readData1;
			temp2 = aluSrc? -sign_extended : -readData2;
		end
		3'b010:begin	//negation
			res = -readData1;
			//push readData2
		end
		3'b011:begin
			res = readData1*readData2;	//overflow...
		end
		3'b100:begin
			res = readData1&readData2;
		end
		3'b101:begin
			res = readData1|readData2;
		end
		3'b110:begin
			res = readData1^readData2;
		end
		3'b111:begin
			res = ~readData1;
			//push = 1;
			//res = -readData1 + 1;
			//push readData2
		end
		endcase
	end
	Adder32Bit adder(temp1, temp2, result);
endmodule
