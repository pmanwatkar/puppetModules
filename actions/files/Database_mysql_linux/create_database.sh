#!/bin/bash
username=$1
password=$2
dbname=$3

echo "create database $dbname;" | mysql -u$user -p$password
