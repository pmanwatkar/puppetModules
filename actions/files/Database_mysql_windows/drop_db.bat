@echo off
::drop db:

set db_name=%1
set user=%2
set password=%3

net start mysqld

echo drop database %db_name%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%
