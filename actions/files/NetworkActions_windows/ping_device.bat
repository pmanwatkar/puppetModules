@echo off

REM checking arguments

        IF %1.==. GOTO SYNTAXERR

REM here the actual code starts

       ping %1 1> %temp%\junk  2>&1
	::ping %1 >file1.txt

REM Managing Error

        if %ERRORLEVEL% NEQ 0 GOTO ERR
        if %ERRORLEVEL% EQU 0 GOTO SUCCESS

:ERR
        echo The device is not pingable.
        del %temp%\junk
        GOTO END

:SUCCESS
        echo The device is pingable.
        del %temp%\junk
        GOTO END
                                                             


:SYNTAXERR
        echo "SYNTAX : Ping_Device.bat <Device_To_Be_Pingged>">>file1.txt
        echo "Eg : ping_device.bat 192.168.1.1">>file1.txt
        GOTO END
:END
