// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract MTDContract is Ownable {
    using SafeMath for uint256;

    uint256 public mtdAmount;

    constructor() Ownable(msg.sender) {
        mtdAmount = 1; // Set to a non-zero, safe value
    }

    function setMtdAmount(uint256 mtdAmountInWei) public onlyOwner {
        require(mtdAmountInWei > 0, "MTD amount must be greater than zero");
        require(mtdAmount != mtdAmountInWei, "MTD amount has not changed");
        mtdAmount = mtdAmountInWei;
        updatePrices();
    }

    function updatePrices() internal {
        // Implementation of the updatePrices function
    }
}