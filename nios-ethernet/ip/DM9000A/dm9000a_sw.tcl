create_driver dm9000a_driver
set_sw_property hw_class_name dm9000a
set_sw_property version 1.0.1
set_sw_property min_compatible_hw_version 1.0
set_sw_property bsp_subdirectory drivers

# Avisa o NicheStack para habilitar o suporte a rede (MAX_NETS > 0)
set_sw_property is_ethernet_mac true

# Obriga o BSP a auto-gerar o código no alt_sys_init.c
set_sw_property auto_initialize true
add_sw_property alt_sys_init_macro_name DM9000A_INIT
add_sw_property system_h_macro_name DM9000A

add_sw_property c_source dm9000a.c
add_sw_property include_source dm9000a.h
add_sw_property include_source dm9000a_regs.h
add_sw_property include_source basic_io.h
add_sw_property include_directory .

add_sw_property supported_bsp_type HAL
add_sw_property supported_bsp_type UCOSII