@echo off

set mem_usage=%1
tasklist /fi "memusage gt %mem_usage%"


