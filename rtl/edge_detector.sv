module edge_detector(
	input logic e_data_i,
	input logic clk_ref,
	output logic edge_out_bar
);

	logic d_2, q_bar_1;

	always_ff @ (posedge clk_ref) begin
		q_bar_1 <= ~(e_data_i);
	end

	always_comb begin
      d_2 = ~(q_bar_1 | e_data_i);
	end

	always_ff @ (posedge clk_ref) begin
		edge_out_bar <= ~d_2;
	end

endmodule
