@echo off
set username=%1
set password=%2



echo quit | "C:\Program Files\MySQL\bin\mysql.exe" -u%username% -p%password%
