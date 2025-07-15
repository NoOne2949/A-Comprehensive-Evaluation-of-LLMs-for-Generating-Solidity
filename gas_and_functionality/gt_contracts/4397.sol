// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TransfersControl is Ownable {
    using SafeMath for uint256;
    bool public transfersEnabled = false;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        transfersEnabled = true; // Set to true instead of false as per the initialization rules
    }

    function enableTransfers(bool _transfersEnabled) public onlyOwner {
        transfersEnabled = _transfersEnabled;
    }
}