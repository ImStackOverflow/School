@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim lab2_tests_behav -key {Behavioral:sim_1:Functional:lab2_tests} -tclbatch lab2_tests.tcl -view C:/Users/ghchen/Desktop/most recent fuck/lab2_tests_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
