#!/bin/bash
username=$1
password=$2
dbname=$3



echo "use $dbname;show tables;" | mysql -u$user -p$password