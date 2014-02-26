#!/bin/sh
echo "The IPV 4 ip addresses assigned to this machine are:"
ifconfig | grep "inet addr"|cut -d: -f2| cut -d' ' -f1

echo ""

echo "The IPV 6 ip addresses assigned to this machine are:"
ifconfig | grep "inet6 addr"| sed s:\^' '*:: |cut -d' ' -f3
