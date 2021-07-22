
#!/bin/bash
export ORDERER_CA=/opt/ws/crypto-config/ordererOrganizations/supplychain.net/msp/tlscacerts/tlsca.supplychain.net-cert.pem

if [ $# -lt 2 ];then
	echo "Usage : . setpeer.sh FPS|FCIPC|SSFciWarehouse|DSFciWarehouse|DSZonalWarehouse|Logistics| <peerid>"
fi
export peerId=$2

if [[ $1 = "FPS" ]];then
	echo "Setting to organization FPS peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.fps.com:7051
	export CORE_PEER_LOCALMSPID=FPSMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/fps.com/peers/$peerId.fps.com/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/fps.com/peers/$peerId.fps.com/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/fps.com/peers/$peerId.fps.com/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/fps.com/users/Admin@fps.com/msp
fi

if [[ $1 = "FCIPC" ]];then
	echo "Setting to organization FCIPC peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.fcipurchasecentre.net:7051
	export CORE_PEER_LOCALMSPID=FCIPCMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/fcipurchasecentre.net/peers/$peerId.fcipurchasecentre.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/fcipurchasecentre.net/peers/$peerId.fcipurchasecentre.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/fcipurchasecentre.net/peers/$peerId.fcipurchasecentre.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/fcipurchasecentre.net/users/Admin@fcipurchasecentre.net/msp
fi

if [[ $1 = "SSFciWarehouse" ]];then
	echo "Setting to organization SSFciWarehouse peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.ssfciwarehouse.net:7051
	export CORE_PEER_LOCALMSPID=SSFciWarehouseMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/ssfciwarehouse.net/peers/$peerId.ssfciwarehouse.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/ssfciwarehouse.net/peers/$peerId.ssfciwarehouse.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/ssfciwarehouse.net/peers/$peerId.ssfciwarehouse.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/ssfciwarehouse.net/users/Admin@ssfciwarehouse.net/msp
fi

if [[ $1 = "DSFciWarehouse" ]];then
	echo "Setting to organization DSFciWarehouse peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.dsfciwarehouse.net:7051
	export CORE_PEER_LOCALMSPID=DSFciWarehouseMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/dsfciwarehouse.net/peers/$peerId.dsfciwarehouse.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/dsfciwarehouse.net/peers/$peerId.dsfciwarehouse.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/dsfciwarehouse.net/peers/$peerId.dsfciwarehouse.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/dsfciwarehouse.net/users/Admin@dsfciwarehouse.net/msp
fi

if [[ $1 = "DSZonalWarehouse" ]];then
	echo "Setting to organization DSZonalWarehouse peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.dszonalwarehouse.net:7051
	export CORE_PEER_LOCALMSPID=DSZonalWarehouseMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/dszonalwarehouse.net/peers/$peerId.dszonalwarehouse.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/dszonalwarehouse.net/peers/$peerId.dszonalwarehouse.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/dszonalwarehouse.net/peers/$peerId.dszonalwarehouse.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/dszonalwarehouse.net/users/Admin@dszonalwarehouse.net/msp
fi

if [[ $1 = "Logistics" ]];then
	echo "Setting to organization Logistics peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.logistics.com:7051
	export CORE_PEER_LOCALMSPID=LogisticsMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/logistics.com/peers/$peerId.logistics.com/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/logistics.com/peers/$peerId.logistics.com/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/logistics.com/peers/$peerId.logistics.com/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/logistics.com/users/Admin@logistics.com/msp
fi

	