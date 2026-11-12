
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
# ncsim - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="system_0"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="D:/altera/13.0sp1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/SD_CLK/
mkdir -p ./libraries/SD_DAT/
mkdir -p ./libraries/switch_pio/
mkdir -p ./libraries/button_pio/
mkdir -p ./libraries/led_green/
mkdir -p ./libraries/led_red/
mkdir -p ./libraries/lcd_16207_0/
mkdir -p ./libraries/timer_0/
mkdir -p ./libraries/uart_0/
mkdir -p ./libraries/jtag_uart_0/
mkdir -p ./libraries/epcs_controller/
mkdir -p ./libraries/sdram_0/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cycloneii_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/system_0_epcs_controller_boot_rom.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v" -work altera_ver      
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"          -work lpm_ver         
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"             -work sgate_ver       
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"         -work altera_mf_ver   
  ncvlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"     -work altera_lnsim_ver
  ncvlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.v"   -work cycloneii_ver   
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog "$QSYS_SIMDIR/submodules/system_0_SD_CLK.v"                 -work SD_CLK          -cdslib ./cds_libs/SD_CLK.cds.lib         
  ncvlog "$QSYS_SIMDIR/submodules/system_0_SD_DAT.v"                 -work SD_DAT          -cdslib ./cds_libs/SD_DAT.cds.lib         
  ncvlog "$QSYS_SIMDIR/submodules/system_0_switch_pio.v"             -work switch_pio      -cdslib ./cds_libs/switch_pio.cds.lib     
  ncvlog "$QSYS_SIMDIR/submodules/system_0_button_pio.v"             -work button_pio      -cdslib ./cds_libs/button_pio.cds.lib     
  ncvlog "$QSYS_SIMDIR/submodules/system_0_led_green.v"              -work led_green       -cdslib ./cds_libs/led_green.cds.lib      
  ncvlog "$QSYS_SIMDIR/submodules/system_0_led_red.v"                -work led_red         -cdslib ./cds_libs/led_red.cds.lib        
  ncvlog "$QSYS_SIMDIR/submodules/system_0_lcd_16207_0.v"            -work lcd_16207_0     -cdslib ./cds_libs/lcd_16207_0.cds.lib    
  ncvlog "$QSYS_SIMDIR/submodules/system_0_timer_0.v"                -work timer_0         -cdslib ./cds_libs/timer_0.cds.lib        
  ncvlog "$QSYS_SIMDIR/submodules/system_0_uart_0.v"                 -work uart_0          -cdslib ./cds_libs/uart_0.cds.lib         
  ncvlog "$QSYS_SIMDIR/submodules/system_0_jtag_uart_0.v"            -work jtag_uart_0     -cdslib ./cds_libs/jtag_uart_0.cds.lib    
  ncvlog "$QSYS_SIMDIR/submodules/system_0_epcs_controller.v"        -work epcs_controller -cdslib ./cds_libs/epcs_controller.cds.lib
  ncvlog "$QSYS_SIMDIR/submodules/system_0_sdram_0.v"                -work sdram_0         -cdslib ./cds_libs/sdram_0.cds.lib        
  ncvlog "$QSYS_SIMDIR/submodules/system_0_sdram_0_test_component.v" -work sdram_0         -cdslib ./cds_libs/sdram_0.cds.lib        
  ncvlog "$QSYS_SIMDIR/system_0.v"                                                                                                   
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  ncelab -access +w+r+c -namemap_mixgen $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
