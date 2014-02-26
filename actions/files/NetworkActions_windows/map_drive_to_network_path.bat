@echo off
set computer=%1
set folder=%2
set drive=%3
net use %drive%: \\%computer%\%folder%


