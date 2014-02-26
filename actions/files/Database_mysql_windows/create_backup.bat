@echo off
set db=%1
set table=%2
set backupDb=%3
set backupTable=%4
set user=%5
set password=%6


echo create table %backupDb%.%backupTable%(select * from %db%.%table%); | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%
