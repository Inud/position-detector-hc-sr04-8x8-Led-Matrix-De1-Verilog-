module yCalc(		//calcolo della y

	input wire clk,
	input wire reset,
	
	input wire [11:0] xValue,		//valore della x
	input wire [31:0]	sqrtY1Value,		//value sqrt(y^2)

	input wire [11:0]	ySensor3,		// y sensor3
	input wire [11:0]	maxDistance,	
	input wire [11:0]	minDistance,
	input wire [4:0] numberRow,
	input wire [4:0] numberColumn,



	output wire valueX,		//value of x
	output wire	valueY,		//value of y
	output wire [35:0] Linee
);


reg [11:0] xProvv;
reg [11:0] yProvv;

always@ (posedge clk or posedge reset)
	begin
		
		if (reset)
			begin
				xProvv <= 11'b00000000000;
				yProvv <= 11'b00000000000;
			end
			
		else if (xValue >= 11'b11111111111 || sqrtY1Value >= 11'b11111111111)
			begin
				xProvv <= xValue;
				yProvv <= sqrtY1Value;
			end
		else 					//sensor is on top
			begin
				yProvv <= ySensor3 - sqrtY1Value;
				xProvv <= xValue;
			end
	end
	
	assign valueX = xProvv;	
	assign valueY = yProvv;
	
	converter fromNumberToMatrix(.clk(clk), .reset(reset), .numeroY(yProvv), .numeroX(xProvv), .ySensor3(ySensor3), .maxDistance(maxDistance), .minDistance(minDistance), .numberRow(numberRow), .numberColumn(numberColumn), .Linee(Linee));
endmodule
