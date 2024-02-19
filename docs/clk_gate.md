# Clock Gating
## Introduction:
Clock gating is a technique used in digital design to reduce power consumption by controlling when the clock signal is applied to specific circuit elements. Clock gating involves adding additional logic to a design to selectively enable or disable the clock signal to certain parts of the circuitry based on specific conditions.

Here's how clock gating works:

Clock Signal: In synchronous digital circuits, a clock signal is used to synchronize the operation of various components. The clock signal typically oscillates between a high (logic 1) and low (logic 0) state at a regular interval.

Clock Gating Circuit: A clock gating circuit typically consists of a gating logic element and a control signal. The gating logic determines whether the clock signal should be allowed to pass through to the downstream elements based on the control signal.

Here, as clock gating is just passing the existing clock according to enable, we could simply use the clock and enable signal as inputs of "and" gate, rather we used a flop because it makes enable synchronous to cloock. Thus no glitch/deadone is detected at the output.

Enable Signal: The control signal, also known as the enable signal, controls whether the clock signal is gated (blocked) or allowed to propagate through the clock gating circuit.

Schematic: A basic clock gating schematic might consist of an AND gate and an enable signal. The clock signal is connected to one input of the AND gate, and the enable signal is connected to the other input. The output of the AND gate provides the gated clock signal.

Functionality: When the enable signal is active (usually high), the AND gate allows the clock signal to pass through unchanged. When the enable signal is inactive (low), the AND gate blocks the clock signal, preventing it from propagating further.

Use for Enabling: Clock gating can be used for enabling certain portions of a circuit only when they are needed, thus conserving power. For example, in a processor, certain functional blocks may only need to operate during specific phases of operation. By gating the clock signal to these blocks when they are not in use, power consumption can be reduced.

Benefits: Clock gating helps reduce dynamic power consumption by preventing unnecessary switching activity in the gated portions of the circuit. This is especially useful in modern electronic devices where power efficiency is a critical consideration.

Overall, clock gating is a valuable technique for improving the power efficiency of digital designs by selectively controlling the distribution of the clock signal based on specific conditions or requirements.

<img src="./clk_gate.svg">
