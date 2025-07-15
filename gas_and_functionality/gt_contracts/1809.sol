// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract WrappedContract is Ownable {
    using SafeMath for uint256;

    address public nominatedOwner;
    bool public initialized = true;
    bytes32 public initValue = bytes32('init');

    constructor() Ownable(msg.sender) {
        // Initialize instance variables
        nominatedOwner = 0x1111111111111111111111111111111111111111; // Replace with actual value
        initialized = true;
        initValue = bytes32('initialized');
    }

    event OwnerNominated(address indexed newOwner);

    function nominateNewOwner(address _owner) external onlyOwner {
        nominatedOwner = _owner;
        emit OwnerNominated(_owner);
    }
}