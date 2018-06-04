@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto d13b7c4f55aa49f794ad42b9cf9b2767 -m64 --debug typical --relax --mt 2 -L secureip --snapshot ass_behav xil_defaultlib.ass -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
