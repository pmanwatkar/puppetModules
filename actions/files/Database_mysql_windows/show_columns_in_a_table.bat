@echo off
set username=%1
set password=%2
set dbname=%3
set table=%4

echo use %dbname%;show columns from %table%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%username% -p%password%
