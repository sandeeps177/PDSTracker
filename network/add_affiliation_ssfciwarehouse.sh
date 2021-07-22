
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.ssfciwarehouse.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.ssfciwarehouse.net-cert.pem 
fabric-ca-client affiliation add ssfciwarehouse  -u https://admin:adminpw@ca.ssfciwarehouse.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.ssfciwarehouse.net-cert.pem 
