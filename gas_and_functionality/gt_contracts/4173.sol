// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract WrapperContract is Ownable {
    using SafeMath for uint256;

    enum Error { NO_ERROR, SOME_ERROR }

    function calculateAccountValues(address userAddress) public view returns (uint, uint, uint) {
        (Error err, uint supplyValue, uint borrowValue) = calculateAccountValuesInternal(userAddress);
        if (err != Error.NO_ERROR) {
            return (uint(err), 0, 0);
        }
        return (0, supplyValue, borrowValue);
    }

    function calculateAccountValuesInternal(address userAddress) internal view returns (Error, uint, uint) {
        // Implement the logic of calculateAccountValuesInternal here
        // For demonstration purposes, let's assume it returns some values based on userAddress
        return (Error.NO_ERROR, 100, 50);
    }

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        // uint/uint256: Set to 1 (never 0)
        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }
}