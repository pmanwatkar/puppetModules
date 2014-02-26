@echo off


set path=%1
set string=%2
findstr /n /i /c:"%string%" %path%\*

::Search for any file containing "computer help" regardless of its case and display the line where the text is found. Below is an example of how the results in the above example may be displayed.
