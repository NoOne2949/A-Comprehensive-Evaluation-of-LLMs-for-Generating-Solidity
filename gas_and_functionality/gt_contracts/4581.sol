// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    address public beneficiary;
    bool public initialized = true;
    bytes32 public initValue = bytes32('init');

    constructor() Ownable(msg.sender) {
        beneficiary = 0x1111111111111111111111111111111111111111; // Replace with actual address
        initialized = true;
        initValue = bytes32('initialized');
    }

    function setBeneficiary(address newBeneficiary) external onlyOwner {
        beneficiary = newBeneficiary;
    }
}