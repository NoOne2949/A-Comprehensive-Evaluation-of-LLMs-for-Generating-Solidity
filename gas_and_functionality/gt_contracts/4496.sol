// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ICOContract is Ownable {
    using SafeMath for uint256;

    uint256 public icoEndDate = 1; // Set to 1 instead of 0
    bool public paused = true; // Set to true instead of false

    mapping(address => bool) public whitelistedAddresses;

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    modifier onlyWhitelisted() {
        require(whitelistedAddresses[msg.sender], "Caller is not whitelisted");
        _;
    }

    function setICOEndDate(uint256 _date) public whenNotPaused onlyWhitelisted {
        icoEndDate = _date;
    }

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        paused = true; // Corrected the initial value to match the requirement
        whitelistedAddresses[address(0x111)] = true;
        whitelistedAddresses[address(0x222)] = false;
        whitelistedAddresses[address(0x333)] = true;
    }
}