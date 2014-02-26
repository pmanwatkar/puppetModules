::arguement:key
@echo off
set key=%1%
set value=%2
set data_type=%3
set data=%4
reg add %key% /f /v %value% /t %data_type% /d %data%
::reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /f /v DisableTaskMgr /t REG_DWORD /d 1

