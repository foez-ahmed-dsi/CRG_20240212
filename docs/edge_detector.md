# Edge Detector
## Introduction

Edge detection in SystemVerilog refers to the process of identifying transitions or changes in signal values within a digital waveform. This is a crucial operation in digital design and verification, especially in scenarios where the timing and synchronization of signals are critical.

In SystemVerilog, edge detection typically involves detecting rising edges (transitions from low to high) or falling edges (transitions from high to low) within digital signals. This process is often implemented using edge-sensitive primitives or constructs provided by the language. In SystemVerilog, edge-sensitive primitives or constructs are features of the language specifically designed to detect transitions in digital signals. These constructs allow you to capture and respond to events such as rising edges (transitions from low to high) or falling edges (transitions from high to low) within signals. These keywords are used within an always_ff block to trigger the block's execution whenever an edge is detected on the specified signal.

Edge detection is fundamental in many digital design and verification tasks, including state machine design, synchronization, and timing analysis. It allows designers to react to changes in signals and coordinate the behavior of digital systems effectively.

<img src=./edge_detector.svg>

Here, the first FF is used to detect the edge, and the output is taken from the second one's inverted output to get desired signal. The "Nor" gate implementation is the simplified version of previous one where we were using "and" gate.
