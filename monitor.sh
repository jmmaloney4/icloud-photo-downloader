#!/bin/bash

while true; do
  echo $(du -d 0 /data) $(ls -al /data | wc -l)
  sleep 2000
done