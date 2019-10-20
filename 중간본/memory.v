module memory(address, writeData, memRead, memWrite, CLK, RESET, readData);
	input [31:0] address;
	input [31:0] writeData;
	input memRead;
	input memWrite;
	input CLK;
	input RESET;
	output[31:0] readData;

	reg[31:0] data[0:31];
	integer i;
	assign readData = data[address];
	always@(posedge CLK or posedge RESET) begin
		if(RESET)
			for(i=0; i<31; i=i+1)
				data[i] = i;
		else begin
			if(memWrite)
				data[address] = writeData;
		end
	end
endmodule
