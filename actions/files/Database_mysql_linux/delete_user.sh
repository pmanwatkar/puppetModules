#!/bin/sh
#delete user:

deleteUser=$1
rootUser=$2
password=$3

drop user user_name;

service mysqld start

echo "drop user $deleteUser;" | mysql -u$rootUser -p$password

