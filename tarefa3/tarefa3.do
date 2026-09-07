quit -sim

if {![file exists work]} {
    vlib work
}

vmap work work

vcom -2008 counter_4.vhd
vcom -2008 bcd_7seg.vhd
vcom -2008 stopwatch.vhd
vcom -2008 top.vhd
vcom -2008 tb_stopwatch.vhd

vsim work.tb_stopwatch
add wave -divider "Entradas"
add wave -radix binary sim:/tb_stopwatch/clk
add wave -radix binary sim:/tb_stopwatch/pause_toggle_button
add wave -radix binary sim:/tb_stopwatch/reset_button

add wave -divider "Saida"
add wave -radix hexadecimal sim:/tb_stopwatch/dut/seconds
add wave -radix hexadecimal sim:/tb_stopwatch/dut/cents
add wave -radix hexadecimal sim:/tb_stopwatch/dut/s0_7seg
add wave -radix hexadecimal sim:/tb_stopwatch/dut/s1_7seg
add wave -radix hexadecimal sim:/tb_stopwatch/dut/c0_7seg
add wave -radix hexadecimal sim:/tb_stopwatch/dut/c1_7seg

run 61000000000 ns
wave zoom full
