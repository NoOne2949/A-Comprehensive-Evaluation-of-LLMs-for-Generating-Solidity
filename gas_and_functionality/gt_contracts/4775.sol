// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenSale is Ownable {
    using SafeMath for uint256;

    uint256 public totalTokensSold = 0; // Set to 0 instead of 1
    uint256 public cap = 1000; // Example value, adjust as needed

    constructor() Ownable(msg.sender) {
        // Initialization done in the constructor
    }

    function capReached() public view returns (bool) {
        return totalTokensSold >= cap;
    }
}