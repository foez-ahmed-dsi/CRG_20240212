//////////////////////////////////////////////////////////////////////////////                                                                                                                             
//Author: Md Nazmus Sakib
//This is the top module to generate asynchronous output reset 
///////////////////////////////////////////////////////////////////////////////
module arst_n_o(
    input  logic    glob_arst_n_i,
    input  logic    arst_req_i,
    input  logic    ref_clk_i,
    output logic    arst_n_o
);
    
    logic          e_data_i;
    logic          edge_out_bar_o;
    logic          out;

    assign e_data_i = glob_arst_n_i && ~arst_req_i;
    assign arst_n_o = e_data_i      && out;
    

    edge_detector edge_detector_inst(    
        .e_data_i(e_data_i),
        .clk_ref(ref_clk_i),
        .edge_out_bar(edge_out_bar_o)
    );  

    delay_gen #(
        .count_range(128)
    ) delay_gen_inst (
        .clk(ref_clk_i),    
        .arst_n(edge_out_bar_o), 
        .out(out)    
    );  

endmodule

