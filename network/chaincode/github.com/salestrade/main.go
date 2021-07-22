package main

import (
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	id "github.com/hyperledger/fabric/core/chaincode/shim/ext/cid"
	pb "github.com/hyperledger/fabric/protos/peer"
)

var _MainLogger = shim.NewLogger("PDSTrackLogger")

//SmartContract for Grain tracking
type SmartContract struct {
}

//GrainDetails represents the grain record to be stored in ledger
type GrainDetails struct {
	PurchaseCenterID string `json:"purchaseCenterID"`
	FarmerID         string `json:"farmerID"`
	FieldID          string `json:"fieldID"`
	GrainType        string `json:"grainType"`
	HarvestDate      string `json:"harvestDate"`
	Weight           string `json:"weight"`
	PurchaseDate     string `json:"purchaseDate"`
	Status           string `json:"status"`
	LotID            string `json:"lotID"`
	QualityReport    string `json:"qualityReport"`
	DSWDeportID      string `json:"dswDeportID"`
	DSZDeportID      string `json:"dszDeportID"`
	FPSDeportID      string `json:"fpsDeportID"`
	SSWDeportID      string `json:"sswDeportID"`
	VehicleID        string `json:"vehicleID"`
	Owner            string `json:"owner"`
	UpdateTs         string `json:"ts"`
	TrxnID           string `json:"trxnId"`
	UpdateBy         string `json:"updBy"`
}

// Init initializes chaincode.
func (sc *SmartContract) Init(stub shim.ChaincodeStubInterface) pb.Response {
	_MainLogger.Infof("Inside the init method ")

	return shim.Success(nil)
}
func (sc *SmartContract) probe(stub shim.ChaincodeStubInterface) pb.Response {
	ts := ""
	_MainLogger.Info("Inside probe method")
	tst, err := stub.GetTxTimestamp()
	if err == nil {
		ts = tst.String()
	}
	output := "{\"status\":\"Success\",\"ts\" : \"" + ts + "\" }"
	_MainLogger.Info("Retuning " + output)
	return shim.Success([]byte(output))
}

func (sc *SmartContract) createGrainEntry(stub shim.ChaincodeStubInterface) pb.Response {
	if sc.getOrganizationRole(stub) != "fcipc" {
		_MainLogger.Errorf("Trxn not allowed ")
		return shim.Error("Trxn not allowed ")
	}
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		_MainLogger.Errorf("Invalid number of arguments")
		return shim.Error("Invalid number of arguments")
	}
	var grainDetails GrainDetails
	if err := json.Unmarshal([]byte(args[0]), &grainDetails); err != nil {
		_MainLogger.Errorf("Unable to parse the input grain details JSON %v", err)
		return shim.Error("Unable to parse the input grain details JSON")
	}
	idOk, manuf := sc.getInvokerIdentity(stub)
	if !idOk {
		return shim.Error("Unable to retrive the invoker ID")
	}
	if strings.TrimSpace(grainDetails.LotID) == "" {
		_MainLogger.Error("No Lot ID provided")
		return shim.Error("No Lot ID provided")
	}
	grainDetails.Owner = manuf
	currentDate := time.Now()
	grainDetails.PurchaseDate = currentDate.String()
	grainDetails.UpdateBy = manuf
	grainDetails.Status = "Entered new Grain Details"
	grainDetails.TrxnID = stub.GetTxID()
	grainDetails.UpdateTs = sc.getTrxnTS(stub)
	jsonBytesToStore, _ := json.Marshal(grainDetails)
	//TODO: Check the chasis number
	if err := stub.PutState(grainDetails.LotID, jsonBytesToStore); err != nil {
		_MainLogger.Errorf("Unable to store the grain details %v", err)
		return shim.Error("Unable to store the grain details ")
	}

	return shim.Success([]byte(jsonBytesToStore))
}

func (sc *SmartContract) modifyGrainEntity(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		_MainLogger.Errorf("Invalid number of arguments")
		return shim.Error("Invalid number of arguments")
	}
	var grainDetails GrainDetails
	if err := json.Unmarshal([]byte(args[0]), &grainDetails); err != nil {
		_MainLogger.Errorf("Unable to parse the input Grain details JSON %v", err)
		return shim.Error("Unable to parse the input Grain details JSON")
	}
	idOk, who := sc.getInvokerIdentity(stub)
	if !idOk {
		return shim.Error("Unable to retrive the invoker ID")
	}
	if strings.TrimSpace(grainDetails.LotID) == "" {
		_MainLogger.Error("No Lot ID provided")
		return shim.Error("No Lot ID provided")
	}
	var existingEntity GrainDetails
	recordBytes, err := stub.GetState(grainDetails.LotID)
	if err != nil {
		_MainLogger.Error("Invalid Lot ID provided")
		return shim.Error("Invalid Lot ID provided")
	}
	if err := json.Unmarshal([]byte(recordBytes), &existingEntity); err != nil {
		_MainLogger.Errorf("Unable to parse the existing Grain details JSON %v", err)
		return shim.Error("Unable to parse the existing Grain details JSON")
	}
	existingEntity.UpdateBy = who
	existingEntity.TrxnID = stub.GetTxID()
	existingEntity.UpdateTs = sc.getTrxnTS(stub)
	//TODO: Checks on the status change
	if len(strings.TrimSpace(grainDetails.Status)) > 0 {
		existingEntity.Status = grainDetails.Status
	}
	if len(existingEntity.DSWDeportID) == 0 && len(strings.TrimSpace(grainDetails.DSWDeportID)) > 0 {
		existingEntity.DSWDeportID = grainDetails.DSWDeportID
	}
	if len(existingEntity.DSZDeportID) == 0 && len(strings.TrimSpace(grainDetails.DSZDeportID)) > 0 {
		existingEntity.DSZDeportID = grainDetails.DSZDeportID
	}
	if len(existingEntity.FPSDeportID) == 0 && len(strings.TrimSpace(grainDetails.FPSDeportID)) > 0 {
		existingEntity.FPSDeportID = grainDetails.FPSDeportID
	}
	jsonBytesToStore, _ := json.Marshal(existingEntity)
	//TODO: Check the chasis number
	if err := stub.PutState(grainDetails.LotID, jsonBytesToStore); err != nil {
		_MainLogger.Errorf("Unable to store the Grain details %v", err)
		return shim.Error("Unable to store the Grain details ")
	}

	return shim.Success([]byte(jsonBytesToStore))
}

func (sc *SmartContract) registerOrg(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		return shim.Error("Invalid number of arguments")
	}
	participantRole := args[0]
	idOk, who := sc.getInvokerIdentity(stub)
	if !idOk {
		return shim.Error("Unable to retrive the invoker ID")
	}
	key := fmt.Sprintf("PARTICIPANT_%s", who)
	stub.PutState(key, []byte(participantRole))
	return shim.Success([]byte("Organization registered"))
}

func (sc *SmartContract) queryGrain(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		return shim.Error("Invalid number of arguments")
	}
	key := args[0]
	data, err := stub.GetState(key)
	if err != nil {
		return shim.Success(nil)

	}

	return shim.Success(data)
}

func (sc *SmartContract) queryGrainHistory(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		return shim.Error("Invalid number of arguments")
	}
	key := args[0]
	history, err := stub.GetHistoryForKey(key)
	if err != nil {
		return shim.Error("Unable to retrive history")

	}
	historyRecords := make([]map[string]interface{}, 0)
	for history.HasNext() {
		if rslt, err := history.Next(); err == nil {
			recordMap := make(map[string]interface{})
			if parseErr := json.Unmarshal(rslt.Value, &recordMap); parseErr == nil {
				historyRecords = append(historyRecords, recordMap)
			}
		}
	}
	outputJSON, _ := json.Marshal(historyRecords)
	return shim.Success(outputJSON)
}

//Invoke is the entry point for any transaction
func (sc *SmartContract) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	var response pb.Response
	action, _ := stub.GetFunctionAndParameters()
	switch action {
	case "probe":
		response = sc.probe(stub)
	case "createGrainDetails":
		response = sc.createGrainEntry(stub)
	case "modifyGrainDetails":
		response = sc.modifyGrainEntity(stub)
	case "queryGrain":
		response = sc.queryGrain(stub)
	case "queryHistory":
		response = sc.queryGrainHistory(stub)
	case "registerOrg":
		response = sc.registerOrg(stub)
	default:
		response = shim.Error("Invalid action provoided")
	}
	return response
}

func (sc *SmartContract) getInvokerIdentity(stub shim.ChaincodeStubInterface) (bool, string) {
	//Following id comes in the format X509::<Subject>::<Issuer>>
	/*enCert, err := id.GetX509Certificate(stub)
	if err != nil {
		return false, "Unknown."
	}*/

	mspID, err := id.GetMSPID(stub)
	if err != nil {
		return false, "Unknown."
	}
	return true, fmt.Sprintf("%s", mspID)

}
func (sc *SmartContract) getTrxnTS(stub shim.ChaincodeStubInterface) string {
	txTime, err := stub.GetTxTimestamp()
	if err != nil {
		return "0000.00.00.00.00.000"
	}
	var ts time.Time
	newTS := ts.Add(time.Duration(txTime.Seconds) * time.Second)
	return newTS.Format("2006.01.02.15.04.05.000")

}
func (sc *SmartContract) getOrganizationRole(stub shim.ChaincodeStubInterface) string {
	idOk, who := sc.getInvokerIdentity(stub)
	if !idOk {
		_MainLogger.Error("Unable to retrive the invoker ID")
		return ""
	}
	key := fmt.Sprintf("PARTICIPANT_%s", who)
	_MainLogger.Infof("User key %s", key)
	if roleJSON, err := stub.GetState(key); err == nil {
		_MainLogger.Infof("User key %s", string(roleJSON))
		role := string(roleJSON)
		return role
	}
	_MainLogger.Error("Unable to retrive the role , not registered")
	return ""

}
func main() {
	err := shim.Start(new(SmartContract))
	if err != nil {
		_MainLogger.Criticalf("Error starting  chaincode: %v", err)
	}
}
