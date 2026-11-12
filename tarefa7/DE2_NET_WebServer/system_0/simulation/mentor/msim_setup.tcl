
# (C) 2001-2021 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.0sp1 232 win32 2021.05.21.21:52:40

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize the variable
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
} 

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "system_0"
} 

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
} 

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "D:/altera/13.0sp1/quartus/"
} 


# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/system_0_epcs_controller_boot_rom.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
  ensure_lib                  ./libraries/altera_ver/      
  vmap       altera_ver       ./libraries/altera_ver/      
  ensure_lib                  ./libraries/lpm_ver/         
  vmap       lpm_ver          ./libraries/lpm_ver/         
  ensure_lib                  ./libraries/sgate_ver/       
  vmap       sgate_ver        ./libraries/sgate_ver/       
  ensure_lib                  ./libraries/altera_mf_ver/   
  vmap       altera_mf_ver    ./libraries/altera_mf_ver/   
  ensure_lib                  ./libraries/altera_lnsim_ver/
  vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver/
  ensure_lib                  ./libraries/cycloneii_ver/   
  vmap       cycloneii_ver    ./libraries/cycloneii_ver/   
}
ensure_lib                 ./libraries/SD_CLK/         
vmap       SD_CLK          ./libraries/SD_CLK/         
ensure_lib                 ./libraries/SD_DAT/         
vmap       SD_DAT          ./libraries/SD_DAT/         
ensure_lib                 ./libraries/switch_pio/     
vmap       switch_pio      ./libraries/switch_pio/     
ensure_lib                 ./libraries/button_pio/     
vmap       button_pio      ./libraries/button_pio/     
ensure_lib                 ./libraries/led_green/      
vmap       led_green       ./libraries/led_green/      
ensure_lib                 ./libraries/led_red/        
vmap       led_red         ./libraries/led_red/        
ensure_lib                 ./libraries/lcd_16207_0/    
vmap       lcd_16207_0     ./libraries/lcd_16207_0/    
ensure_lib                 ./libraries/timer_0/        
vmap       timer_0         ./libraries/timer_0/        
ensure_lib                 ./libraries/uart_0/         
vmap       uart_0          ./libraries/uart_0/         
ensure_lib                 ./libraries/jtag_uart_0/    
vmap       jtag_uart_0     ./libraries/jtag_uart_0/    
ensure_lib                 ./libraries/epcs_controller/
vmap       epcs_controller ./libraries/epcs_controller/
ensure_lib                 ./libraries/sdram_0/        
vmap       sdram_0         ./libraries/sdram_0/        

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v" -work altera_ver      
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"          -work lpm_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"             -work sgate_ver       
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"         -work altera_mf_ver   
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"     -work altera_lnsim_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.v"   -work cycloneii_ver   
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog "$QSYS_SIMDIR/submodules/system_0_SD_CLK.v"                 -work SD_CLK         
  vlog "$QSYS_SIMDIR/submodules/system_0_SD_DAT.v"                 -work SD_DAT         
  vlog "$QSYS_SIMDIR/submodules/system_0_switch_pio.v"             -work switch_pio     
  vlog "$QSYS_SIMDIR/submodules/system_0_button_pio.v"             -work button_pio     
  vlog "$QSYS_SIMDIR/submodules/system_0_led_green.v"              -work led_green      
  vlog "$QSYS_SIMDIR/submodules/system_0_led_red.v"                -work led_red        
  vlog "$QSYS_SIMDIR/submodules/system_0_lcd_16207_0.v"            -work lcd_16207_0    
  vlog "$QSYS_SIMDIR/submodules/system_0_timer_0.v"                -work timer_0        
  vlog "$QSYS_SIMDIR/submodules/system_0_uart_0.v"                 -work uart_0         
  vlog "$QSYS_SIMDIR/submodules/system_0_jtag_uart_0.v"            -work jtag_uart_0    
  vlog "$QSYS_SIMDIR/submodules/system_0_epcs_controller.v"        -work epcs_controller
  vlog "$QSYS_SIMDIR/submodules/system_0_sdram_0.v"                -work sdram_0        
  vlog "$QSYS_SIMDIR/submodules/system_0_sdram_0_test_component.v" -work sdram_0        
  vlog "$QSYS_SIMDIR/system_0.v"                                                        
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  vsim -t ps -L work -L work_lib -L SD_CLK -L SD_DAT -L switch_pio -L button_pio -L led_green -L led_red -L lcd_16207_0 -L timer_0 -L uart_0 -L jtag_uart_0 -L epcs_controller -L sdram_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  vsim -novopt -t ps -L work -L work_lib -L SD_CLK -L SD_DAT -L switch_pio -L button_pio -L led_green -L led_red -L lcd_16207_0 -L timer_0 -L uart_0 -L jtag_uart_0 -L epcs_controller -L sdram_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
