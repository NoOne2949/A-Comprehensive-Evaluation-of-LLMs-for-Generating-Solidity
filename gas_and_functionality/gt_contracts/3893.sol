// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface KyberReserveInterface {
    // Define the interface of the KyberReserve here if needed
}

contract KyberReserveWrapper is Ownable {
    using SafeMath for uint256;

    KyberReserveInterface[] public reserves;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function getReserves() public view returns (KyberReserveInterface[] memory) {
        return reserves;
    }
}