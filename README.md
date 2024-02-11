# Clock Reset Generator
This device is meant to generate `n` clocks output for a selection of `m` PLL clock sources. The top level IOs of the blackbox design is shown below.

<img src=docs/top_IO.svg>

## Parameters
| Parameter | Type | Description                   |
|-----------|------|-------------------------------|
| M         | int  | Number of PLL sources         |
| N         | int  | Number of clock reset outputs |

## Signals
| Signal       | Type                        | Width             | Direction | Desciption                                        |
|--------------|-----------------------------|-------------------|-----------|---------------------------------------------------|
| ref_clk_i    | logic                       | 1                 | input     | Fixed frequency reference clock                   |
| glob_arst_ni | logic                       | 1                 | input     | A synchronous active low global reset             |
| pll_clk_i    | logic unpacked array of `m` | `m`               | input     | PLL clock source inputs                           |
| clk_sel_i    | logic unpacked array of `n` | ceiling log2(`m`) | input     | `clk_o[n]` source select from `pll_clk_i[m]`      |
| clk_en_i     | logic unpacked array of `n` | 1                 | input     | Enable `clk_o[n]` output                          |
| rst_req_i    | logic unpacked array of `n` | 1                 | input     | Active high reset request for `arst_no[n]`        |
| clk_o        | logic unpacked array of `n` | 1                 | output    | Clock output                                      |
| arst_no      | logic unpacked array of `n` | 1                 | output    | Active low synchronous reset output               |
