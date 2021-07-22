
#!/bin/bash -e
export PWD=`pwd`

export FABRIC_CFG_PATH=$PWD
export ARCH=$(uname -s)
export CRYPTOGEN=$PWD/bin/cryptogen
export CONFIGTXGEN=$PWD/bin/configtxgen

function generateArtifacts() {
	
	echo " *********** Generating artifacts ************ "
	echo " *********** Deleting old certificates ******* "
	
        rm -rf ./crypto-config
	
        echo " ************ Generating certificates ********* "
	
        $CRYPTOGEN generate --config=$FABRIC_CFG_PATH/crypto-config.yaml
        
        echo " ************ Generating tx files ************ "
	
		$CONFIGTXGEN -profile OrdererGenesis -outputBlock ./genesis.block
		
		$CONFIGTXGEN -profile trace -outputCreateChannelTx ./trace.tx -channelID trace
		
		echo "Generating anchor peers tx files for  FPS"
		$CONFIGTXGEN -profile trace -outputAnchorPeersUpdate  ./traceFPSMSPAnchor.tx -channelID trace -asOrg FPSMSP
		
		echo "Generating anchor peers tx files for  FCIPC"
		$CONFIGTXGEN -profile trace -outputAnchorPeersUpdate  ./traceFCIPCMSPAnchor.tx -channelID trace -asOrg FCIPCMSP
		
		echo "Generating anchor peers tx files for  SSFciWarehouse"
		$CONFIGTXGEN -profile trace -outputAnchorPeersUpdate  ./traceSSFciWarehouseMSPAnchor.tx -channelID trace -asOrg SSFciWarehouseMSP
		
		echo "Generating anchor peers tx files for  DSFciWarehouse"
		$CONFIGTXGEN -profile trace -outputAnchorPeersUpdate  ./traceDSFciWarehouseMSPAnchor.tx -channelID trace -asOrg DSFciWarehouseMSP
		
		echo "Generating anchor peers tx files for  DSZonalWarehouse"
		$CONFIGTXGEN -profile trace -outputAnchorPeersUpdate  ./traceDSZonalWarehouseMSPAnchor.tx -channelID trace -asOrg DSZonalWarehouseMSP
		
		echo "Generating anchor peers tx files for  Logistics"
		$CONFIGTXGEN -profile trace -outputAnchorPeersUpdate  ./traceLogisticsMSPAnchor.tx -channelID trace -asOrg LogisticsMSP
		

		

}
function generateDockerComposeFile(){
	OPTS="-i"
	if [ "$ARCH" = "Darwin" ]; then
		OPTS="-it"
	fi
	cp  docker-compose-template.yaml  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/fps.com/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/FPS_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/fcipurchasecentre.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/FCIPC_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/ssfciwarehouse.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/SSFCIWAREHOUSE_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/dsfciwarehouse.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/DSFCIWAREHOUSE_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/dszonalwarehouse.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/DSZONALWAREHOUSE_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
	
	cd  crypto-config/peerOrganizations/logistics.com/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/LOGISTICS_PRIVATE_KEY/${PRIV_KEY}/g"  docker-compose.yaml
	
}
generateArtifacts 
cd $PWD
generateDockerComposeFile
cd $PWD

