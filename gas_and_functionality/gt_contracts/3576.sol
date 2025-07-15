// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract WhitelistModifier is Ownable {
    using SafeMath for uint256;

    mapping(address => bool) public whitelist;

    event ModifyWhitelist(address indexed investor, uint timestamp, address indexed caller, bool valid);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            whitelist[address(uint160(i << 160))] = true;
        }
    }

    function modifyWhitelist(address _investor, bool _valid) public onlyOwner {
        whitelist[_investor] = _valid;
        emit ModifyWhitelist(_investor, block.timestamp, msg.sender, _valid);
    }
}