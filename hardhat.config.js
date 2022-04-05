require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

 require('dotenv').config()
 const INFURA_URL = process.env.INFURA_URL
 const PRIVATE_KEY = process.env.PRIVATE_KEY

module.exports = {
  solidity: "0.8.13",
  networks: {
    rinkeby: {
      url: INFURA_URL,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  },
  etherscan: {
    apiKey: "PY19J8WKW7717MZMKU4UXDZSPUH5S9HI9F"
  }
};
