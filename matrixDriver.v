module matrixDriver(		//Drive to control the martrix
	input wire clk,
	input wire reset,
	input wire anodcatod,		//if =0, anode - x; if=1 catode - y
	input wire [4:0] led,		//number x or numerr y

	output wire [7:0] ledOut
	
);


	reg [7:0] matrixON;


always @(posedge clk or posedge reset)
	begin
		if (reset)
			begin
				if (anodcatod == 1'b0)
					matrixON <= 8'b00000000;
				else if (anodcatod == 1'b1)
					matrixON <= 8'b11111111;
			end
			
		else if (anodcatod == 1'b0)
			begin
				if (led == 0)
					matrixON <= 8'b00000000;	
				else if (led == 1)
					matrixON <= 8'b00000001;	
				else if (led == 2)
					matrixON <= 8'b00000010;	
				else if (led == 3)
					matrixON <= 8'b00000100;			
				else if (led == 4)
					matrixON <= 8'b00001000;			
				else if (led == 5)
					matrixON <= 8'b00010000;		
				else if (led == 6)
					matrixON <= 8'b00100000;			
				else if (led == 7)
					matrixON <= 8'b01000000;		
				else if (led == 8)
					matrixON <= 8'b10000000;
				else if (led>= 9)
					matrixON <= 8'b11111111;
			end
			
		else if (anodcatod == 1'b1)
			begin
				if (led == 0)
					matrixON <= 8'b11111111;
				else if (led == 1)
					matrixON <= 8'b11111110;
				else if (led == 2)
					matrixON <= 8'b11111101;
				else if (led == 3)
					matrixON <= 8'b11111011;
				else if (led == 4)
					matrixON <= 8'b11110111;
				else if (led == 5)
					matrixON <= 8'b11101111;
				else if (led == 6)
					matrixON <= 8'b11011111;
				else if (led == 7)
					matrixON <= 8'b10111111;
				else if (led == 8)
					matrixON <= 8'b01111111;
				else if (led>= 9)
					matrixON <= 8'b00000000;
				
			end
	end
	
	assign ledOut = matrixON;

endmodule
