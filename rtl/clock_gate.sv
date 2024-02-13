////////////////////////////////////////////
//	Author - Sadman Ishrak
//	Email - sadmaishrak.work@gmail.com
//
//
////////////////////////////////////////////
module DFF_CG(
  input logic EN,
  input logic CLK,
  input logic RST_N,
  output logic CLK_OUT
);

	logic clk_inv;
	logic Q_holder;
	
	assign clk_inv = ~CLK;

	always_ff @ (posedge clk_inv or negedge RST_N) begin
		if (~RST_N) begin
			Q_holder <= 0;
		end else begin
			Q_holder <= EN;
		end
	end
  
	assign CLK_OUT = Q_holder & CLK;

endmodule

