#create db:
#!/bin/sh
db_name=$1

user=$2
password=$3

service mysqld start

echo "create database $db_name;" | mysql -u$user -p$password
