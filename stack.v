module stack(CLK, push, pop, d, q);
	parameter WIDTH = 32;		//register size
	parameter DEPTH = 16;		//the number of register
	
	input CLK, push, pop;
	input [WIDTH-1:0] d;
	output reg[WIDTH-1:0] q;
	
	reg [DEPTH-1:0] ptr;
	reg [WIDTH-1:0] stack[0:DEPTH-1];	
	integer i;
	initial begin
		$display("size of stack=",$bit(stack));
		for(i=0; i<DEPTH; i=i+1)
			stack[i]=0;
		ptr = 0;
	end
	always@(posedge CLK)begin
		if(push) ptr <= ptr+1;
		else if(pop) ptr <= ptr-1;	
	end
	always@(posedge CLK)begin
		if(push||pop) begin
			if(push) stack[ptr] <= d;
			else stack[ptr-1] <= 32'b0;
			q <= stack[ptr-1];
			
		end
	end
endmodule


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
	stack S1(_CLK, _push, _pop, _d, _q);
endmodule
