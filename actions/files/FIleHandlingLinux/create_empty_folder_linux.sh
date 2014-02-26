#!/bin/sh
# Creates an empty folder at requested location

P=${1? " Folder name with full path, ex. /path/to/folder "}
Q=$2

if [ -e $P ];

then

mkdir "$Q"

else

echo "Destination location does not exist/ or don't have permission to create"

fi

