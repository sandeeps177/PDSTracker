
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.dsfciwarehouse.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.dsfciwarehouse.net-cert.pem 
fabric-ca-client affiliation add dsfciwarehouse  -u https://admin:adminpw@ca.dsfciwarehouse.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.dsfciwarehouse.net-cert.pem 
