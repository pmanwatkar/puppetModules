@echo off

set viewName=%1
set db=%2
set table=%3
set user=%4
set password=%5

net start mysqld 


echo create view %db%.%viewName% as select* from %db%.%table%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%

