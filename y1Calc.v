module y1Calc(
	input wire clk,
	input wire reset,
	
	input wire [11:0] xValue,
	input wire [11:0]	sens3,
	input wire [11:0]	xSensor3,
	input wire [11:0]	ySensor3,
	
	input wire [11:0]	maxDistance,	// max distance between sensors
	input wire [11:0]	minDistance,	// min distance from sensor
	input wire [4:0] numberRow,
	input wire [4:0] numberColumn,
	
	output wire valueX,
	output wire	[31:0]valueY1,
	output wire [35:0] Linee //GPIO_1
);


reg [11:0] xProvv;
reg [31:0] yProvv;

always@ (posedge clk or posedge reset)
	begin
		
		if (reset)
			begin
				xProvv <= 11'b00000000000;
				yProvv <= 11'b00000000000;
			end
			
		else if (sens3 > maxDistance)
			begin
				xProvv <= 11'b11111111111;
				yProvv <= 11'b11111111111;
			end
				
		else
			begin
				/*if (xValue == xSensor3)
					begin
						yProvv <= sens3;
						xProvv <= xValue;
					end*/
				
				//else 
				if (xValue >= xSensor3) // >= -> >
					begin
						yProvv <= ((sens3)*(sens3)) + ((xValue - xSensor3)*(xValue - xSensor3));
						xProvv <= xValue;
					end
				
				else if (xValue < xSensor3)
					begin
						yProvv <= ((sens3)*(sens3)) + ((xSensor3 - xValue)*(xSensor3 - xValue));
						xProvv <= xValue;
					end
			end
	end
	
		assign valueX = xProvv;	
		assign valueY1 = yProvv;
		
sqrtModule giveMeTheSqrt(

	.clk(clk), 
	.reset(reset), 
	.y1Value(yProvv), 
	.xValue(xProvv), 
	.ySensor3(ySensor3), 
	.maxDistance(maxDistance), 
	.numberRow(numberRow), 
	.numberColumn(numberColumn), 
	.Linee(Linee)
	);
	

endmodule

