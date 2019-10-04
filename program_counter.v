module PC(branch, CLK, sign_extended, RESET, address);
	input branch, CLK, RESET;	
	input [31:0] sign_extended;

	output reg[31:0] address;

	always@(posedge CLK or posedge RESET)begin
		if (RESET)
			address = 0;
		else 
			address = address + 4 + (branch? sign_extended : 0);
	end
endmodule
