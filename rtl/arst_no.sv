//////////////////////////////////////////////////////////////////////////////
//Author: Md Nazmus Sakib
//This is the top module to generate asynchronous output reset
///////////////////////////////////////////////////////////////////////////////
module arst_no(
    input  logic    glob_arst_ni,
    input  logic    arst_req_i,
    input  logic    ref_clk_i,
    output logic    arst_no
);

    logic          e_data_i;
    logic          edge_out_bar_o;
    logic          out;

    assign e_data_i = glob_arst_ni && ~arst_req_i;
    assign arst_no = e_data_i      && out;


    edge_detector edge_detector_inst(
        .e_data_i(e_data_i),
        .clk_ref_i(ref_clk_i),
        .edge_out_bar_o(edge_out_bar_o)
    );

    delay_gen #(
        .COUNT_RANGE(128)
    ) delay_gen_inst (
        .clk_i(ref_clk_i),
        .arst_ni(edge_out_bar_o),
        .delayed_o(out)
    );

endmodule

