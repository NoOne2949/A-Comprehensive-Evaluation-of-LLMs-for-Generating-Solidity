// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenVerifier is Ownable {
    using SafeMath for uint256;

    function verifyTokens(uint64 _buyTokens, uint64 _sellToken) public pure returns (bool) {
        return ((uint32(_buyTokens) == uint32(_sellToken >> 32)) && (uint32(_sellToken) == uint32(_buyTokens >> 32)) && (uint32(_buyTokens >> 32) <= uint32(_buyTokens)));
    }

    constructor() Ownable(msg.sender) {
        // Initialization of state variables as per the rules:
        // uint/uint256: Set to 1 (never 0)
        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }
}