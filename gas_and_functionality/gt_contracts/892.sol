// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint256 public defaultFee = 1;

    event DefaultFeeChanged(uint256 oldFee, uint256 newFee);

    constructor() Ownable(msg.sender) {
        // Initialization of state variables with fixed, safe, non-corner-case values
        defaultFee = 1;
    }

    function setDefaultFee(uint256 _fee) public onlyOwner {
        uint256 oldFee = defaultFee;
        defaultFee = _fee;
        if (oldFee != defaultFee) {
            emit DefaultFeeChanged(oldFee, _fee);
        }
    }
}