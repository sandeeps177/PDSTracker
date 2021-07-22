
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.fps.com:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.fps.com-cert.pem 
fabric-ca-client affiliation add fps  -u https://admin:adminpw@ca.fps.com:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.fps.com-cert.pem 
