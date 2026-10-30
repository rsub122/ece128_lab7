# ECE-128-Lab-7

Up counter (0 to 4095) shown on the Basys 3 four digit seven segment display.

A 1 Hz clock (divided down from the 100 MHz board clock) drives a 12 bit up counter. The count goes into a 12 bit to 16 bit binary to BCD converter (double dabble, built as a state machine), and the BCD value goes into a multi digit driver. The driver uses a 2 bit refresh counter and a 2:4 decoder to turn on one anode at a time, a 4:1 mux to pick the matching BCD digit, and the BCD to 7 segment decoder to drive the cathodes. The center button resets everything and the LEDs show the count in binary.

## Files
- `Lab7_Top.v` - top module
- `clockdivider_1Hz.v` - 100 MHz to 1 Hz clock divider (Lab 5 clockdivider with a bigger counter)
- `UpCounter.v` - 12 bit up counter, wraps at 4095
- `Bin2BCD.v` - 12 bit binary to 16 bit BCD converter
- `multi_digit_driver.v` - multi digit seven segment driver
  - `refresh_counter.v` - 2 bit refresh counter
  - `decoder2to4.v` - anode decoder
  - `mux4to1.v` - picks one BCD digit
  - `BCDtoSevenSegment.v` - BCD to cathode pattern
- `Lab7_Top_TB.v` - testbench for the top module
- `Basys3_Lab7.xdc` - pin assignments

## Simulation
1. Add all the `.v` files to a Vivado project, set `Lab7_Top_TB` as the simulation top.
2. Before simulating, make the clock dividers smaller or nothing will happen in a reasonable time:
   - `clockdivider_1Hz.v`: change `26'd49999999` to `26'd19`
   - `refresh_counter.v`: change `17'd99999` to `17'd3`
3. Run Behavioral Simulation, then Run All. The testbench resets, counts, resets again in the middle, and counts past 99.
4. Add `uut/count`, `uut/bcd`, `an` and `seg` to the waveform (set count to unsigned decimal and bcd to hex) and check that the BCD digits match the count.
5. Change the numbers back before generating the bitstream.

## FPGA implementation
1. Set `Lab7_Top` as the design top and add `Basys3_Lab7.xdc` as a constraint.
2. Run Synthesis, Implementation, and Generate Bitstream.
3. Open Hardware Manager, connect the Basys 3 and program the device.
4. The display counts up once per second. Press the center button to reset to 0000.
