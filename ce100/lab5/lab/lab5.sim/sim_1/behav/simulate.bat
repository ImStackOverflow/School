@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim fuckme_behav -key {Behavioral:sim_1:Functional:fuckme} -tclbatch fuckme.tcl -view C:/Users/ghchen/lab5/fuckme_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
