// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PriceSetter is Ownable {
    using SafeMath for uint256;

    uint256 public sellPrice;
    uint256 public buyPrice;

    constructor() Ownable(msg.sender) {
        sellPrice = 1; // Set to safe, non-corner-case value
        buyPrice = 2; // Set to safe, non-corner-case value
    }

    function setPrices(uint256 newSellPrice, uint256 newBuyPrice) external onlyOwner {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }
}