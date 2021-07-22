#!/bin/bash
if [[ ! -z "$1" ]]; then  
	. setpeer.sh FPS peer0 
export CHANNEL_NAME="trace"
	peer chaincode install -n salestrade -v $1 -l golang -p  github.com/salestrade
	. setpeer.sh FCIPC peer0 
export CHANNEL_NAME="trace"
	peer chaincode install -n salestrade -v $1 -l golang -p  github.com/salestrade
	. setpeer.sh SSFciWarehouse peer0 
export CHANNEL_NAME="trace"
	peer chaincode install -n salestrade -v $1 -l golang -p  github.com/salestrade
	. setpeer.sh DSFciWarehouse peer0 
export CHANNEL_NAME="trace"
	peer chaincode install -n salestrade -v $1 -l golang -p  github.com/salestrade
	. setpeer.sh DSZonalWarehouse peer0 
export CHANNEL_NAME="trace"
	peer chaincode install -n salestrade -v $1 -l golang -p  github.com/salestrade
	. setpeer.sh Logistics peer0 
export CHANNEL_NAME="trace"
	peer chaincode install -n salestrade -v $1 -l golang -p  github.com/salestrade
	peer chaincode upgrade -o orderer0.supplychain.net:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C trace -n salestrade -v $1 -c '{"Args":["init",""]}' -P " OR( 'FPSMSP.member','FCIPCMSP.member','SSFciWarehouseMSP.member','DSFciWarehouseMSP.member','DSZonalWarehouseMSP.member','LogisticsMSP.member' ) " 
else
	echo ". salestrade_updchain.sh  <Version Number>" 
fi
