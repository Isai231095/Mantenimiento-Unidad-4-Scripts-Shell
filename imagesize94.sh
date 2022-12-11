#!/bin/bash

for name
do
  identify -format "%f: %G with %k colors.\n" "$name"
done
exit 0
