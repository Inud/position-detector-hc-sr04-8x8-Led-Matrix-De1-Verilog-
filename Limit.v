module Limit(		//limit in cm 
	input wire clk,
	input wire [11:0] distance1,
	input wire [11:0] distance2,
	input wire [11:0] distance3,
	
	output reg [9:0] led
	
);
parameter limitInCm = 100;

always @(posedge clk)
	begin	
		if (distance1 > limitInCm)
			led <= 9'b000000111;
		else if (distance2 > limitInCm)
			led <= 9'b000111000;
		else if (distance3 > limitInCm)
			led <= 9'b111000000;
		else
			led <= 9'b000000000;
	end
	
endmodule
