#!/bin/bash
echo "$*" | awk '{ printf "%s", $0 }'


