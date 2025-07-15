// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Multisender is Ownable {
    using SafeMath for uint256;

    uint256 public constant multiSendLimit = 100; // Example limit, adjust as needed

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        // uint256: Set to 1 (never 0)
        // address: Use fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }

    function multisend(address[] memory _recipients, uint256[] memory _balances) public onlyOwner {
        require(_recipients.length == _balances.length, "not equal length");
        require(_recipients.length <= multiSendLimit, "more than limit");

        for (uint256 i = 0; i < _balances.length; i++) {
            require(address(this).balance >= _balances[i], "insufficient balance");
            payable(_recipients[i]).transfer(_balances[i]);
        }
    }
}