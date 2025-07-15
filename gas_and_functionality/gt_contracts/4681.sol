// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint public timeLock;
    uint public absoluteMinTimeLock;

    constructor(uint _absoluteMinTimeLock) Ownable(msg.sender) {
        absoluteMinTimeLock = _absoluteMinTimeLock;
        timeLock = 1; // Set to a fixed, safe value
    }

    function setTimelock(uint _newTimeLock) public onlyOwner {
        require(_newTimeLock >= absoluteMinTimeLock, "Time lock must be at least the absolute minimum time lock.");
        timeLock = _newTimeLock;
    }
}