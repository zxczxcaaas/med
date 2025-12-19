// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

// stores encrypted medical records
contract HealthRecords is ZamaEthereumConfig {
    struct Record {
        address patient;
        uint256 recordType;  // 1=visit, 2=test, 3=diagnosis, etc
        euint32 data;        // encrypted medical data
        uint256 timestamp;
        address doctor;
    }
    
    mapping(address => uint256[]) public patientRecords;
    mapping(uint256 => Record) public records;
    uint256 public recordCounter;
    
    event RecordAdded(uint256 indexed recordId, address patient);
    event RecordShared(uint256 indexed recordId, address doctor);
    
    // add medical record
    function addRecord(
        uint256 recordType,
        euint32 encryptedData,
        address doctor
    ) external returns (uint256 recordId) {
        recordId = recordCounter++;
        records[recordId] = Record({
            patient: msg.sender,
            recordType: recordType,
            data: encryptedData,
            timestamp: block.timestamp,
            doctor: doctor
        });
        
        patientRecords[msg.sender].push(recordId);
        emit RecordAdded(recordId, msg.sender);
    }
    
    // share record with doctor
    function shareRecord(uint256 recordId, address doctor) external {
        Record storage record = records[recordId];
        require(record.patient == msg.sender, "Not your record");
        
        emit RecordShared(recordId, doctor);
    }
    
    function getRecordCount(address patient) external view returns (uint256) {
        return patientRecords[patient].length;
    }
}

