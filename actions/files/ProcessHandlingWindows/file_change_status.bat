::arguement:filename
@echo off
setlocal
set FileName=%1%
set FileTime=-
:loop

for %%X in (%FileName%) do (
    if %FileTime% NEQ %%~tX (
        rem just an example
       
       start %FileName%
    )
    set FileTime=%%~tX
)
rem wait 5 seconds before checking again
ping -n 6 localhost >nul 2>nul

goto :loop
