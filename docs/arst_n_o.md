# Active low asynchronous reset circuit 

## Introduction:

Here, the module designed using 2 submodules named "edge_detector" and "delay_generator". The and operation of both global reset and asynchronous reset request are driven to input of edge-detector. The output of this module is driven to reset signal of next block. Finally the output is driven to the output pin.
<img src=./arst_n_o.svg>

