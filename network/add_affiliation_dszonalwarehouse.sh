
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.dszonalwarehouse.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.dszonalwarehouse.net-cert.pem 
fabric-ca-client affiliation add dszonalwarehouse  -u https://admin:adminpw@ca.dszonalwarehouse.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.dszonalwarehouse.net-cert.pem 
