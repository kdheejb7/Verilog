
module mux_2to1(a, b, s, y);
	input a, b, s;
	output y;
	wire is;
	wire aa, bb;

	not U1(is, s);		//#(rise_val, fall_val)
					//rise delay : Time to transition from 0, x, and z to 1.
					//fall delay : Time to transition from 1, x, and z to 0.
	and U2(aa, a, is);
	and U3(bb, b, s);
	or U4(y, aa, bb);

endmodule


module muxTester();
	reg ai = 0, bi = 0, ci = 0;
	wire yo;
	mux_2to1 MUT(ai, bi, ci, yo);
	initial $monitor($time, "ai=%b,bi=%b,ci=%b", ai, bi, ci);
	initial begin
		#23; ai = 0; bi = 0; ci = 1;
		#23; ai = 0; bi = 1; ci = 1;
		#23; ai = 1; bi = 0; ci = 1;
		#23; ai = 1; bi = 1; ci = 1;
		#23; ai = 0; bi = 0; ci = 0;
		#23; ai = 0; bi = 1; ci = 0;
		#23; ai = 1; bi = 0; ci = 0;
		#23; ai = 1; bi = 1; ci = 0;
		#23; $stop;
	end

	

	
endmodule
