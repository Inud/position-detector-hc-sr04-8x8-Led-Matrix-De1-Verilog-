module main(

	// clock
	input CLOCK_50,
	
	// input & output
	input wire [35:0] GPIO_0,
	input [9:0] SW,
	input [3:0] KEY,

	output wire [35:0] GPIO_1,
	output [6:0] HEX0, HEX1, HEX2, HEX3,
	output [7:0] LEDG,
	output [9:0] LEDR

);


	// Parameter sensors
	parameter xSensor1st = 0;		// origin
	parameter xSensor2nd = 68;		// side
	parameter xSensor3rd = xSensor2nd / 2;		// side/2
	parameter ySensor1st = 0;		// origin
	parameter ySensor2nd = 0;		// y=0
	parameter ySensor3rd = 62; 	//	~sqrt(3)*side/2 (case:equilateral triangle)
	parameter maxDistanceSensors = xSensor2nd;	// max distance
	parameter minDistanceSensors = 0;	// min distance
	
	// Parameter matrix
	parameter column = 8;
	parameter row = 8;
	
	// Key block
	wire key_reset;
	assign reset = ~KEY[0];

	// address 
	assign echo1 = GPIO_0[0];		//sensors
	assign GPIO_1[33] = trigger1;
	assign echo2 = GPIO_0[1];
	assign GPIO_1[34] = trigger2;
	assign echo3 = GPIO_0[2];
	assign GPIO_1[35] = trigger3;
	wire [32:0] Linee;				//Led Matrix
	assign GPIO_1 [32:0] = Linee;
	
	//wire
	wire [11:0] distance;
	wire [11:0] distance1;
	wire [11:0] distance2;
	wire [11:0] distance3;
	wire clk1;
	wire clk2;
	wire clk3;
	wire [31:0] control;


	
	diffClockComplete( 	// to distinguish sensor 
	
	.clk(CLOCK_50),
	.reset(reset),
	.control(750000),
	.clk1(clk1),
	.clk2(clk2),
	.clk3(clk3)
	
);


// modules to calculate the three distances

	ranging_module rangeFirstA(			//1st sensor

		.clk(clk1),
		.echo(echo1),
		.reset(reset),
		.collegamenti(Linee),
		.period_cnt_full_out(control),
		.trig(trigger1),
		.distance(distance1)		//distance1a (2 sensors for angle)
	
	);
	
	ranging_module rangeSecondA(		//2nd sensor
		
		.clk(clk2),
		.echo(echo2),
		.reset(reset), 
		.collegamenti(Linee),
		.trig(trigger2),
		.distance(distance2)		//distance2a (2 sensors for angle)
		
	);

	ranging_module rangeThirdA(			//3rd sensor

		.clk(clk3),
		.echo(echo3),
		.reset(reset),
		.collegamenti(Linee),
		.trig(trigger3),
		.distance(distance3)		//distance3a (2 sensors for angle)
		
	);
	
	// modules if every angle have 2 sensor (problem of range)
	/*
		ranging_module rangeFirstB(			//1st sensor

		.clk(clk1),
		.echo(echo1),
		.reset(reset),
		.collegamenti(Linee),
		.period_cnt_full_out(control),
		.trig(trigger1),
		.distance(distance1b)
	
	);
	
	ranging_module rangeSecondB(		//2nd sensor
		
		.clk(clk2),
		.echo(echo2),
		.reset(reset), 
		.collegamenti(Linee),
		.trig(trigger2),
		.distance(distance2b)		
		
	);

	ranging_module rangeThirdB(			//3rd sensor

		.clk(clk3),
		.echo(echo3),
		.reset(reset),
		.collegamenti(Linee),
		.trig(trigger3),
		.distance(distance3b)		
		
	);
	
	chooseOne sensor1st(

		.clk(clk1),
		.reset(reset),
		.distanceA(distance1a),
		.distanceB(distance1b),

		.distanceMinimum(distance1)

);
	chooseOne sensor2nd(

		.clk(clk1),
		.reset(reset),
		.distanceA(distance2a),
		.distanceB(distance2b),

		.distanceMinimum(distance2)

);
	chooseOne sensor3rd(

		.clk(clk1),
		.reset(reset),
		.distanceA(distance3a),
		.distanceB(distance3b),

		.distanceMinimum(distance3)

);
	*/
	
	// from distances to LedMatrix Chain
		xCalc test5( 
			.clk(CLOCK_50), 
			.reset(reset), 
			.sens1(distance1), 		//.sens1(distance1 - minDistanceSensors),
			.sens2(distance2), 		//.sens2(distance2	- minDistanceSensors),
			.sens3(distance3), 		//.sens3(distance3 - minDistanceSensors),
			.xSensor1(xSensor1st), 
			.xSensor2(xSensor2nd), 
			.xSensor3(xSensor3rd),
			.ySensor1(ySensor1st),
			.ySensor2(ySensor2nd),
			.ySensor3(ySensor3rd),
			.maxDistance(maxDistanceSensors), 
			.minDistance(minDistanceSensors),		//not used
			.numberColumn(column),
			.numberRow(row),
			.Linee(Linee)
			
	); 
	
	
	// to switch which distance show
	switch7seg switch(
		.clk(CLOCK_50),
		.reset(reset),
		.distance1(distance1),
		.distance2(distance2),
		.distance3(distance3),
		.Switch(SW),
		.distance(distance)
	);
	
	

	// BCD convertion - decoder
	wire [3:0] distance_ones;
	wire [3:0] distance_tens;
	wire [3:0] distance_hundreds;
	wire [3:0] distance_thousands;

	bin2bcd decoder(
		.B({2'b00, distance}),

		.BCD_0(distance_ones),
		.BCD_1(distance_tens),
		.BCD_2(distance_hundreds),
		.BCD_3(distance_thousands)
	);

	// Show distance on HEX block
	hex_7seg decoder2(
	
		.cs(distance_ones),
		.ds(distance_tens),
		.s(distance_hundreds),
		.das(distance_thousands),

		.seg0(HEX0),
		.seg1(HEX1),
		.seg2(HEX2),
		.seg3(HEX3)
		
	);

	
	// LedR ON if distance out of limit
	Limit ifTooLong(		//3 leds open for sensor out of range
	
		.clk(CLOCK_50),
		.distance1(distance1),	//1,2,3
		.distance2(distance2),	//4,5,6
		.distance3(distance3),	//7,8,9
		.led(LEDR)
	
	);
	

endmodule
