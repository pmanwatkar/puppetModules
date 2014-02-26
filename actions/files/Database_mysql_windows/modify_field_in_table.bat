@echo off
set username=%1
set password=%2
set dbname=%3
set table=%4
set field1=%5
set value1=%6
set field2=%7
set value2=%8

echo use %dbname%;update %table% set %field2%='%value2%' where %field1%=%value1%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%username% -p%password%
