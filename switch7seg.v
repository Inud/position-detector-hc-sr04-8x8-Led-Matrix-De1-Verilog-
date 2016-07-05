module switch7seg(		//swap the 7seg with switch
	input wire clk,
	input wire reset,
	input wire [11:0] distance1,
	input wire [11:0] distance2,
	input wire [11:0] distance3,
	input [9:0] Switch,
	
	output wire [11:0] distance
	
);

	reg [11:0] distance_output;

always@ (posedge clk or posedge reset)
	begin
			if (reset)
				distance_output <= 0;
			else if(Switch[0] == 1'b1)
				distance_output <= distance1;
			else if(Switch[1] == 1'b1)
				distance_output <= distance2;
			else if(Switch[2] == 1'b1)
				distance_output <= distance3;
			else 
				distance_output <= 0;
	end
		
	
	assign distance = distance_output;

endmodule
		