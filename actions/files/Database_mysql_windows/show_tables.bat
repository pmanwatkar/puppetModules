@echo off
set username=%1
set password=%2
set dbname=%3


echo use %dbname%;show tables; | "C:\Program Files\MySQL\bin\mysql.exe" -u%username% -p%password%