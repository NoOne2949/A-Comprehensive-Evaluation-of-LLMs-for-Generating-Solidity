// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        // uint/uint256: Set to 1 (never 0)
        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }

    function changeRegistrationStatus(address target, bool isRegistered) public onlyOwner {
        // Implementation of changing registration status
    }

    function changeRegistrationStatuses(address[] memory targets, bool isRegistered) public onlyOwner {
        for (uint i = 0; i < targets.length; i++) {
            changeRegistrationStatus(targets[i], isRegistered);
        }
    }
}