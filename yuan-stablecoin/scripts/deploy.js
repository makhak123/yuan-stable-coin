const hre = require("hardhat")

async function main() {
  console.log("Deploying YuanCoin (CNYS) stablecoin...")

  // Get the contract factory
  const YuanCoin = await hre.ethers.getContractFactory("YuanCoin")

  // Deploy the contract
  const yuanCoin = await YuanCoin.deploy()

  await yuanCoin.waitForDeployment()

  const address = await yuanCoin.getAddress()

  console.log("✅ YuanCoin deployed to:", address)
  console.log("\nContract details:")
  console.log("- Name:", await yuanCoin.name())
  console.log("- Symbol:", await yuanCoin.symbol())
  console.log("- Decimals:", await yuanCoin.decimals())

  // Get the deployer address
  const [deployer] = await hre.ethers.getSigners()
  console.log("\nDeployer address:", deployer.address)
  console.log("Deployer has all roles (ADMIN, MINTER, PAUSER, BLACKLISTER)")

  console.log("\n📝 Save this contract address for future interactions!")
  console.log("\nTo verify on Etherscan, run:")
  console.log(`npx hardhat verify --network ${hre.network.name} ${address}`)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
