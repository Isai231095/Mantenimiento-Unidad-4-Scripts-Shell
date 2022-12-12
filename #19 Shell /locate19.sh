#!/bin/sh

locatedb="/tmp/locate.db"

exec grep -i "$@" $locatedb
