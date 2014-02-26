@echo off
set username=%1
set password=%2
set dbname=%3
set table=%4
set field=%5
set value=%6



echo use %dbname%;delete from %table% where %field%=%value%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%username% -p%password%