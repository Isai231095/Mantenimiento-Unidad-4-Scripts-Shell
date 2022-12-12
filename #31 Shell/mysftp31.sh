#!/bin/bash

/bin/echo -n "User account: "
read account

if [ -z $account ] ; then
  exit 0;       
fi

if [ -z "$1" ] ; then
  /bin/echo -n "Remote host: "
  read host
  if [ -z $host ] ; then
    exit 0
  fi
else
  host=$1
fi
exec sftp -C $account@$host
