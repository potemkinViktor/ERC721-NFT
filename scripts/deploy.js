const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log(`Deploying contract with the account: ${deployer.address}`);

    const NFT = await ethers.getContractFactory('NFTsale');
    const nft = await NFT.deploy("saleERC721", "NFT");
    console.log(`saleERC721 address: ${nft.address}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
