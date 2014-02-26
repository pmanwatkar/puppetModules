#!/bin/sh
#create table:

db=$1
table_name=$2

user=$3
password=$4
$columnname=$5
service mysqld start

echo "create table $db.$table_name($columnname varchar(255)) ;" | mysql -u$user -p$password
