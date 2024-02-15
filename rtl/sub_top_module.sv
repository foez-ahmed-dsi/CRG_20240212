//////////////////////////////////////////////////////////////////////////////////////////////////
// Name: Sadman Ishrak
// Email: sadmanishrak.work@gmail.com
//////////////////////////////////////////////////////////////////////////////////////////////////

module sub_top_module(
    input logic [3:0] pll_i,
    input logic [1:0] sel_i,
    input logic glob_arst_n_i,
    input logic arst_req_i,
    input logic ref_clk_i,
    input logic en_i
    output logic clk_o,
    output logic arst_n_o
);

//////////////////////////////////////////////////////////////////////////////////////////////////
// INSTANTIATIONS
//////////////////////////////////////////////////////////////////////////////////////////////////

    upper_module upper_module_inst(
        .pll_i (pll_i),
        .sel_i (sel_i),
        .arst_n_i(arst_n_o),
        .en_i(en_i),
        .clk_out_o(clk_o)
    );
    
    
    
    arst_n_o arst_n_o_inst(
        .glob_arst_n_i (glob_arst_n_i),
        .arst_req_i (arst_req_i),
        .ref_clk_i (ref_clk_i),
        .arst_n_o (arst_n_o)
    )
 

endmodule
