//////////////////////////////////////////////////////////////////////////////////////////////////
// Name: Sadman Ishrak
// Email: sadmanishrak.work@gmail.com
//////////////////////////////////////////////////////////////////////////////////////////////////

module top_module #(
    parameter int M = 4, // M - int Number of PLL sources
    parameter int N = 8  // N - int Number of clock reset outputs
) (

    input logic pll_i[M],
    input logic [$clog2(M)-1:0]sel_i[N],
    input logic glob_arst_ni,
    input logic arst_req_i[N],
    input logic ref_clk_i,
    input logic en_i[N],
    output logic clk_o[N],
    output logic arstn_o[N]
);


//////////////////////////////////////////////////////////////////////////////////////////////////
// INSTANCE BLOCK
//////////////////////////////////////////////////////////////////////////////////////////////////

    for ( genvar i = 0; i < N; i++) begin : gen_sub_top
        sub_top_module sub_top_module_inst(
            .pll_i(pll_i[M-1:0]),
            .sel_i(sel_i[$clog2(M)-1:0]),
            .glob_arst_ni(glob_arst_ni),
            .arst_req_i(arst_req_i[i]),
            .ref_clk_i(ref_clk_i),
            .en_i(en_i[i]),
            .clk_o(clk_o[i]),
            .arst_no(arstn_o[i])
        );
    end

endmodule

