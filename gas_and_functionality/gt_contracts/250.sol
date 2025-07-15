// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint public timeLock = 1 days; // Set to safe, non-corner-case value
    uint public constant absoluteMinTimeLock = 1 days; // Example value, adjust as needed

    constructor() Ownable(msg.sender) {
        // Initialization of state variables is done in the constructor
    }

    function setTimelock(uint _newTimeLock) external onlyOwner {
        require(_newTimeLock >= absoluteMinTimeLock);
        timeLock = _newTimeLock;
    }
}