//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract saleERC721 is Ownable, ERC721Enumerable {
    uint256 public costPresale = 0.06 ether;
    uint256 public costPublic = 0.07 ether;
    uint256 public maxSupplyPresale = 1000;
    uint256 public maxSupply = 5000;
    uint256 public maxMintAmountPresale = 3; 
    uint256 public maxMintAmountPublic = 10; 
    uint256 public deployTime;
    uint256 public presaleAddresses = 0;

    mapping(address => bool) public alreadyMintedPresale;
    mapping(address => uint256) public addressMintedBalance;

    event Withdraw(address to, uint256 amount);

    constructor (string memory _name, string memory _symbol) ERC721(_name, _symbol) {
        deployTime = block.timestamp;
    }

    function mint(uint256 _mintAmount) public payable {
        require(msg.sender != owner, "Owner couldn't mint!");
        if(block.timestamp < 2 days + deployTime, "Pre sale is over");
        uint256 supply = totalSupply();
        require(_mintAmount > 0, "You should mint more than 0 NFT");
        require(addressMintedBalance + _mintAmount < maxMintAmountPresale, "")
        require();
        require(!alreadyMintedPresale,"");
    }
}