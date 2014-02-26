@echo off
set VAR=%1
FOR %%i IN (%VAR%) DO IF EXIST %%~si\NUL goto here
echo not a directory
exit
:here
ECHO It's a directory
::if exist %1\* echo Directory
