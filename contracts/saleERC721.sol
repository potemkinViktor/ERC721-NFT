//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract saleERC721 is Ownable, ERC721Enumerable {
    uint256 public costPresale = 0.06 ether;
    uint256 public costPublic = 0.07 ether;
    uint256 public maxSupplyPresale = 1000;
    uint256 public maxSupply = 5000;
    uint256 public maxMintAmountPresale = 3; //не выгоднее ли по газу просто использовать число в require
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
        require(msg.sender != owner(), "Owner couldn't mint!");
        if(block.timestamp < 2 days + deployTime && maxSupplyPresale > 0 ) {
            uint256 supply = totalSupply();
            require(_mintAmount > 0, "You should mint more than 0 NFT");
            require(addressMintedBalance[msg.sender] + _mintAmount < maxMintAmountPresale, "Limit of presale NFT for one address is over");
            require(supply + _mintAmount < maxSupplyPresale, "Limit of presale NFT is over or try to mint less");
            require(msg.value >= costPresale*_mintAmount, "Sorry you don't have enough money");

            for(uint256 i=1; i<= _mintAmount; i++) {
                addressMintedBalance[msg.sender]++;
                _safeMint(msg.sender, supply+i);
            }

            if(msg.value > costPresale*_mintAmount) {
                payable(msg.sender).transfer(msg.value-(costPresale*_mintAmount));
            }

            if(!alreadyMintedPresale[msg.sender] == true) {
                presaleAddresses += 1;
                alreadyMintedPresale[msg.sender] = true;
            }
        } else {
            require(maxSupply > 0, "Public sale is over");
            uint256 supply = totalSupply();
            require(_mintAmount > 0, "You should mint more than 0 NFT");
            require(addressMintedBalance[msg.sender] + _mintAmount < maxMintAmountPublic, "Limit of public sale NFT for one transaction");
            require(supply + _mintAmount < maxSupply, "Limit of public sale NFT is over or try to mint less");
            require(msg.value >= costPublic*_mintAmount, "Sorry you don't have enough money");

            for(uint256 i=1; i<= _mintAmount; i++) {
                addressMintedBalance[msg.sender]++;
                _safeMint(msg.sender, supply+i);
            }

            if(msg.value > costPresale*_mintAmount) {
                payable(msg.sender).transfer(msg.value-(costPresale*_mintAmount));
            }
        } 
    }

    function airdrop(address[] memory _users) public onlyOwner {
    require(_users.length == 100, "Only 100 users");
    uint256 supply = totalSupply();
      for (uint256 i = 0; i < _users.length; i++) {
        addressMintedBalance[_users[i]]++;
        _safeMint(_users[i], supply + i);
      }
  }
 
  function withdraw(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Wrong address");
        payable(to).transfer(amount);

        emit Withdraw(to, amount);
    }
}
