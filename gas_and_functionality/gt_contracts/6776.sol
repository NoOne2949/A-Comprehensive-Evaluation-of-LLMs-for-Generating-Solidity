// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    address public requestBurnerContract;

    constructor(address _requestBurnerContract) Ownable(msg.sender) {
        requestBurnerContract = _requestBurnerContract;
    }

    function collectForREQBurning(uint256 _amount) internal {
        require(_amount > 0, "Amount must be greater than zero");
        (bool success, ) = requestBurnerContract.call{value: _amount}("");
        require(success, "Transfer failed");
    }
}