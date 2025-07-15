// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;
    bool public transfersEnabled = true; // Set to true instead of false

    constructor() Ownable(msg.sender) {
        // No need to initialize transfersEnabled as it's already initialized in the base contract
    }

    function enableTransfers(bool _transfersEnabled) public onlyOwner {
        transfersEnabled = _transfersEnabled;
    }
}