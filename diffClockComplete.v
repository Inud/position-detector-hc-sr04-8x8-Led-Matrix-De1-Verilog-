// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.0 Build 156 04/24/2013 SJ Web Edition"
// CREATED		"Sat Jun 25 14:41:10 2016"

module diffClockComplete(
	clk,
	reset,
	control,
	clk1,
	clk2,
	clk3
);


input wire	clk;
input wire	reset;
input wire	[31:0] control;
output wire	clk1;
output wire	clk2;
output wire	clk3;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





diffClock	b2v_inst(
	.clk(clk),
	.reset(reset),
	.control(control),
	.clk1(SYNTHESIZED_WIRE_0),
	.clk2(SYNTHESIZED_WIRE_1),
	.clk3(SYNTHESIZED_WIRE_2));

assign	clk1 = clk & SYNTHESIZED_WIRE_0;

assign	clk2 = clk & SYNTHESIZED_WIRE_1;

assign	clk3 = clk & SYNTHESIZED_WIRE_2;


endmodule
