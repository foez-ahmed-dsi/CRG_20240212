//////////////////////////////////////////////////////////////////////////////////////////////////
// Name: Sadman Ishrak
// Email: sadmanishrak.work@gmail.com
//////////////////////////////////////////////////////////////////////////////////////////////////

module sub_top_module(
    input logic [3:0] pll_i,
    input logic [1:0] sel_i,
    input logic glob_arst_ni,
    input logic arst_req_i,
    input logic ref_clk_i,
    input logic en_i
    output logic clk_o,
    output logic arst_no
);

//////////////////////////////////////////////////////////////////////////////////////////////////
// INSTANTIATIONS
//////////////////////////////////////////////////////////////////////////////////////////////////

    upper_module upper_module_inst(
        .pll_i (pll_i),
        .sel_i (sel_i),
        .arst_ni(arst_no),
        .en_i(en_i),
        .clk_out_o(clk_o)
    );
    
    
    
    arst_no arst_n_o_inst(
        .glob_arst_ni (glob_arst_ni),
        .arst_req_i (arst_req_i),
        .ref_clk_i (ref_clk_i),
        .arst_no (arst_no)
    )
 

endmodule
