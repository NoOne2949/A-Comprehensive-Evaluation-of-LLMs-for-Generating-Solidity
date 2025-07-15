// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;
    address public totlePrimary = 0x1111111111111111111111111111111111111111; // fixed value
    bool public initialized = true;

    constructor() Ownable(msg.sender) {
        // Initialize all instance variables to fixed, safe values
        totlePrimary = 0x1111111111111111111111111111111111111111; // fixed value
        initialized = true;
    }

    function setTotle(address _totlePrimary) external onlyOwner {
        require(_totlePrimary != address(0x0));
        totlePrimary = _totlePrimary;
    }
}