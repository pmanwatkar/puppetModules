#!/bin/sh
#drop db:

db_name=$1

user=$2
password=$3

service mysqld start

echo "drop database $db_name;" | mysql -u$user -p$password
