////////////////////////////////////////////////////////////////////////////////
// Name: Sadman Ishrak
// Email: sadmanishrak.work@gmail.com
////////////////////////////////////////////////////////////////////////////////
module clk_mux_4x1(input logic [1:0] sel,
                                    input logic [3:0] pll,
                                    output logic clk_out);

    logic clk_out_0;
    logic clk_out_1;

    clk_mux_2x1.sv inst_0 (.sel(sel[0]), .PLL1(pll[0]), .PLL2(pll[1]), .CLK_I(clk_out_0));


    clk_mux_2x1.sv inst_1 (.sel(sel[0]), .PLL1(pll[2]), .PLL2(pll[3]), .CLK_I(clk_out_1));


    clk_mux_2x1.sv inst_2 (.sel(sel[1]), .PLL1(clk_out_0), .PLL2(clk_out_1), .CLK_I(clk_out));

endmodule
