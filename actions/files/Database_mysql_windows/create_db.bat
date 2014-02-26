@echo off
set dbname=%1
set user=%2
set password=%3

echo create database %dbname%; | "C:\Program Files\MySQL\bin\mysql.exe" -u%user% -p%password%