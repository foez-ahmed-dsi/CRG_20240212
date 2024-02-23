# top_module Documentation

## Overview

`top_module` is a SystemVerilog module designed to manage multiple PLL sources and clock reset outputs. It allows users to specify the number of PLL sources (`M`) and clock reset outputs (`N`) through parameters.

## Parameters

- `M`: Number of PLL sources.
- `N`: Number of clock reset outputs.

## Inputs

1. `pll_i[M]`: Input array representing PLL sources.
2. `sel_i[N]`: Input array of selection signals for each clock reset output. 
3. `glob_arst_ni`: Global asynchronous reset input signal.
4. `arst_req_i[N]`: Array of asynchronous reset request signals.
5. `ref_clk_i`: Reference clock input signal.
6. `en_i[N]`: Array of enable signals for each clock reset output.

## Outputs

1. `clk_o[N]`: Array of clock output signals for each clock reset output.
2. `arstn_o[N]`: Array of active-low asynchronous reset signals for each clock reset output.

## Structure

### Sub-Module Instantiation

The `top_module` utilizes a `genvar` to instantiate a sub-module (`sub_top_module`) N times. Each instance of the sub-module is connected to the corresponding signals based on the configuration specified by the parameters `M` and `N`.

```systemverilog
genvar i;

generate
    for (i = 0; i < N; i++) begin
        sub_top_module sub_top_module_inst(
            .pll_i(pll_i[M-1:0]),
            .sel_i(sel_i[$clog2(M)-1:0]),
            .glob_arst_ni(glob_arst_ni),
            .arst_req_i(arst_req_i[i]),
            .ref_clk_i(ref_clk_i),
            .en_i(en_i[i]),
            .clk_o(clk_o[i]),
            .arst_n_o(arstn_o[i])
        );
    end
endgenerate
```

### Sub-Module (`sub_top_module`)

Each instance of `sub_top_module` is responsible for managing a single clock generation and reset output. The connections within this sub-module are based on the input and output signals specified in the instantiation.

## Example Instantiation

Here's an example instantiation of `top_module` with M=4 and N=8:

```systemverilog
top_module #(4, 8) top_instance (
  .pll_i(pll_sources),
  .sel_i(selection_signals),
  .glob_arst_ni(global_arst_n),
  .arst_req_i(reset_requests),
  .ref_clk_i(reference_clock),
  .en_i(enable_signals),
  .clk_o(clock_outputs),
  .arstn_o(reset_outputs)
);
```
