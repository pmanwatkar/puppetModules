@echo off
::delete view:

set viewName=%1
set user=%2
set password=%3
set db=%4

net start mysqld 

echo use %db%;drop view %viewName%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%