module ranging_module(

	input wire clk,
	input wire echo,
	input wire reset,
	input wire [31:0] collegamenti,

	output reg trig,
	output wire [11:0] distance,
	output wire [23:0] period_cnt_output,
	output wire [31:0] period_cnt_full_out
);
	parameter maxDistance = 1010; //max distance
	parameter calibrationEcho = 295;  // calibration for a better 
	parameter period_cnt_full_max =5000000;
	
	assign period_cnt_full_out = period_cnt_full_max;
	
	// ������ ����� ���������� 100��
	reg [23:0] period_cnt;
	wire period_cnt_full;
	
	always @(posedge clk or posedge reset)
		begin
			if (reset)
				period_cnt <= 0;
			else
				begin
					if (period_cnt_full)
						begin
							period_cnt <= 0;
						end
					else
						begin
							period_cnt <= period_cnt + 1;
						end
				end
		end

	assign period_cnt_full = (period_cnt == period_cnt_full_max + 1);
	
	// DEBUG
	assign period_cnt_output = period_cnt;

	// Trigger di 100 microsec
	always @(posedge clk or posedge reset)
		begin
			if (reset)
				trig <= 0;
			else
				trig <= ( period_cnt > 1000 && period_cnt < 51000);
		end


	// Echo
	reg [11:0] echo_length;
	always @(posedge clk or posedge reset)
		begin
			if (reset)
				echo_length <= 0;
			else
				begin
					if (trig || echo_length == calibrationEcho) 
						echo_length <= 0;
					else if (echo)
						echo_length <= echo_length + 1;
				end
		end


// cap distance : combination distance-echo
	reg [11:0] distance_temp;
	always @(posedge clk or posedge reset)	
		begin
			if (reset)
				distance_temp <= 0;
			else
				begin
					if (trig)
						distance_temp <= 0;
					else if (echo && echo_length == calibrationEcho && distance_temp < maxDistance)//(echo && echo_length == 275 && distance_temp < 500)
						distance_temp <= distance_temp + 1;
				end
		end


		// output Distance
	 reg [11:0] distance_output;
	 always @(posedge clk or posedge reset)
	 	begin
	 		if (reset)
	 			distance_output <= 0;
	 		else if (period_cnt_full)
				begin
					distance_output <= distance_temp;					
				end
				
	 	end

	assign distance = distance_output / 10; // (*/10) for cm

	


endmodule