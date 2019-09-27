module mul3Bit(x,y,f);
	input [2:0] x,y;
	output [5:0] f;
	wire [7:0] temp;
	assign f[0] = x[0]&y[0];
	halfAdder ha1(x[0]&y[1], x[1]&y[0], temp[0], f[1]);	//f[1] fix, tempe[0] is cin of next FA.
	halfAdder ha2(x[2]&y[0], x[1]&y[1], temp[2], temp[1]);
	fullAdder fa1(temp[0], temp[1], x[0]&y[2], f[2], temp[3]);	//f[2] fix, temp[3] is cout.
	fullAdder fa2(temp[2], x[1]&y[2], x[2]&y[1], temp[4], temp[5]);
	halfAdder ha3(temp[3], temp[4], temp[6], f[3]);	//f[3] fix.
	fullAdder fa3(temp[6], temp[5], x[2]&y[2], f[4], f[5]);
endmodule


module fullAdder(cin, x, y, s, cout);
	input cin, x, y;
	output s, cout;
	assign s = x^y^cin;
	assign cout = (x&y)|(x&cin)|(y&cin);
endmodule

module halfAdder(x, y, c, s);
	input x,y;
	output c,s;
	assign s = x^y;
	assign c = x&y;
endmodule
