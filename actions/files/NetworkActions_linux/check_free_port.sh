#!/bin/bash

P=${1?" Please Enter a valid port."}

lsof -i :$P >temp

if [ -s temp ];then

        echo "Port is not free"

else 
	echo "Port is free" 
fi

rm temp
