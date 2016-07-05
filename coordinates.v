module coordinates(

	input wire clk,
	input wire reset,
	
	input wire [11:0] sens1,		//misura sensore1
	input wire [11:0] sens2,		//misura sensore2
	input wire [11:0] sens3,		//misura sensore3
	
	output wire [11:0] xSensor1,	//centri dei rispettivi sensori
	output wire [11:0] xSensor2,
	output wire [11:0] xSensor3,
	output wire [11:0] ySensor1,
	output wire [11:0] ySensor2,
	output wire [11:0] ySensor3,
	output wire [11:0] maxDistance,	// distanza massima dai sensori
	output wire [11:0] minDistance,		// distanza minima dai sensori
	output wire [4:0] numberRow, 		// numero righe e colonne matrice
	output wire [4:0] numberColumn,
	output wire [32:0] Linee
);

parameter sqrt3 = 1.73205;

reg [11:0] side = 75; //maximum side



assign xSensor1 [11:0] = 0;
assign ySensor1 [11:0] = 0;
assign xSensor2 [11:0] = side;
assign ySensor2 [11:0] = 0;
assign xSensor3 [11:0] = side/2;
assign ySensor3 [11:0] = 66;			//~side * sqrt3 / 2;
assign maxDistance [11:0] = side;
assign minDistance [11:0] = 0;
assign numberColumn [4:0] = 8;
assign numberRow [4:0] = 8;


//wire
xCalc coord( 
			.clk(clk), 
			.reset(reset), 
			.sens1(sens1), 
			.sens2(sens2), 
			.sens3(sens3), 
			.xSensor1(xSensor1), 
			.xSensor2(xSensor2), 
			.xSensor3(xSensor3),
			.ySensor1(ySensor1),
			.ySensor2(ySensor2),
			.ySensor3(ySensor3),
			.maxDistance(maxDistance),
			.minDistance(minDistance),
			.numberColumn(numberColumn),
			.numberRow(numberRow),
			.Linee(Linee)
			

	);


endmodule
