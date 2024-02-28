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
  
  ````````````````````````  
  `define ENABLE_DUMPFILE
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  // bring in the testbench essentials functions and macros
  `include "tb_ess.svh"
  
  
  //}}}
  
  S
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOCALPARAMS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  localparam int M = 4;
  localparam int N = 8;
  
  
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

  `CLOCK_GLITCH_MONITOR(clk_i, arst_ni, 5ns, 5ns)
  `CLOCK_GLITCH_MONITOR(clk_i, arst_ni, 5ns, 5ns)
  `CLOCK_GLITCH_MONITOR(clk_i, arst_ni, 5ns, 5ns)
  `CLOCK_GLITCH_MONITOR(clk_i, arst_ni, 5ns, 5ns)

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

  //}}}
endmodule
