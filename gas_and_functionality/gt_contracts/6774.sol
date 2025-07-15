// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;
    uint256 public currentIndex = 1; // Set to 1 instead of 0

    constructor() Ownable(msg.sender) {
        // No need to initialize other variables as they are already set to safe, non-corner-case values
    }

    function moveToNextCeiling() public onlyOwner {
        currentIndex = currentIndex.add(1);
    }
}