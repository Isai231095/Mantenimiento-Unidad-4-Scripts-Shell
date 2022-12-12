#!/bin/bash

now="$(date +%y%m%d)"
start="http://www.straightdope.com/ "
to="testing@yourdomain.com"

URL="$(curl -s "$start" | \
  grep -A1 'teaser' | sed -n '2p' | \
  cut -d\" -f2 | cut -d\" -f1)"

( cat << EOF
Subject: The Straight Dope for $(date "+%A, %d %B, %Y")
From: Cecil Adams <dont@reply.com>
Content-type: text/html
To: $to

EOF

curl "$URL"
) | /usr/sbin/sendmail -t

exit 0
