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

# GeoServer
ATTEMPTS=0
while true
do
  curl http://geoserver:8080/geoserver/index.html

  if [ $? -eq 0 ]
  then
    break
  else 
    let ATTEMPTS=ATTEMPTS+1
    if [ $ATTEMPTS -gt 10 ]
    then
      echo "Timed out waiting for geoserver"
      exit 1
    else
      sleep 10
    fi
  fi
done
echo "Geoserver found"

# RabbitMQ
ATTEMPTS=0
while true
do
  curl rabbitmq:15672

  if [ $? -eq 0 ]
  then
    break
  else 
    let ATTEMPTS=ATTEMPTS+1
    if [ $ATTEMPTS -gt 10 ]
    then
      echo "Timed out waiting for rabbitmq"
      exit 1
    else
      sleep 10
    fi
  fi
done
echo "Rabbitmq found"

echo "$cmd"
$cmd
