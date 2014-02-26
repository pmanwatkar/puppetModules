#/bin/sh

repoType=$1
url=$2
userName=$3
password=$4

if [ "$repoType" == "GIT" ]; then
  ssh -i /usr/Devops/Keys/${keyName}.pem -o StrictHostKeyChecking=no root@$ipaddress puppet agent -t
elif [ "$repoType" == "SVN" ]; then
  (echo "C:\\Devops\\temp\\installModules.bat"; echo exit; ) | winexe -U devops%Admin098 -W WORKGROUP //$ipaddress "cmd.exe"
fi

