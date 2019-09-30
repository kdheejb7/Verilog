module alu1Bit(result, cout, ALUop, a, b, cin);
	input a, b, cin;
	input [1:0] ALUop;
	output result, cout;
	wire sum, out_and, out_or, out_xor;
	fullAdder fa(cin, a, b, cout, sum);
	assign out_and = a&b;
	assign out_or = a|b;
	assign out_xor = a^b;
	assign result = (ALUop==2'b00)? out_and:
			(ALUop==2'b01)? out_or:
			(ALUop==2'b10)? sum:
			out_xor;
endmodule

module fullAdder(cin, a, b, cout, sum);
	input cin, a, b;
	output cout, sum;
	assign sum = cin^a^b;
	assign cout = (cin&a)|(cin&b)|(a&b);
endmodule 

module testBenchALU1bit;
reg a, b, cin;
reg[1:0] ALUop;

initial begin
a=0; b=0; cin=0; ALUop=2'b00;
#5 a=0; b=0; cin=1;
#5 a=0; b=1; cin=0;
#5 a=0; b=1; cin=1;
#5 a=1; b=0; cin=0;
#5 a=1; b=0; cin=1;
#5 a=1; b=1; cin=0;
#5 a=1; b=1; cin=1;
#5 a=0; b=0; cin=0; ALUop=2'b01;
#5 a=0; b=0; cin=1;
#5 a=0; b=1; cin=0;
#5 a=0; b=1; cin=1;
#5 a=1; b=0; cin=0;
#5 a=1; b=0; cin=1;
#5 a=1; b=1; cin=0;
#5 a=1; b=1; cin=1;
#5 a=0; b=0; cin=0; ALUop=2'b10;
#5 a=0; b=0; cin=1;
#5 a=0; b=1; cin=0;
#5 a=0; b=1; cin=1;
#5 a=1; b=0; cin=0;
#5 a=1; b=0; cin=1;
#5 a=1; b=1; cin=0;
#5 a=1; b=1; cin=1;
#5 a=0; b=0; cin=0; ALUop=2'b11;
#5 a=0; b=0; cin=1;
#5 a=0; b=1; cin=0;
#5 a=0; b=1; cin=1;
#5 a=1; b=0; cin=0;
#5 a=1; b=0; cin=1;
#5 a=1; b=1; cin=0;
#5 a=1; b=1; cin=1;
end
fullAdder f1(cin, a, b, cout, sum);
alu1Bit f2(result, cout, ALUop, a, b, cin);
initial $monitor($time, "a=%b,b=%b,c=%b, result=%b, ALUop=%b", a, b, cin, result, cout, ALUop);
initial #180 $finish;
endmodule
