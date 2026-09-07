quit -sim

if {![file exists work]} {
    vlib work
}

vmap work work

vcom -2008 counter_4.vhd
vcom -2008 counter_74.vhd
vcom -2008 tb_counter_74.vhd

vsim work.tb_counter_74
add wave -divider "Entradas"
add wave -radix binary sim:/tb_counter_74/RST
add wave -radix binary sim:/tb_counter_74/CLK
add wave -radix binary sim:/tb_counter_74/EN
add wave -radix binary sim:/tb_counter_74/CLR
add wave -radix binary sim:/tb_counter_74/dut/en1
add wave -radix binary sim:/tb_counter_74/dut/load_s
add wave -radix binary sim:/tb_counter_74/dut/clr0
add wave -radix binary sim:/tb_counter_74/dut/clr1
add wave -divider "Saida"
add wave -radix hexadecimal sim:/tb_counter_74/Q

run 2050 ns
wave zoom full
