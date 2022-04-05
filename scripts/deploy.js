const hre = require("hardhat");

async function main() {
  const SaleERC721 = await ethers.getContractFactory("saleERC721");
  const sale = await SaleERC721.deploy("saleERC721", "SaleERC721");//в скобки вписываем значения конструктора
  await sale.deployed();// доп логика

  console.log("saleERC721 deployed to:", sale.address);//выводит в консоль название контракта и адресс контракта который задеплоили
}

main()// просто запускаем async function 
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
