quit -sim

if {![file exists work]} {
    vlib work
}

vmap work work

vcom -2008 counter_4.vhd
vcom -2008 tb_counter_4.vhd

vsim work.tb_counter_4
add wave -divider "Entradas"
add wave -radix binary sim:/tb_counter_4/RST
add wave -radix binary sim:/tb_counter_4/CLK
add wave -radix binary sim:/tb_counter_4/EN
add wave -radix binary sim:/tb_counter_4/CLR
add wave -radix binary sim:/tb_counter_4/LD
add wave -radix binary sim:/tb_counter_4/LOAD
add wave -divider "Saida"
add wave -radix unsigned sim:/tb_counter_4/Q

run 200 ns
wave zoom full
