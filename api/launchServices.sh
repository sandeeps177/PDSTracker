#!/bin/bash
rm *.log
nohup ./xclient -p=9090 ../network/connection-profile-fps.yaml > fps.log 2>&1 &
nohup ./xclient -p=9091 ../network/connection-profile-fcipc.yaml > fcipc.log 2>&1 &
nohup ./xclient -p=9092 ../network/connection-profile-ssfciwarehouse.yaml > ssfciwarehouse.log 2>&1 &
nohup ./xclient -p=9093 ../network/connection-profile-dsfciwarehouse.yaml > dsfciwarehouse.log 2>&1 &
nohup ./xclient -p=9094 ../network/connection-profile-dszonalwarehouse.yaml > dszonalwarehouse.log 2>&1 &
nohup ./xclient -p=9095 ../network/connection-profile-logistics.yaml > logistics.log 2>&1 &