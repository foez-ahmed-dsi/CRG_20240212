module clk_mux_2x1.sv(input logic sel,
             input logic PLL1,
             input logic PLL2,
             output logic CLK_I);

  logic Q1, Q2;

  always @ (posedge PLL1) begin
    Q1 <= ~sel && ~Q2;
  end
  
  always @ (posedge PLL2) begin
    Q2 <= sel && ~Q1;
  end
  
  assign CLK_I = Q1 && PLL1 || Q2 && PLL2;

endmodule
