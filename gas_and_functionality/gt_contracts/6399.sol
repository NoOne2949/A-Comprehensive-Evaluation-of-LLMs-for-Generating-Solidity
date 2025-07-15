// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ManagerChange is Ownable {
    using SafeMath for uint256;

    mapping(address => address) public managers;

    event ManagerChanged(address indexed addr, address indexed newManager);

    modifier canManage(address addr) {
        require(managers[addr] == msg.sender, "Only the current manager can change the manager.");
        _;
    }

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        managers[address(0x111)] = address(0);
        managers[address(0x222)] = address(0);
        managers[address(0x333)] = address(0);
    }

    function changeManager(address addr, address newManager) public canManage(addr) {
        managers[addr] = newManager;
        emit ManagerChanged(addr, newManager);
    }
}