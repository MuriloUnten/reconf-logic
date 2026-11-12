set_global_assignment -entity "system_0" -library "lib_system_0" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "system_0" -library "lib_system_0" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "system_0" -library "lib_system_0" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_system_0" -name SPD_FILE [file join $::quartus(sip_path) "../../system_0.spd"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "../../system_0.qsys"]

set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "system_0.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_SD_CLK.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_SD_DAT.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_switch_pio.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_button_pio.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_led_green.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_led_red.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_lcd_16207_0.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_timer_0.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_uart_0.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_jtag_uart_0.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_epcs_controller.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_epcs_controller_boot_rom.hex"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_sdram_0.v"]
set_global_assignment -library "lib_system_0" -name MISC_FILE [file join $::quartus(sip_path) "submodules/system_0_sdram_0_test_component.v"]
