////////////////////////////////////////////////////////////////////////////////
// Name: Sadman Ishrak
// Email: sadmanishrak.work@gmail.com
////////////////////////////////////////////////////////////////////////////////
module upper_module
(
   input logic [3:0] pll,
   input logic [1:0] sel,
   input logic rst_n,
   input logic en,
   output logic clk_out
);

    logic clk_mux_out_net;

    clk_mux_4X1 clk_mux_inst (
        .sel(sel),
        .pll(pll),
        .clk_out(clk_mux_out_net)
    );
                                    
    clock_gate clk_gate_inst (
            .EN(en),
            .CLK(~clk_mux_out_net),
            .RST_N(rst_n),
            .CLK_OUT(clk_out)
    );

endmodule
