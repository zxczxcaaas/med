# Med

Medical records storage with encrypted health data and private patient information

## Introduction

This project provides a privacy-preserving solution utilizing fully homomorphic encryption technology. It enables secure computation on encrypted data without compromising confidentiality.

## Purpose

The primary objective is to demonstrate the practical application of Zama FHEVM in creating systems that maintain data privacy throughout the computation process. This addresses the fundamental limitation of traditional encryption schemes that require decryption for processing.

## Methodology

The system employs Zama's Fully Homomorphic Encryption Virtual Machine to perform operations on encrypted data. Decryption is only performed when explicitly authorized and verified through cryptographic signatures.

## Requirements

- Node.js version 18 or higher
- Hardhat development environment
- Access to Sepolia testnet
- Zama FHEVM compatible environment

## Installation Instructions

`ash
npm install
`

## Compilation

`ash
npm run compile
`

## Configuration

Please refer to env.template for required environment variables. Create a .env file with appropriate values.

## Deployment

`ash
npm run deploy:sepolia
`

Deployed contract addresses will be recorded in contracts.json.

## Contract Documentation

- `HealthRecords`
- `AccessControl`

## Technical Specifications

- FHEVM v0.9 with self-relaying decryption
- Solidity 0.8.24
- TypeScript for type safety
- Hardhat for development and testing

## License

This project is licensed under the MIT License.


