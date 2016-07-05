 module converter(
 input wire clk, 
 input wire reset,
 input wire [11:0] numeroX,
 input wire [11:0] numeroY,
 input wire [11:0] ySensor3, 
 input wire [11:0] maxDistance,
 input wire [11:0] minDistance,
 input wire [4:0] numberRow,
 input wire [4:0] numberColumn,
 
 output wire [4:0] ledC,
 output wire [4:0] ledAG,
 output wire [35:0] Linee
 
 );
 
// 	wire [35:0] Linee;

	reg [11:0] xValue;
	reg [11:0] yValue;
	reg [11:0] xLed;
	reg [11:0] yLed; //
	
	


 always@ (posedge clk or posedge reset)
	begin

		if (reset)
			begin
			xValue <= 4'b0000;
			yValue <= 4'b0000;
			end

		else
			begin
				xLed <= (maxDistance - minDistance) / numberRow;		//range
				yLed <= (ySensor3 - minDistance) / numberColumn;

				
				if (numeroX <= xLed)
					xValue <= 4'b0001;
				else if (numeroX > xLed && numeroX <= (xLed*2))
					xValue <= 4'b0010;
				else if (numeroX > (xLed *2) && numeroX <= (xLed * 3))
					xValue <= 4'b0011;
				else if (numeroX > (xLed *3) && numeroX <= (xLed * 4))
					xValue <= 4'b0100;
				else if (numeroX > (xLed *4) && numeroX <= (xLed * 5))
					xValue <= 4'b0101;
				else if (numeroX > (xLed *5) && numeroX <= (xLed * 6))
					xValue <= 4'b0110;
				else if (numeroX > (xLed *6) && numeroX <= (xLed * 7))
					xValue <= 4'b0111;
				else if (numeroX > (xLed *7) && numeroX <= (xLed * 8))
					xValue <= 4'b1000;
					
				if (numeroY <= yLed)
					yValue <= 4'b0001;
				else if (numeroY > yLed && numeroY <= (yLed*2))
					yValue <= 4'b0010;
				else if (numeroY > (yLed *2) && numeroY <= (yLed * 3))
					yValue <= 4'b0011;
				else if (numeroY > (yLed *3) && numeroY <= (yLed * 4))
					yValue <= 4'b0100;
				else if (numeroY > (yLed *4) && numeroY <= (yLed * 5))
					yValue <= 4'b0101;
				else if (numeroY > (yLed *5) && numeroY <= (yLed * 6))
					yValue <= 4'b0110;
				else if (numeroY > (yLed *6) && numeroY <= (yLed * 7))
					yValue <= 4'b0111;
				else if (numeroY > (yLed *7) && numeroY <= (yLed * 8))
					yValue <= 4'b1000; 
					
				if (numeroX > (xLed *8)||numeroY > (yLed *8))
					begin
						xValue <= 4'b1001;
						yValue <= 4'b1001;
					end
				
			end
	
	
	
	end
	

	testFor toMatrix(.clk(clk), .numeroC(xValue), .numeroAG(yValue), .couple(Linee));

	
endmodule
