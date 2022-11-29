const hre = require("hardhat");

// Deployed Contract Address: 0x1738adee1F71DE948f58b80A5c85e7a8BDfbDC99
async function runScript() {
  const CreateNFTCollection = await hre.ethers.getContractFactory('CreateNFTCollection')
  const createNFTCollection = await CreateNFTCollection.deploy('JackieChan', 'JC')
  await createNFTCollection.deployed()

  console.log("Contract Deployed: ", createNFTCollection.address)
}

runScript().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
