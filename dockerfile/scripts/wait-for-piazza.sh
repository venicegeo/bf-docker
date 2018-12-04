#!/bin/bash

cmd="$@"

# Waiting for Piazza to start
ATTEMPTS=0
while true
do
  curl http://piazza:8080

  if [ $? -eq 0 ]
  then
    break
  else 
    let ATTEMPTS=ATTEMPTS+1
    if [ $ATTEMPTS -gt 10 ]
    then
      echo "Timed out waiting for Piazza"
      exit 1
    else
      sleep 10
    fi
  fi
done
echo "Piazza found"

$cmd
