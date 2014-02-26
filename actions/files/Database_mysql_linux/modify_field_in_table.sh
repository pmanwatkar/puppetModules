#!/bin/bash
username=$1
password=$2
dbname=$3
table=$4
field1=$5
value1=$6
field2=$7
value2=$8

echo "use $dbname;update $table set $field2='$value2' where $field1=$value1;" | mysql -u$user -p$password
