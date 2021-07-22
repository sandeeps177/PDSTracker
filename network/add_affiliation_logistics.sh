
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.logistics.com:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.logistics.com-cert.pem 
fabric-ca-client affiliation add logistics  -u https://admin:adminpw@ca.logistics.com:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.logistics.com-cert.pem 
