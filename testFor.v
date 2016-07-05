 module testFor(		
 input  wire clk, 
 input wire [4:0] numeroAG,
 //input wire [4:0] numeroAR,
 input wire [4:0] numeroC,
 output wire [35:0] couple
 );
 

//	wire [7:0] AnodeR;
	wire [7:0] AnodeG;
	wire [7:0] Catode;

//possibility anode red
	
	assign couple [7:0] = AnodeG;
	assign couple [15:8] = Catode; 
	reg [4:0] Led;
	
	matrixDriver anodo ( .clk(clk), .reset(reset), .anodcatod(1'b0), .led(numeroAG), .ledOut(AnodeG));
	matrixDriver catodo ( .clk(clk), .reset(reset), .anodcatod(1'b1), .led(numeroC), .ledOut(Catode));
	
	
endmodule
