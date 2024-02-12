# Clock Reset Generator
This device generates `n` clocks output for a selection of `m` PLL clock sources. Upon Global Reset or Reset Request `n`, the active low asynchronous reset `arst_no[n]` goes low immediately & remains low for at least 1.28us even if the reset request or global reset is released before that. During this time, the `clk_o[n]` does not toggle even if `clk_en_i[n]` is asserted. The top level IOs of the blackbox design is shown below.

<img src=docs/top_IO.svg>

## Parameters
| Parameter | Type | Description                   |
|-----------|------|-------------------------------|
| M         | int  | Number of PLL sources         |
| N         | int  | Number of clock reset outputs |

## Signals
| Signal       | Type                        | Width             | Direction | Desciption                                        |
|--------------|-----------------------------|-------------------|-----------|---------------------------------------------------|
| ref_clk_i    | logic                       | 1                 | input     | 100MHz Fixed frequency reference clock            |
| glob_arst_ni | logic                       | 1                 | input     | A synchronous active low global reset             |
| pll_clk_i    | logic unpacked array of `m` | `m`               | input     | PLL clock source inputs                           |
| clk_sel_i    | logic unpacked array of `n` | ceiling log2(`m`) | input     | `clk_o[n]` source select from `pll_clk_i[m]`      |
| clk_en_i     | logic unpacked array of `n` | 1                 | input     | Enable `clk_o[n]` output                          |
| rst_req_i    | logic unpacked array of `n` | 1                 | input     | Active high reset request for `arst_no[n]`        |
| clk_o        | logic unpacked array of `n` | 1                 | output    | Clock output                                      |
| arst_no      | logic unpacked array of `n` | 1                 | output    | Active low asynchronous reset output              |
