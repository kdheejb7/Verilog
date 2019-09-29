module mul4Bit(x, y, p);
	input [3:0] x, y;
	output [7:0] p;
	wire [16:0] temp;
	assign p[0] = x[0]&y[0];

	halfAdder ha1(x[0]&y[1], x[1]&y[0], temp[0], p[1]);
	halfAdder ha2(x[0]&y[2], x[1]&y[1], temp[2], temp[1]);
	fullAdder fa1(temp[0], temp[1], x[2]&y[0], temp[3], p[2]);
	halfAdder ha3(x[0]&y[3], x[1]&y[2], temp[5], temp[4]);
	fullAdder fa2(temp[2], temp[4], x[2]&y[1], temp[7], temp[6]);
	fullAdder fa3(temp[3], temp[6], x[3]&y[0], temp[8], p[3]);
	fullAdder fa4(temp[5], x[1]&y[3], x[2]&y[2], temp[9], temp[10]);
	fullAdder fa5(temp[7], temp[10], x[3]&y[1], temp[11], temp[12]);
	halfAdder ha4(temp[8], temp[12], temp[13], p[4]);
	fullAdder fa6(temp[9], x[2]&y[3], x[3]&y[2], temp[15], temp[14]);
	fullAdder fa7(temp[13], temp[11], temp[14], temp[16], p[5]);
	fullAdder fa8(temp[16], temp[15], x[3]&y[3], p[7], p[6]);

endmodule



module fullAdder(cin, x, y, cout, s);
	input cin, x, y;
	output cout, s;
	assign cout = (x&y) | (x&cin) | (y&cin);
	assign s = x^y^cin;
endmodule

module halfAdder(x, y, c, s);
	input x, y;
	output c, s;
	assign c = x&y;
	assign s = x^y;
endmodule
