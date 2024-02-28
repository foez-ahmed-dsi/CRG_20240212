logic [$clog2(M)-1:0] sel_i_p = '{N{1'b0}};
realtime T[4] = '{25ns, 10ns, 6ns, 1ns};
logic arst_glob_i[N];

always @ (posedge ref_clk_i or arst_req_i or glob_arst_ni) begin
    for (int i=0; i<N; i++) begin
        arst_glob_i[i] <= ~arst_req_i[i] && glob_arst_ni;
    end
end

generate
    for (genvar j=0; j<N ;j++) begin : output_clock_selection_loop
      for (genvar i = 0; i < M; i++) begin : glitch_monitor_loop
        if (sel_i[i]) begin
            if(sel_i[i] != sel_i_p) begin
                sel_i_p<=sel_i[i];
                #100ns;
                `CLOCK_GLITCH_MONITOR(clk_o[j], arst_no[j], T[i], T[i])
                `CLOCK_MATCHING(en_i[j], pll_i[i], clk_o[j])
                `DELAY_MONITOR(arst_glob_i[j], C, arst_no[j])
                `CLOCK_EN_RST_MONITOR(en_i[j], arst_no[j], pll_i[i],clk_o[j] ) 
            end else begin
                sel_i_p<=sel_i[i];
                `CLOCK_GLITCH_MONITOR(clk_o[j], arst_no[j], T[i], T[i])
                `CLOCK_MATCHING(en_i[j], pll_i[i], clk_o[j])
                `DELAY_MONITOR(arst_glob_i[j], C, arst_no[j])
                `CLOCK_EN_RST_MONITOR(en_i[j], arst_no[j], pll_i[i],clk_o[j] )

            end
        end
      end
    end
endgenerate
