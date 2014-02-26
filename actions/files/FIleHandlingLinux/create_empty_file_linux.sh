#!/bin/sh
# Creates an empty file at requested location

P=${1?" Directory location with full path, ex. /path/to/file "}
Q=$2

if [ -e $P ]

then

touch "$Q"

else 

echo "Destination location does not exist/ or don't have permission to create"

fi
