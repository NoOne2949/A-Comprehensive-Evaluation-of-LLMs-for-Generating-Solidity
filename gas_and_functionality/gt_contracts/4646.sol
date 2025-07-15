// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface DarknodeRegistryInterface {
    function darknodeBond(address darknodeID) external view returns (uint256);
}

contract DarknodeWrapper is Ownable {
    using SafeMath for uint256;

    mapping(address => address) public darknodeRegistries;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function darknodeBond(address darknodeID, address darknodeRegistryAddress) external view returns (uint256) {
        require(darknodeRegistries[darknodeRegistryAddress] != address(0), "Darknode registry not set");
        DarknodeRegistryInterface darknodeRegistry = DarknodeRegistryInterface(darknodeRegistryAddress);
        return darknodeRegistry.darknodeBond(darknodeID);
    }
}