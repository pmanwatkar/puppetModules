#!/bin/sh
#drop table:

db=$1
table_name=$2

user=$3
password=$4

service mysqld start

echo "drop table $db.$table_name;" | mysql -u$user -p$password
