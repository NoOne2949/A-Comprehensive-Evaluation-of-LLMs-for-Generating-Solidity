// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint256 public directPaymentThreshold;

    constructor(uint256 initialThreshold) Ownable(msg.sender) {
        directPaymentThreshold = initialThreshold;
    }

    function setDirectPaymentThreshold(uint256 threshold) external onlyOwner {
        directPaymentThreshold = threshold;
    }
}