// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint256 public tokensPerEther;

    constructor() Ownable(msg.sender) {
        tokensPerEther = 1; // Set to safe, non-corner-case value
    }

    function setPrices(uint256 newRate) public onlyOwner {
        tokensPerEther = newRate;
    }
}