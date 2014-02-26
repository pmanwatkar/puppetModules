#!/bin/sh
#delete view:

viewName=$1
user=$2
password=$3
dbName=$4

service mysqld start

echo "drop view $dbName.$viewName;" | mysql -u root -p $password
