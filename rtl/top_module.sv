//////////////////////////////////////////////////////////////////////////////////////////////////
// Name: Sadman Ishrak
// Email: sadmanishrak.work@gmail.com
//////////////////////////////////////////////////////////////////////////////////////////////////

/*
M	int	Number of PLL sources
N	int	Number of clock reset outputs
*/

module top_module #(parameter M = 4, parameter N = 8) (
  
    input logic pll_i[M],
    input logic [$clog2(M)-1:0]sel_i[N],
    input logic glob_arst_n_i,
    input logic arst_req_i[N],
    input logic ref_clk_i,
    input logic en_i[N],
    output logic clk_o[N],
    output logic arstn_o[N]
);


//////////////////////////////////////////////////////////////////////////////////////////////////
// INSTANCE BLOCK
//////////////////////////////////////////////////////////////////////////////////////////////////

    genvar i;

    generate
        
        for (i = 0; i < N; i++) begin
            sub_top_module sub_top_module_inst(
                .pll_i(pll_i[M-1:0]),
                .sel_i(sel_i[$clog2(M)-1:0]),
                .glob_arst_n_i(glob_arst_n_i),
                .arst_req_i(arst_req_i[i]),
                .ref_clk_i(ref_clk_i),
                .en_i(en_i[i]),
                .clk_o(clk_o[i]),
                .arst_n_o(arstn_o[i])
            );
        end

    endgenerate



endmodule


