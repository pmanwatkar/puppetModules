#!/bin/sh

CMD=$1
DIR=$2
BACKGROUND=$3
 
if [ $BACKGROUND == "Yes" ]
then
   cd $DIR 
   $CMD &
else
    cd $DIR
    $CMD
fi
