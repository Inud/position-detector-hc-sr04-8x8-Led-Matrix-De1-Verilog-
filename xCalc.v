module xCalc(
	
	input wire clk,
	input wire reset,
	input wire [11:0] sens1,		//calc sensor1
	input wire [11:0] sens2,		//calc sensor2
	input wire [11:0] sens3,		//calc sensor3
	input wire [11:0]	xSensor1,	//positioning sensor center
	input wire [11:0]	xSensor2,
	input wire [11:0]	xSensor3,
	input wire [11:0]	ySensor1,
	input wire [11:0]	ySensor2,
	input wire [11:0]	ySensor3,
	input wire [11:0]	maxDistance,	// max distance
	input wire [11:0]	minDistance,	// min distance
	input wire [4:0] numberRow,
	input wire [4:0] numberColumn,
	
	output wire [11:0] axisX,
//	output wire [11:0] axisY,
	output wire [35:0] Linee //GPIO_1


);


	reg [11:0] xValue;
//	reg [11:0] yValue;
	
	//value 
	wire [11:0] a1;
	wire [11:0] b1;
	wire [11:0] r1;
	wire [11:0] a2;
	wire [11:0] b2;
	wire [11:0] r2;
	wire [11:0] c1;
	wire [11:0] c2;
	reg [11:0] valueX;
	assign a1 [11:0] = xSensor1;
	assign b1 [11:0] = ySensor1;
	assign r1 [11:0] = sens1;
	assign a2 [11:0] = xSensor2;
	assign b2 [11:0] = ySensor2;
	assign r2 [11:0] = sens2;
	assign c1 [11:0] = (a1 * a1) + (b1 * b1) - (r1 * r1);
	assign c2 [11:0] = (a2 * a2) + (b2 * b2) - (r2 * r2);
			
always@ (posedge clk or posedge reset)
	begin
		
		if (reset)
			begin
				valueX <= 11'b00000000000;
			end
			
		else if (sens1 > maxDistance || sens2 > maxDistance)		//out limit distance

			begin
				valueX <= 11'b11111111111;
			end
		else 
			begin
				valueX <= ((((sens1)*(sens1))-((sens2)*(sens2)) +((xSensor2)*(xSensor2)))/(2*(xSensor2))); 	//calculate radical axis
			end
					
	end
	
	assign axisX [11:0] = valueX;

y1Calc andNowY(
	
	.clk(clk), 
	.reset(reset), 
	.sens3(sens3),
	.xValue(valueX), 
	.ySensor3(ySensor3),
	.xSensor3(xSensor3), 
	.maxDistance(maxDistance),
	.minDistance(minDistance), 
	.numberRow(numberRow), 
	.numberColumn(numberColumn), 
	.Linee(Linee)
	
	);
	endmodule
