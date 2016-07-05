module clockSwitch(
	input wire clk,
	input wire reset,
	input wire switchClock,

	output reg clk1,
	output reg clk2,
	output reg clk3
		
);

reg [3:0] count;
reg countClk;

always@ (posedge clk or posedge reset or posedge switchClock)
	begin
		
		if (reset)
			begin
				count <= 0;
			end
			
		else if (switchClock)
			begin
				count = count +1;
			end
		else if (count == 0)
			begin
			 clk1 <= clk;
			 clk2 <= 0;
			 clk3 <= 0;
			end
		else if (count == 1)
			begin
			 clk1 <= 0;
			 clk2 <= clk;
			 clk3 <= 0;
			end
		else if (count == 2)
			begin
			 clk1 <= 0;
			 clk2 <= 0;
			 clk3 <= clk;
			end
		else if (count >= 3)
			begin
			 clk1 <= 0;
			 clk2 <= 0;
			 clk3 <= 0;
			 count <= 0;
			end
	end
endmodule
		
				
					