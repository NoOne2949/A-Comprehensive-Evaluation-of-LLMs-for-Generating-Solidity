// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint256 public maxHolderPercentage;

    modifier onlyFactory() {
        require(msg.sender == factory, "Only the factory can call this function");
        _;
    }

    address private factory;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        maxHolderPercentage = 1;
        factory = address(0x111);
    }

    function configure(uint256 _maxHolderPercentage) public onlyFactory {
        maxHolderPercentage = _maxHolderPercentage;
    }
}