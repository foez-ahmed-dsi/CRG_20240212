logic [$clog2(M)-1:0] sel_i_p = '{N{1'b0}};
realtime T[4] = '{25ns, 10ns, 6ns, 1ns};
logic arst_glob_i[N];

always @ (posedge ref_clk_i or arst_req_i or glob_arst_ni) begin
    for (int i=0; i<N; i++) begin
        arst_glob_i[i] <= ~arst_req_i[i] && glob_arst_ni;
    end
end

logic en_i_v [N][M];
generate
  for (genvar j = 0; j < N; j++) begin : outer_loop
    for (genvar i = 0; i < M; i++) begin : inner_loop
      always @ (sel[i]) begin
        if (en_i[j] && arst_glob_i[j]) begin
          #200ns;
          en_i_v [j][i] <= 1;
          `CLOCK_MATCHING( en_i_v [j][i], pll_i[i], clk_o[j])
        end
      end
    end
  end
endgenerate