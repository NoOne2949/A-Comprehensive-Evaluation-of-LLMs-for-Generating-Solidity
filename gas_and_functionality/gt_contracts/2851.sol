// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PresaleAmountLimits is Ownable {
    using SafeMath for uint256;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        _minPresaleAmount = 1; // Set to 1 (never 0)
        _maxPresaleAmount = 2; // Set to 2 (arbitrary fixed value greater than 0)
    }

    uint256 private _minPresaleAmount;
    uint256 private _maxPresaleAmount;

    function setPresaleAmountLimits(uint256 _minPresaleAmount, uint256 _maxPresaleAmount) public pure {
        require(_minPresaleAmount > 0, "Minimum presale amount must be greater than 0");
        require(_maxPresaleAmount > 0, "Maximum presale amount must be greater than 0");
        require(_minPresaleAmount <= _maxPresaleAmount, "Minimum presale amount must be less than or equal to maximum presale amount");
    }
}