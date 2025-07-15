// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ExchangeRateSetter is Ownable {
    using SafeMath for uint256;

    uint256 public sellExchangeRate;
    uint256 public buyExchangeRate;

    constructor() Ownable(msg.sender) {
        sellExchangeRate = 1; // Set to a non-zero, safe value
        buyExchangeRate = 1; // Set to a non-zero, safe value
    }

    function setExchangeRate(uint256 _sellExchangeRate, uint256 _buyExchangeRate) public onlyOwner {
        sellExchangeRate = _sellExchangeRate;
        buyExchangeRate = _buyExchangeRate;
    }
}