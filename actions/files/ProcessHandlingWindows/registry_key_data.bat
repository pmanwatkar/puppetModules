::arguements:registry key
@echo off
set key=%1
set value=%2
set data_type=%3
REG QUERY %key% /v %value% /t %data_type% 
::REG QUERY HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD 
if errorlevel 1 (
    echo Num 1 
) else (
    echo Num 2 
)


