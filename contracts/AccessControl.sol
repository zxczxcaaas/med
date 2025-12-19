// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";

// manages doctor access to records
contract AccessControl is ZamaEthereumConfig {
    // patient => doctor => hasAccess
    mapping(address => mapping(address => bool)) public accessGrants;
    
    // patient => emergency contacts
    mapping(address => address[]) public emergencyContacts;
    
    event AccessGranted(address indexed patient, address indexed doctor);
    event AccessRevoked(address indexed patient, address indexed doctor);
    event EmergencyAccess(address indexed patient, address indexed contact);
    
    function grantAccess(address doctor) external {
        accessGrants[msg.sender][doctor] = true;
        emit AccessGranted(msg.sender, doctor);
    }
    
    function revokeAccess(address doctor) external {
        accessGrants[msg.sender][doctor] = false;
        emit AccessRevoked(msg.sender, doctor);
    }
    
    function addEmergencyContact(address contact) external {
        emergencyContacts[msg.sender].push(contact);
    }
    
    function hasAccess(address patient, address doctor) external view returns (bool) {
        return accessGrants[patient][doctor];
    }
}

