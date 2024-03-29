// A tb for clock gate
// ### Author : Nazmus Sakib (nazmus.sakib.punno@dsinnovators.com)

`include "clocking.svh"

module clk_gate_tb;

  `define ENABLE_DUMPFILE

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  `include "tb_ess.svh"

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOCALPARAMS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-TYPEDEFS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // generates static task start_clk_i with tHigh:4ns tLow:6ns
  `CREATE_CLK(clk_i, 5ns, 5ns)
  logic en_i=0;
  logic arst_ni=1;
  logic pll_o;

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

  clk_gate u_clk_gate(
    .en_i(en_i),
    .clk_i(clk_i),
    .arst_ni(arst_ni),
    .pll_o(pll_o)
  );

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task static apply_reset();
    #100ns;
    arst_ni <= 0;
    #100ns;
    arst_ni <= 1;
    #100ns;
  endtask
  task static rand_switch(realtime unit_time = 1ns, int unsigned min = 100,
                          int unsigned max = 1000);
    fork
      forever begin
        #(unit_time * $urandom_range(min, max));
         en_i <= $urandom;
      end
    join_none
  endtask

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  `CLOCK_GLITCH_MONITOR(clk_i, arst_ni, 5ns, 5ns)
  `CLOCK_EN_MONITOR(en_i, arst_ni,clk_i,pll_o)
  initial begin  // main initial{{{

    apply_reset();
    start_clk_i();
    rand_switch();

    #0.5ms;

    $finish;

  end  //}}}

  //}}}

endmodule
