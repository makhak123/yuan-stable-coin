const hre = require("hardhat")

async function main() {
  // Replace with your deployed contract address
  const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS || "YOUR_CONTRACT_ADDRESS_HERE"

  // Replace with the recipient address
  const RECIPIENT = process.env.RECIPIENT || "YOUR_RECIPIENT_ADDRESS_HERE"

  // Amount to mint (in CNYS, will be converted to smallest unit)
  const AMOUNT = process.env.AMOUNT || "1000" // 1000 CNYS

  console.log("Minting CNYS tokens...")
  console.log("Contract:", CONTRACT_ADDRESS)
  console.log("Recipient:", RECIPIENT)
  console.log("Amount:", AMOUNT, "CNYS")

  // Get the contract
  const YuanCoin = await hre.ethers.getContractFactory("YuanCoin")
  const yuanCoin = YuanCoin.attach(CONTRACT_ADDRESS)

  // Convert amount to smallest unit (6 decimals)
  const amountInSmallestUnit = hre.ethers.parseUnits(AMOUNT, 6)

  // Mint tokens
  const tx = await yuanCoin.mint(RECIPIENT, amountInSmallestUnit)
  console.log("\nTransaction hash:", tx.hash)
  console.log("Waiting for confirmation...")

  await tx.wait()

  console.log("✅ Minted", AMOUNT, "CNYS to", RECIPIENT)

  // Check balance
  const balance = await yuanCoin.balanceOf(RECIPIENT)
  const formattedBalance = hre.ethers.formatUnits(balance, 6)
  console.log("New balance:", formattedBalance, "CNYS")
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
