import { ethers } from "hardhat";
import * as dotenv from "dotenv";
import * as fs from "fs";
import * as path from "path";

dotenv.config();

async function main() {
  const signers = await ethers.getSigners();
  if (signers.length === 0) {
    throw new Error("No signers found. Check your .env file and hardhat.config.ts");
  }
  const deployer = signers[0];
  
  console.log("Deploying contracts...");
  const balance = await ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", ethers.formatEther(balance), "ETH");
  console.log("Deployer address:", deployer.address);
  
  const contracts: Record<string, string> = {};
  
  // Load existing contracts.json if it exists
  const contractsPath = path.join(__dirname, "..", "contracts.json");
  if (fs.existsSync(contractsPath)) {
    const existing = JSON.parse(fs.readFileSync(contractsPath, "utf-8"));
    Object.assign(contracts, existing);
  }
  
  // Deploy AccessControl if not already deployed
  if (!contracts["AccessControl"] || contracts["AccessControl"] === "") {
    console.log("\n📦 Deploying AccessControl...");
    const AccessControlFactory = await ethers.getContractFactory("AccessControl");
    const accessControl = await AccessControlFactory.deploy();
    await accessControl.waitForDeployment();
    const accessControlAddress = await accessControl.getAddress();
    contracts["AccessControl"] = accessControlAddress;
    console.log("✅ AccessControl deployed to:", accessControlAddress);
  } else {
    console.log("AccessControl already deployed:", contracts["AccessControl"]);
  }
  
  // Summary
  console.log("\n" + "=".repeat(60));
  console.log("Deployment Summary");
  console.log("=".repeat(60));
  for (const [name, address] of Object.entries(contracts)) {
    console.log(name + ":", address);
  }
  console.log("=".repeat(60));
  
  // Save to contracts.json
  fs.writeFileSync(contractsPath, JSON.stringify(contracts, null, 2));
  console.log("\nContract addresses saved to contracts.json");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
