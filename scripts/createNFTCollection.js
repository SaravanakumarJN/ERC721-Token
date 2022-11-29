const hre = require("hardhat");

// Deployed Contract Address: 0xb5B2322027267C29282e177eE68f0Ea08B83be2C
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
