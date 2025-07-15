// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContractName is Ownable {
    using SafeMath for uint256;
    bytes32 public constant INIT = bytes32('init');

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function addAmountBoughtAsMember(address _member, uint256 _amountBought) external onlyOwner {
        // Add the logic to update the member's amount bought here.
        // For example:
        // members[_member] = members[_member].add(_amountBought);
    }
}