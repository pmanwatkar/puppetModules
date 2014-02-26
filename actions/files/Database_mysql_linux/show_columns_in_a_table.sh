#!/bin/bash
username=$1
password=$2
dbname=$3
table=$4

echo "show columns from $dbname.$table;" | mysql -u$user -p$password
