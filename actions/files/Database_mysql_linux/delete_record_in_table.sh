#!/bin/bash
username=$1
password=$2
dbname=$3
table=$4
field=$5
value=$6



echo "use $dbname;delete from $table where $field=$value;" | mysql -u$user -p$password
