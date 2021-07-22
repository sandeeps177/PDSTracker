
#!/bin/bash -e




	
	echo "Building channel for trace" 
	
	. setpeer.sh FPS peer0
	export CHANNEL_NAME="trace"
	peer channel create -o orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./trace.tx --tls true --cafile $ORDERER_CA -t 1000s
	
		
        
            . setpeer.sh FPS peer0
            export CHANNEL_NAME="trace"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh FCIPC peer0
            export CHANNEL_NAME="trace"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh SSFciWarehouse peer0
            export CHANNEL_NAME="trace"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh DSFciWarehouse peer0
            export CHANNEL_NAME="trace"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh DSZonalWarehouse peer0
            export CHANNEL_NAME="trace"
			peer channel join -b $CHANNEL_NAME.block
		
	
		
        
            . setpeer.sh Logistics peer0
            export CHANNEL_NAME="trace"
			peer channel join -b $CHANNEL_NAME.block
		
	
	
	
	
		. setpeer.sh FPS peer0
		export CHANNEL_NAME="trace"
		peer channel update -o  orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./traceFPSMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh FCIPC peer0
		export CHANNEL_NAME="trace"
		peer channel update -o  orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./traceFCIPCMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh SSFciWarehouse peer0
		export CHANNEL_NAME="trace"
		peer channel update -o  orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./traceSSFciWarehouseMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh DSFciWarehouse peer0
		export CHANNEL_NAME="trace"
		peer channel update -o  orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./traceDSFciWarehouseMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh DSZonalWarehouse peer0
		export CHANNEL_NAME="trace"
		peer channel update -o  orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./traceDSZonalWarehouseMSPAnchor.tx --tls --cafile $ORDERER_CA 
	

	
	
		. setpeer.sh Logistics peer0
		export CHANNEL_NAME="trace"
		peer channel update -o  orderer0.supplychain.net:7050 -c $CHANNEL_NAME -f ./traceLogisticsMSPAnchor.tx --tls --cafile $ORDERER_CA 
	




