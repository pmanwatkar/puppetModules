@echo off

set filePath=%1
set string=%2
findstr /x /c:"%string%" %filePath%

::Match .txt files that contain an exact match on "computer help"; therefore, files that contain "computer helps" or other non-exact matches will not be displayed. It is important to realize that using /x must be a line that exactly matches "computer help"; in other words, if anything else is on the same line, it's not an exact match.
