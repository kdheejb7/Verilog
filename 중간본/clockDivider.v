module clockDivider(CLK, _CLK);
	input CLK;
	output reg _CLK;

	integer i;
	initial begin
 		i = 0;
		_CLK = 0;
	end

	always@(posedge CLK)begin
		i = i+1;
		if(i == 20) begin
			i = 0;
			_CLK = ~_CLK;
		end
	end

endmodule
