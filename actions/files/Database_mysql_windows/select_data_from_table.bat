@echo off
set username=%1
set password=%2
set dbname=%3
set table=%4



echo use %dbname%;select * from %table%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%

