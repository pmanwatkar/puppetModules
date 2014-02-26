#!/bin/sh
SERVICE=$1
ps ax | grep $SERVICE | grep -v grep | grep -v CheckifProcess > temp

if [ -s temp  ];
then
    echo "$SERVICE service running, everything is fine"
else
    echo "$SERVICE is not running"
fi
rm temp
