#!/bin/bash

cmd="$@"

# Postgis
ATTEMPTS=0
while true
do
  pg_isready -h postgis

  if [ $? -eq 0 ]
  then
    break
  else 
    let ATTEMPTS=ATTEMPTS+1
    if [ $ATTEMPTS -gt 10 ]
    then
      echo "Timed out waiting for postgis"
      exit 1
    else
      sleep 10
    fi
  fi
done
echo "Postgis found"

sh -c "$cmd"
