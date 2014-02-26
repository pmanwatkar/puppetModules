@echo off

set file_with_path=%1
set string=%2
findstr /s "%string%" %file_wid_path%\*.*

::Similar to the first example, the above example would find any lines containing "computer help" in any txt file in the current directory and all sub directories
