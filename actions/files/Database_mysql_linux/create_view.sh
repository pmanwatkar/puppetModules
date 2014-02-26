#!/bin/sh
#create view:

viewName=$1
db=$2
table=$3
user=$4
password=$5

service mysqld start


echo "create view $db.$viewName as select* from $db.$table;" | mysql -u$user -p$password

