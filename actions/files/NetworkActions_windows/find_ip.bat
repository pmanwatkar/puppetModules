@echo off                       


REM here the actual code starts

         ipconfig | findstr "IPv4"


REM Managing Error

        if %ERRORLEVEL% NEQ 0 GOTO ERR
        if %ERRORLEVEL% EQU 0 GOTO END

:ERR
        echo ERROR ouccured in processing.>file1.txt
        GOTO END

:END

