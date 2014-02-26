@echo off
set file=%1
for /f %%i in ('find /v /c "" ^< %file%') do set /a lines=%%i
echo %lines%
