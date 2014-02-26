@echo off

set file_wid_path=%1
set string=%2
find /c "%string%" %file_wid_path%

::The above example would find any "REM" statement in the autoexec.bat.
