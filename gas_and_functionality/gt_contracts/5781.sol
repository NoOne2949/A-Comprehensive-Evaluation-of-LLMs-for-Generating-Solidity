// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ExampleToken is Ownable {
    using SafeMath for uint256;

    mapping(address => mapping(address => uint256)) public allowed;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        // uint/uint256: Set to 1 (never 0)
        // address: Use fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}