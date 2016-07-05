module sqrtModule(		//sqrt calc
	input wire clk,
	input wire reset,
	
	input wire [11:0] xValue,
	input wire [31:0]	y1Value,
	input wire [11:0]	ySensor3,
	
	input wire [11:0]	maxDistance,
	input wire [11:0]	minDistance,
	input wire [4:0] numberRow,
	input wire [4:0] numberColumn,
	
	output wire valueX,
	output wire	[11:0]valueSqrtY1,
	output wire [35:0] Linee 		//GPIO_1
);

reg [11:0] count;
reg [11:0] yProvv;

always@ (posedge clk or posedge reset)
	begin
		
		if (reset)
			begin

				yProvv <= 11'b00000000000;
				count = 0;
			end
				
		else
			begin
			
				if (count * count < y1Value)
					count = count + 1;
					
				else if (count * count >= y1Value)
					begin
						yProvv <= count -1;
						count = 0;
					end
			
			end
	end
	
	assign valueSqrtY1 = yProvv;
yCalc goToRealY(.clk(clk), .reset(reset), .sqrtY1Value(yProvv), .xValue(xValue), .ySensor3(ySensor3), .maxDistance(maxDistance), .minDistance(minDistance), .numberRow(numberRow), .numberColumn(numberColumn), .Linee(Linee));
endmodule
