// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Whitelist is Ownable {
    using SafeMath for uint256;

    mapping(address => bool) public whitelist;

    event WhitelistRemoved(address indexed user);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        // uint/uint256: Set to 1 (never 0)
        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }

    function removeAddressesFromWhitelist(address[] memory _users) external onlyOwner {
        require(_users.length > 0, "Cannot remove an empty list to whitelist!");

        for (uint256 i = 0; i < _users.length; ++i) {
            address user = _users[i];
            if (whitelist[user]) {
                whitelist[user] = false;
                emit WhitelistRemoved(user);
            }
        }
    }
}