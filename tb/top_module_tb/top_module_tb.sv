//This is the tb file of Top_module
//Getting Right Clock:Clock matching, using sel
//Dead time:
//delay
//Glitch Monitoring:
//Reset Activation:will follow pll1
//reset makes 0
//enable checking
// ### Author : Nazmus Sakib (nazmus.sakib.punno@dsinnovators.com)
  
  
`include "clocking.svh"
  
module top_module_tb;
  
 
  `define ENABLE_DUMPFILE
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  // bring in the testbench essentials functions and macros
  `include "tb_ess.svh"
  
  
  //}}}
  

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOCALPARAMS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  localparam int M = 4;
  localparam int N = 8;
  localparam int C = 1295;
  
  
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-TYPEDEFS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  // generates static task start_clk_i with tHigh:4ns tLow:6ns
  `CREATE_CLK(ref_clk_i,  5ns,  5ns)
  `CREATE_CLK(pll_i_0,  25ns, 25ns)
  `CREATE_CLK(pll_i_1,  10ns, 10ns)
  `CREATE_CLK(pll_i_2,   6ns,  6ns)
  `CREATE_CLK(pll_i_3,   1ns,  1ns)





  logic pll_i [4];
  logic [$clog2(M)-1:0] sel_i [N] = '{N{1'b0}};
  logic glob_arst_ni = 1;
  logic arst_req_i[N] = '{N{1'b0}};
  logic en_i[N] = '{N{1'b1}};
  logic clk_o[N];
  logic arst_no[N];
  logic [$clog2(M)-1:0] sel_i_p = '{N{1'b0}};
  
  logic arst_glob_i[N];

  realtime T[4] = '{25ns, 10ns, 6ns, 1ns};

  assign pll_i[0]=pll_i_0;
  assign pll_i[1]=pll_i_1;
  assign pll_i[2]=pll_i_2;
  assign pll_i[3]=pll_i_3;
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-VARIABLES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  
  
  
  
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-INTERFACES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  
  
  
  
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-CLASSES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  
  
  
  
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-ASSIGNMENTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  
  
  
  
  //}}}
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  top_module #(
      .M(M),
      .N(N)  
  ) dut (
      .pll_i(pll_i),
      .sel_i(sel_i),
      .glob_arst_ni(glob_arst_ni),
      .arst_req_i(arst_req_i),
      .ref_clk_i(ref_clk_i),
      .en_i(en_i),
      .clk_o(clk_o),
      .arst_no(arst_no)
  );


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task static rand_sel_i(realtime unit_time = 1ns, int unsigned min = 10,
                          int unsigned max = 100);
    fork
        integer i;
        forever begin
            for(i=0;i<N;i++) begin
                #(unit_time * $urandom_range(min, max));
                sel_i[i]<= $urandom_range(0,3);
            end
        end
    join_none  
  endtask

  task static rand_arst_req_i(realtime unit_time = 1ns, int unsigned min = 50,
                          int unsigned max = 200);
    fork
        integer i;
        forever begin
            for(i=0;i<N;i++) begin
                #(unit_time * $urandom_range(min, max));
                arst_req_i[i]<= ($urandom_range(0,99)<15);
            end           
      end
    join_none
  endtask

  task static rand_en_i(realtime unit_time = 1ns, int unsigned min = 10,
                          int unsigned max = 100);
    fork
        integer i;
        forever begin
            for(i=0;i<N;i++) begin
                #(unit_time * $urandom_range(min, max));
                en_i[i]<= $urandom;
            end
        end
    join_none  
  endtask




  task static rand_glob_arst_ni(realtime unit_time = 1ns, int unsigned min = 50,
                          int unsigned max = 200);
    fork
      forever begin
        #(unit_time * $urandom_range(min, max));
        glob_arst_ni<= ($urandom_range(0,99)<95);
      end
    join_none
  endtask

  task static apply_reset();  //{{{
    #20ns;
    glob_arst_ni <= 0;
    #30ns;
    glob_arst_ni <= 1;
    #100ns;
  endtask  //}}}

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  always @ (posedge ref_clk_i or arst_req_i or glob_arst_ni) begin
    for (int i=0; i<N; i++) begin
        arst_glob_i[i] <= ~arst_req_i[i] && glob_arst_ni;
    end
  end
  
  
  generate
    for (genvar j=0; j<N ;j++) begin : output_clock_selection_loop
    `DELAY_MONITOR(arst_glob_i[j], C, arst_no[j])
    `CLOCK_GLITCH_MONITOR(clk_o[j], arst_no[j], 1ns, 1ns)
      for (genvar i = 0; i < M; i++) begin : glitch_monitor_loop
        if (sel_i[i]) begin
            if(sel_i[i] != sel_i_p) begin
                //sel_i_p<=sel_i[i];
                //#100ns;
                //`CLOCK_GLITCH_MONITOR(clk_o[j], arst_no[j], T[i], T[i])
                //`CLOCK_MATCHING(en_i[j], pll_i[i], clk_o[j])
                //`DELAY_MONITOR(arst_glob_i[j], C, arst_no[j])
                `CLOCK_EN_RST_MONITOR(en_i[j], arst_no[j], pll_i[i],clk_o[j] ) 
            end else begin
                //sel_i_p<=sel_i[i];
                //`CLOCK_GLITCH_MONITOR(clk_o[j], arst_no[j], T[i], T[i])
                //`CLOCK_MATCHING(en_i[j], pll_i[i], clk_o[j])
                //`DELAY_MONITOR(arst_glob_i[j], C, arst_no[j])
                `CLOCK_EN_RST_MONITOR(en_i[j], arst_no[j], pll_i[i],clk_o[j] )

            end
        end
      end
    end
  endgenerate

  initial begin  // main initial{{{
    
    apply_reset();
    start_ref_clk_i();
    start_pll_i_0();
    start_pll_i_1();
    start_pll_i_2();
    start_pll_i_3();
    rand_arst_req_i();
    rand_glob_arst_ni();
    rand_sel_i();
    rand_en_i();

    #10000ns;

    $finish;

  end  //}}}

  initial 
  begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

  //}}}
endmodule
