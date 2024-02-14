# Delay Generator Circuit

## Introduction:

As a delay generator circuit, we used a counter here. It simply counts up to the desired delay / count using an adder whose one output being always 1. The register we used of any bit considering required limit. The block will work as a desired generator for edge detected by previous block, and will control the global reset, reset request and output clock.

<img src=./delay_gen.svg>
