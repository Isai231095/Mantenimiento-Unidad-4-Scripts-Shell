#!/bin/bash

#TENEMOS QUE EJECUTARLO CON ROOT#

locatedb="/var/locate.db"
slocatedb=".slocatedb"

if [ "$(id -nu)" != "root" ] ; then
  echo "$0: Error: You must be root to run this command." >&2
  exit 1
fi

if [ "$(grep '^nobody:' /etc/passwd)" = "" ] ; then
  echo "$0: Error: you must have an account for user 'nobody'" >&2
  echo "to create the default slocate database." >&2; exit 1
fi

cd /            
su -fm nobody -c "find / -print" > $locatedb 2>/dev/null
echo "building default slocate database (user = nobody)"
echo ... result is $(wc -l < $locatedb) lines long.

for account in $(cut -d: -f1 /etc/passwd)
do
  homedir="$(grep "^${account}:" /etc/passwd | cut -d: -f6)"

  if [ "$homedir" = "/" ] ; then
    continue   
  elif [ -e $homedir/$slocatedb ] ; then
    echo "building slocate database for user $account"
    su -m $account -c "find / -print" > $homedir/$slocatedb \
     2>/dev/null
    chmod 600 $homedir/$slocatedb
    chown $account $homedir/$slocatedb
    echo ... result is $(wc -l < $homedir/$slocatedb) lines long.
  fi
done

exit 0
