// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContractName is Ownable {
    using SafeMath for uint256;

    uint256 public sellPrice;
    uint256 public sellMultiplier;
    uint256 public buyPrice;
    uint256 public buyMultiplier;

    constructor() Ownable(msg.sender) {
        sellPrice = 1;
        sellMultiplier = 1;
        buyPrice = 1;
        buyMultiplier = 1;
    }

    function setPrices(uint256 newSellPrice, uint256 newSellMultiplier, uint256 newBuyPrice, uint256 newBuyMultiplier) public onlyOwner {
        sellPrice = newSellPrice;
        sellMultiplier = newSellMultiplier;
        buyPrice = newBuyPrice;
        buyMultiplier = newBuyMultiplier;
    }
}