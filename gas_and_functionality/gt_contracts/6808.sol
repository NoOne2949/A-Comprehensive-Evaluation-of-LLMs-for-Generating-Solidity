// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PriceSetter is Ownable {
    using SafeMath for uint256;

    uint256 public buyPrice;
    uint256 public sellPrice;

    constructor() Ownable(msg.sender) {
        buyPrice = 1; // Set to safe, non-corner-case value
        sellPrice = 2; // Set to safe, non-corner-case value
    }

    function setPrices(uint256 newBuyPrice, uint256 newSellPrice) public onlyOwner {
        buyPrice = newBuyPrice;
        sellPrice = newSellPrice;
    }
}