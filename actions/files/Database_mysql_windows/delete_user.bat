@echo off
::delete user

set deleteUser=%1
set username=%2
set password=%3


net start mysqld

echo drop user %deleteUser%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%username% -p%password%

