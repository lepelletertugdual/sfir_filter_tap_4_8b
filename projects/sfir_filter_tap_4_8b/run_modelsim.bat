:: ###################################################################################################################################################################################
:: file :
::     run_gen_heartbeat.bat
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: purpose :
::     running gen_heartbeat TCL script.
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: limitation :
::     none.
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: author :
::     Tugdual LE PELLETER
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: history :
::     2023-11-11
::         file creation
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: table of contents :
::    01. defining VIVADO EDA tool path
::    02. running tcl script
:: ###################################################################################################################################################################################

:: ###################################################################################################################################################################################
:: 01. defining VIVADO EDA tool path
:: ###################################################################################################################################################################################

set PATH=C:\Applications\Altera\13.1\modelsim_ase\win32aloem;%PATH%

:: ###################################################################################################################################################################################
:: 02. running tcl script
:: ###################################################################################################################################################################################

vsim -do run_modelsim.tcl

:: ###################################################################################################################################################################################
:: EOF
:: ###################################################################################################################################################################################
