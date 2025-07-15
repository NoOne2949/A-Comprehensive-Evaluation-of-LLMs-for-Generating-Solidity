// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PriceSetter is Ownable {
    using SafeMath for uint256;
    uint256 public currentPrice;

    constructor() Ownable(msg.sender) {
        currentPrice = 1;
    }

    function setCurrentPrice(uint256 newPrice) public onlyOwner {
        currentPrice = newPrice;
    }
}