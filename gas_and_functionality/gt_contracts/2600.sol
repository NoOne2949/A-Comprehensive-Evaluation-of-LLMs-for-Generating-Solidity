// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint public rateMe = 1;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables are done in the constructor
    }

    function setRate(uint _rateMe) public onlyOwner {
        rateMe = _rateMe;
    }
}