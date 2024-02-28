
`define CLOCK_GLITCH_MONITOR(__CLK__, __ARST_N__, __TIME_PERIOD_HIGH__, __TIME_PERIOD_LOW__)       \
  bit ``__CLK__``_``__TIME_PERIOD_HIGH__``_``__TIME_PERIOD_LOW__``_fail = 0;                       \
  static realtime last_edge = 0;                                                                   \
  static realtime this_edge = 0;                                                                   \
  static realtime edge_duration = 0;                                                               \
  initial begin                                                                                    \
    //realtime last_edge = 0;                                                                      \
    //realtime this_edge = 0;                                                                      \
    //realtime edge_duration = 0;                                                                  \
    forever begin                                                                                  \
      if (~``__ARST_N__``) begin                                                                   \
        last_edge = 0;                                                                             \
        this_edge = 0;                                                                             \
      end else begin                                                                               \
        if (``__CLK__``) @(negedge ``__CLK__``);                                                   \
        else @(posedge ``__CLK__``);                                                               \
        this_edge = $realtime;                                                                     \
        edge_duration = this_edge - last_edge;                                                     \
        last_edge = this_edge;                                                                     \
        if (``__CLK__``) begin                                                                     \
          if (edge_duration < ``__TIME_PERIOD_LOW__``) begin                                       \
            $warning(`"``__CLK__`` low duration is less than %0f`", ``__TIME_PERIOD_LOW__``);      \
            ``__CLK__``_``__TIME_PERIOD_HIGH__``_``__TIME_PERIOD_LOW__``_fail = 1;                 \
          end                                                                                      \
        end else begin                                                                             \
          if (edge_duration < ``__TIME_PERIOD_HIGH__``) begin                                      \
            $warning(`"``__CLK__`` high duration is less than %0f`", ``__TIME_PERIOD_HIGH__``);    \
            ``__CLK__``_``__TIME_PERIOD_HIGH__``_``__TIME_PERIOD_LOW__``_fail = 1;                 \
          end                                                                                      \
        end                                                                                        \
      end                                                                                          \
    end                                                                                            \
  end                                                                                              \
/*-----------------------------------------------------------------------------------------------*/\
  final begin                                                                                      \
    result_print(!``__CLK__``_``__TIME_PERIOD_HIGH__``_``__TIME_PERIOD_LOW__``_fail,               \
      `"Glitch Free ``__CLK__```");                                                                \
  end                                                                                              \
     
`define CLOCK_MATCHING(__EN__, __SRC_CLK__, __DEST_CLK__)                                          \
  bit ``__SRC_CLK__``_``__DEST_CLK__``_sync_fail = 0;                                              \
  always @ (``__SRC_CLK__``) begin                                                                 \
    #1fs;                                                                                          \
    if ((``__EN__``) && (``__DEST_CLK__`` !== ``__SRC_CLK__``)) begin                              \
        $warning(`"``__DEST_CLK__`` does not match with ``__SRC_CLK__```");                        \
        ``__SRC_CLK__``_``__DEST_CLK__``_sync_fail = 1;                                            \
    end                                                                                            \
  end                                                                                              \
/*-----------------------------------------------------------------------------------------------*/\
  final begin                                                                                      \
    result_print(!``__SRC_CLK__``_``__DEST_CLK__``_sync_fail,                                      \
      `"``__SRC_CLK__`` & ``__DEST_CLK__`` sync`");                                                \
  end                                                                                              \



`define CLOCK_EN_MONITOR(__EN__, __ARST__,__SRC_CLK__,__DEST_CLK__)                                \
  bit ``__SRC_CLK__``_``__DEST_CLK__``_``__En__``_fail = 0;                                        \
  logic en_o;                                                                                      \
  always @(negedge ``__SRC_CLK__`` ) begin                                                         \
    if(``__ARST__``) begin                                                                         \
      en_o<=``__EN__``;                                                                            \
    end else begin                                                                                 \
      en_o<=0;                                                                                     \
    end                                                                                            \
  end                                                                                              \
  always @ (``__SRC_CLK__``) begin                                                                 \
    #1fs;                                                                                          \
    if(en_o) begin                                                                                 \
      if (``__DEST_CLK__`` !== ``__SRC_CLK__``) begin                                              \
        $warning(`"``__DEST_CLK__`` does not match with ``__SRC_CLK__```");                        \
        ``__SRC_CLK__``_``__DEST_CLK__``_``__En__``_fail= 1;                                       \
      end                                                                                          \
    end else begin                                                                                 \
      if (``__DEST_CLK__``) begin                                                                  \
        $warning(`"``__DEST_CLK__`` does not match with ``__SRC_CLK__```");                        \
        ``__SRC_CLK__``_``__DEST_CLK__``_``__En__``_fail= 1;                                       \
      end                                                                                          \
    end                                                                                            \
  end                                                                                              \
  final begin                                                                                      \
    result_print(!``__SRC_CLK__``_``__DEST_CLK__``_``__En__``_fail,                                \
      `"``__SRC_CLK__`` & ``__DEST_CLK__`` match`");                                               \
  end                                                                                              \

/*`define DELAY_MONITOR(__CLK__,__ARST__, __COUNT__, __OUTPUT__)                                     \
  bit output_mismatch =0;                                                                          \
  int ext_count;                                                                                   \
  always @(posedge ``__CLK__`` or negedge ``__ARST__``) begin                                      \
    if (~ ``__ARST__``) begin                                                                      \
      ext_count<=0;                                                                                \
    end else begin                                                                                 \
      ext_count<= ext_count+1;                                                                     \
      if (ext_count == ``__COUNT__`` +1 ) begin                                                    \
        #1fs                                                                                       \
        if (``__OUTPUT__`` != 1) begin                                                             \
          $warning(`"``__OUTPUT__`` does not match with ``__COUNT__```");                          \
          output_mismatch=1;                                                                       \
        end                                                                                        \
      end                                                                                          \
    end                                                                                            \
  end                                                                                              \
  final begin                                                                                      \
    result_print(!output_mismatch,                                                                 \
      `"Delay of 1.28us matched`");                                                                \
  end  */ 
  
  /*`define DELAY_MONITOR(__ARST__, __COUNT__, __OUTPUT__)                                         \
  bit ``__OUTPUT__``_``__DELAY__``_fail = 0;                                                       \
                                                                                                   \
  realtime unit_time = 1ns;                                                                        \
  realtime count_ns=``_COUNT__`` *unit_time;                                                       \
  realtime delay;                                                                                  \
                                                                                                   \
  always @(negedge ``__ARST__``) begin                                                             \
        ``__OUTPUT__``=0;                                                                          \
        if (!``__OUTPUT__) @(posedge ``__OUTPUT__``);                                              \
          delay=$realtime;                                                                         \
          if (delay != count_ns ) begin                                                            \
            $warning(`"``__OUTPUT__`` delay is less than %0f`", ``COUNT``);    \                   \
            ``__OUTPUT__``_``__DELAY__``_fail = 1;                                                 \
          end                                                                                      \
    end                                                                                            \
*/                                                                                            


`define DELAY_MONITOR(__ARST__, __COUNT__, __OUTPUT__)                                             \
  realtime unit_time = 1ns;                                                                        \
  realtime count_ns=``_COUNT__`` *unit_time;                                                       \
  realtime delay;                                                                                  \
  bit output_mismatch =0;                                                                          \                                                                
  always @(negedge ``__ARST__``) begin                                                             \
      ``__OUTPUT__``=0;                                                                            \
      @(posedge ``__OUTPUT__``);                                                                   \
      delay=$realtime;                                                                             \
      if(delay < count_ns) begin                                                                   \
        $warning(`"``__OUTPUT__`` does not match with ``__COUNT__```");                            \
        output_mismatch=1;                                                                         \
      end                                                                                          \
  end                                                                                              \
  final begin                                                                                      \
    result_print(!output_mismatch,                                                                 \
      `"Delay of 1.28us matched`");                                                                \
  end                                                                                              \

`define CLOCK_EN_RST_MONITOR(__EN__, __RST__,__SRC_CLK__,__DEST_CLK__)                             \
  bit ``__SRC_CLK__``_``__DEST_CLK__``_``__En_Rst__``_fail = 0;                                    \
  always @ (``__SRC_CLK__``) begin                                                                 \
    #1fs;                                                                                          \
    if(``__EN__`` && ``__RST__`` ) begin                                                           \
      if (``__DEST_CLK__`` !== ``__SRC_CLK__``) begin                                              \
        $warning(`"``__EN__`` or ``__ARST__`` Fail`");                                             \
        ``__SRC_CLK__``_``__DEST_CLK__``_``__En_Rst__``_fail= 1;                                   \
      end                                                                                          \
    end else begin                                                                                 \
      if (``__DEST_CLK__``) begin                                                                  \
        $warning(`"``__EN__`` or ``__ARST__`` Fail`");                                             \
        ``__SRC_CLK__``_``__DEST_CLK__``_``__En_Rst__``_fail= 1;                                   \
      end                                                                                          \
    end                                                                                            \
  end                                                                                              \
  final begin                                                                                      \
    result_print(!``__SRC_CLK__``_``__DEST_CLK__``_``__En_Rst__``_fail,                            \
      `"``__EN__`` & ``__ARST__`` PASS`");                                                         \
  end                                                                                              \
