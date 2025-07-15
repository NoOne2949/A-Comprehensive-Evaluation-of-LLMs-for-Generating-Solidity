// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    function setFundingStartTime(uint _startTime) external onlyOwner {
        require(_startTime > block.timestamp, "Start time must be in the future");
        fundingStartTime = _startTime;
    }

    uint256 public fundingStartTime;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        fundingStartTime = 1;
    }
}