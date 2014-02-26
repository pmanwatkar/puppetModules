#!/bin/sh
#create backup:

db=$1
table=$2
backupDb=$3
backupTable=$4
user=$5
password=$6

service mysqld start

echo "create table $backupDb.$backupTable(select * from $db.$table);" | mysql -u$user -p$password
