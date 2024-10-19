# ##################################################################################################################################################################################
# file :
#     run_gen_heartbeat.tcl
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# purpose :
#     creating VIVADO project for synthesis and simulation.
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# limitation :
#     none.
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# author :
#     Tugdual LE PELLETER
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# history :
#     2023-11-11
#         file creation
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# table of contents :
#    01. defining environment constants
#    02. creating VIVADO project
#    03. adding files
#        03.01. synthesis
#            03.01.01. design
#        03.02. simulation
#            03.02.01. design
#            03.02.02. packages
#            03.02.03. testbench
#    04. setting testbench module for simulation
#    05. updating compilation order
#    06. setting project parameters
#    07. setting synthesis engine options
#    08. launching VIVADO EDA tool
# ##################################################################################################################################################################################

# ##################################################################################################################################################################################
# 01. defining environment constants
# ##################################################################################################################################################################################

vlib work

vcom -reportprogress 300 -work work {C:/Users/Tugdual LE PELLETER/Documents/Recherche/Repositories/sfir_filter_tap_4_8b/sources/package/pkg_gen_heartbeat.vhd}
vcom -reportprogress 300 -work work {C:/Users/Tugdual LE PELLETER/Documents/Recherche/Repositories/sfir_filter_tap_4_8b/sources/package/pkg_mgt_file.vhd}
vcom -reportprogress 300 -work work {C:/Users/Tugdual LE PELLETER/Documents/Recherche/Repositories/sfir_filter_tap_4_8b/sources/bench/bch_sfir_filter_4.vhd}
vcom -reportprogress 300 -work work {C:/Users/Tugdual LE PELLETER/Documents/Recherche/Repositories/sfir_filter_tap_4_8b/sources/design/sfir_filter_4.vhd}

vsim -voptargs=+acc work.bch_sfir_filter_4

do wave.do

restart
run -all

# ##################################################################################################################################################################################
# EOF
# ##################################################################################################################################################################################