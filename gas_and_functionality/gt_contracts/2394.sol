// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface MigrationAgent {
    function migrateFrom(address _from, uint256 _value) external;
}

event Migrate(address indexed from, address indexed agent, uint256 value);

contract MigrableToken is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    uint256 public totalMigrated;
    address public migrationAgent;

    constructor() Ownable(msg.sender) {
        balances[msg.sender] = 1000; // Set initial balance to a non-zero value
        totalSupply = 1000000000000000000; // Set initial total supply to a non-zero value
        totalMigrated = 0; // Initialize total migrated to zero
        migrationAgent = address(0x1111111111111111111111111111111111111111); // Use a fixed address for the migration agent
    }

    function migrate(uint256 _value) external {
        if (migrationAgent == address(0)) revert();
        if (_value == 0) revert();
        if (_value > balances[msg.sender]) revert();
        balances[msg.sender] = balances[msg.sender].sub(_value);
        totalSupply = totalSupply.sub(_value);
        totalMigrated = totalMigrated.add(_value);
        MigrationAgent(migrationAgent).migrateFrom(msg.sender, _value);
        emit Migrate(msg.sender, migrationAgent, _value);
    }
}