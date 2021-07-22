#!/bin/bash
rm -rf chaincode/github.com/salestrade/*
cp -r $GOPATH/src/github.com/blockchain/* chaincode/github.com/salestrade/
ls -l chaincode/github.com/salestrade/