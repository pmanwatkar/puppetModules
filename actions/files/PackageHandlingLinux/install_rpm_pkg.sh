#!/bin/bash -

# @(#) user1    Demonstrate rpm query.

#uname -rv
#bash --version
#rpm --version

P=${1?" must specify package name.Ex. package_name=abc.x.x.x "}

rpm -ivh "$P"


exit 0
