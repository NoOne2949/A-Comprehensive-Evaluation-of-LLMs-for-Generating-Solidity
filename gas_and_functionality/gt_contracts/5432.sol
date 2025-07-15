// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint public minStandingBalance;

    constructor() Ownable(msg.sender) {
        minStandingBalance = 1; // Set to a non-zero, safe value
    }

    function setMinStandingBalance(uint balance) external onlyOwner {
        minStandingBalance = balance;
    }
}