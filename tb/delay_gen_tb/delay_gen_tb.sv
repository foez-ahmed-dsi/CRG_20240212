// Description here
// ### Author : Nazmus Sakib (nazmus.sakib.punno@dsinnovators.com)

`include "clocking.svh"

module delay_gen_tb;
  `define ENABLE_DUMPFILE

  //`define ENABLE_DUMPFILE

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-IMPORTS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // bring in the testbench essentials functions and macros
  `include "tb_ess.svh"

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-LOCALPARAMS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  localparam int count = 128;



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
  logic arst_ni = 1;
  logic out;

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-VARIABLES{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  bit output_mismatch=0;
  int ext_count;

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
    

    delay_gen #(
      .COUNT_RANGE(count)
    ) u_delay_gen(
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .delayed_o(out)
    );



  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-METHODS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////

  task static apply_reset();  //{{{
    #100ns;
    arst_ni <= 0;
    #100ns;
    arst_ni <= 1;
    #100ns;
  endtask  //}}}

  task static apply_sync_reset();  //{{{
    @(posedge clk_i);
    arst_ni <= 0;
    @(posedge clk_i);
    arst_ni <= 1;
  endtask  //}}}

  //}}}

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-PROCEDURALS{{{
  //////////////////////////////////////////////////////////////////////////////////////////////////
   
  always @(posedge clk_i or negedge arst_ni) begin
    if (~arst_ni) begin
      ext_count<=0;
    end else begin
      ext_count<= ext_count+1;
      if (ext_count == count-1 ) begin
        #1fs
        if (out != 1) begin
          output_mismatch=1;
        end
      end
    end
  end

  initial begin  // main initial{{{
    start_clk_i();
    repeat (10) @ (posedge clk_i);
    apply_sync_reset();
    #0.5ms;
    result_print(!output_mismatch,"delay_check!!");                                                
    $finish;
  end  //}}}

  //}}}
endmodule