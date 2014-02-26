#!/bin/bash
username=$1
password=$2
dbname=$3
table=$4



echo "use $dbname;select * from $table;" | mysql -u$user -p$password

