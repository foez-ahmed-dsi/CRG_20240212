# Clock MUX 4x1

## Introduction
We've employed three 2x1 clock mux modules to create a single 4-to-1 mux for managing PLL signals. Each 2x1 mux selects between two clock inputs based on a select signal. By cascading these modules, we can handle four clock inputs and select one output efficiently. This setup enables flexible routing of PLL signals within the digital design.

<img src="./clk_mux_4x1.svg">
