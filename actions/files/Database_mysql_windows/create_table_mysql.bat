@echo off

set db=%1
set table_name=%2
set user=%3
set password=%4


net start mysqld

echo create table %db%.%table_name% (test varchar(255)) ; | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%
