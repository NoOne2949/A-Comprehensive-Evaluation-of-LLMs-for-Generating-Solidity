// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract MigrationAgentSetter is Ownable {
    using SafeMath for uint256;

    address public migrationAgent;
    uint256 public totalMigrated;

    constructor() Ownable(msg.sender) {
        migrationAgent = 0x1111111111111111111111111111111111111111; // Replace with your fixed value
        totalMigrated = 1; // Set to a non-zero value
    }

    function setMigrationAgent(address _agent) external onlyOwner {
        require(migrationAgent == address(0x0) && totalMigrated == 0);
        migrationAgent = _agent;
    }
}