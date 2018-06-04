@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
