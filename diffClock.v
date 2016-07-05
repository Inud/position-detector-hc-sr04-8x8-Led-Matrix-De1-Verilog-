module diffClock(

//input
 input wire clk,
 input wire reset,
 input wire [31:0] control,
 
//output
 output reg clk1,
 output reg clk2,
 output reg clk3

);

reg [32:0] count;		// counter - sovradimensioned for every "control"
reg [3:0] whichOutput;	// to decide which sensor will be up
parameter cycleForSensor = 3; //2	// how many cycles for every sensor

always@(posedge clk or posedge reset)
	begin
		if (reset)
			begin
				count <= 0;
				whichOutput <= 0;
			end
			
		else if (count <= control) // control = 500000
			begin
				count = count + 1;
					if(whichOutput >= 0 && whichOutput < 1 * cycleForSensor)	//1st sensor up
						begin
							clk1 <= 1'b1;
							clk2 <= 1'b0;
							clk3 <= 1'b0;
						end
					else if(whichOutput >= 1 * cycleForSensor && whichOutput < 2 * cycleForSensor) 	//pause - wait all waves end
						begin
							clk1 <= 1'b0;
							clk2 <= 1'b0;
							clk3 <= 1'b0;
						end
					else if(whichOutput >= 2 * cycleForSensor && whichOutput < 3 * cycleForSensor)	//2nd sensor up
						begin
							clk1 <= 1'b0;
							clk2 <= 1'b1;
							clk3 <= 1'b0;
						end
					else if(whichOutput >= 3 * cycleForSensor && whichOutput < 4 * cycleForSensor)	//pause - wait all waves end
						begin
							clk1 <= 1'b0;
							clk2 <= 1'b0;
							clk3 <= 1'b0;
						end
					else if(whichOutput >= 4 * cycleForSensor && whichOutput < 5 * cycleForSensor) 	//3rd sensor up
						begin
							clk1 <= 1'b0;
							clk2 <= 1'b0;
							clk3 <= 1'b1;
						end
					else if(whichOutput >= 5 * cycleForSensor && whichOutput < 6 * cycleForSensor)	//pause - wait all waves end
						begin
							clk1 <= 1'b0;
							clk2 <= 1'b0;
							clk3 <= 1'b0;
						end
			end
		else if (count > control) // control = 500000
			begin
				count <= 0;
				if (whichOutput < 6*cycleForSensor)		// changing output
					whichOutput = whichOutput +1;
				else 
					whichOutput  <= 0;
			end

	end
	
	
	endmodule
