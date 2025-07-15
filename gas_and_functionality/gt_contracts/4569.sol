// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract WhaleMarketplace is Ownable {
    using SafeMath for uint256;

    struct Whale {
        string name;
    }

    mapping(uint256 => Whale) public whales;
    mapping(uint256 => uint256) public whaleIndexToPrice;
    mapping(uint256 => address) public whaleIndexToOwner;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        whales[1] = Whale({name: "Whale 1"});
        whales[2] = Whale({name: "Whale 2"});
        whales[3] = Whale({name: "Whale 3"});
        
        whaleIndexToPrice[1] = 1;
        whaleIndexToPrice[2] = 2;
        whaleIndexToPrice[3] = 3;
        
        whaleIndexToOwner[1] = address(0x111);
        whaleIndexToOwner[2] = address(0x222);
        whaleIndexToOwner[3] = address(0x333);
    }

    function getWhale(uint256 _tokenId) public view returns (uint256 Id, string memory whaleName, uint256 sellingPrice, address owner) {
        Whale storage whale = whales[_tokenId];
        Id = _tokenId;
        whaleName = whale.name;
        sellingPrice = whaleIndexToPrice[_tokenId];
        owner = whaleIndexToOwner[_tokenId];
    }
}