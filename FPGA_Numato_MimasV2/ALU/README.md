# Arithmetic & Logical Unit(ALU)

Implementation of ALU using Numato MimasV2

# Implementation

* Default        : Result = inpu1 + input2
* SW2 pressed    : Result = abs(inpu1 - input2)
* SW3 pressed    : Result = inpu1 * input2
* SW4 pressed    : Result = inpu1 & input2 //bitwise
* SW5 pressed    : Result = inpu1 | input2 // bitwise
* SW6 pressed    : if inpu1 == input2 then Result = 1 else Result = 0

# Hardware Mapping

* DIP Switches 1 - 4 : inpu1
* DIP Switches 5 - 8 : inpu2
* Push Button 1(SW1) : Reset
* Push Button 2(SW2) : Substract Function
* Push Button 3(SW3) : Multiplication Function
* Push Button 4(SW4) : AND Function
* Push Button 5(SW5) : OR Function
* Push Button 6(SW6) : Compare Function
* 7 Segment Display  : Display Result

## Reference Links
[Numato MimasV2](https://numato.com/product/mimas-v2-spartan-6-fpga-development-board-with-ddr-sdram/)