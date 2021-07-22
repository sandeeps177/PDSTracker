
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.fcipurchasecentre.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.fcipurchasecentre.net-cert.pem 
fabric-ca-client affiliation add fcipc  -u https://admin:adminpw@ca.fcipurchasecentre.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.fcipurchasecentre.net-cert.pem 
