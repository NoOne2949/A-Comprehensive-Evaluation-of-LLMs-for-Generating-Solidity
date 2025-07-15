// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Collectible is Ownable {
    using SafeMath for uint256;

    struct Token {
        uint256 price;
        address owner;
    }

    mapping(uint256 => Token) public collectibleIdx;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function getInitialPriceOfToken(uint256 _tokenId) internal view returns (uint256) {
        // Implement the logic to calculate initial price of token
        return 0; // Placeholder, replace with actual implementation
    }

    function getNextPrice(uint256 currentPrice, uint256 _tokenId) internal view returns (uint256) {
        // Implement the logic to calculate next selling price
        return currentPrice.mul(110).div(100); // Example: increase by 10%
    }

    function getToken(uint256 _tokenId) public view returns (
        uint256 tokenId,
        uint256 sellingPrice,
        address owner,
        uint256 nextSellingPrice
    ) {
        tokenId = _tokenId;
        Token storage token = collectibleIdx[_tokenId];
        sellingPrice = token.price;
        if (sellingPrice == 0) {
            sellingPrice = getInitialPriceOfToken(_tokenId);
        }
        owner = token.owner;
        nextSellingPrice = getNextPrice(sellingPrice, _tokenId);
    }
}