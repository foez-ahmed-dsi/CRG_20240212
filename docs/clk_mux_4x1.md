# Clock MUX 4x1

## Introduction
We've employed three 2x1 clock mux modules to create a single 4-to-1 mux for managing PLL signals. Each 2x1 mux selects between two clock inputs based on a select signal. By cascading these modules, we can handle four clock inputs and select one output efficiently. 2x1 mux module is used here instead of building a 4x1 instead, because it offers some advantages.
Using a 2-to-1 mux to build a 4-to-1 mux offers several advantages:

Modularity: By breaking down the problem into smaller, manageable components, we create a modular design. This modularity facilitates easier design, testing, and debugging, as each component can be individually verified for correctness.

Reuse: Once we have implemented a 2-to-1 mux, we can reuse it multiple times to construct larger multiplexers or other circuits. This reuse reduces design time and effort, as we don't need to redesign the basic building blocks for each new circuit.

Scalability: The approach of using smaller muxes to build larger ones is highly scalable. We can extend this methodology to create muxes with larger numbers of inputs without significantly increasing design complexity.

Ease of Understanding: Hierarchical design promotes clarity and understandability of the overall system. Engineers can easily comprehend the functionality of the 4-to-1 mux by understanding its composition from smaller 2-to-1 muxes.

Efficiency: Using smaller multiplexers can sometimes result in more efficient hardware utilization, especially in terms of resource sharing and optimization by synthesis tools.

Flexibility: We can easily modify or customize the behavior of the larger mux by adjusting the connections or parameters of the smaller muxes. This flexibility allows for rapid prototyping and design iteration.



<img src="./clk_mux_4x1.svg">
