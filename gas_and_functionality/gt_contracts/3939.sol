// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    address public registryAdmin = 0x1111111111111111111111111111111111111111; // fixed value
    bool public initialized = true;
    bytes32 public initValue = bytes32('init');

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function setRegistryAdmin(address _newRegistryAdmin) public onlyOwner {
        address _oldRegistryAdmin = registryAdmin;
        registryAdmin = _newRegistryAdmin;
    }
}