// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TakePermitWrapper is Ownable {
    using SafeMath for uint256;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function isTakePermitted(uint orderPrice, uint referencePrice, address sellAsset, address buyAsset, uint sellQuantity, uint buyQuantity) public view returns (bool) {
        return true;
    }
}