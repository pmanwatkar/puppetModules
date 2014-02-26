@echo off                       

REM checking arguments

        IF %1.==. GOTO SYNTAXERR
        

REM here the actual code starts

         netstat -an | findstr /RC:":%1 .*LISTENING" 1> %temp%\junk  2>&1


REM Managing Error

        if %ERRORLEVEL% NEQ 0 GOTO ERR
        if %ERRORLEVEL% EQU 0 GOTO SUCCESS

:ERR
        echo Port is free.
        del %temp%\junk
        GOTO END

:SUCCESS
        echo Port is being used.
        del %temp%\junk
        GOTO END
                                                             


:SYNTAXERR
        echo "SYNTAX : Check_Port <Port_To_Be_Checked>"
        echo "Eg : check_port 80"
        GOTO END
:END
