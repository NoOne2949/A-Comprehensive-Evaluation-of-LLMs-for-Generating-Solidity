// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract MyContract is Ownable {
    using SafeMath for uint256;

    bool public withdrawalEnabled = false;
    event WithdrawalEnabled(address indexed owner);

    modifier whenStopped() {
        require(!withdrawalEnabled, "Withdrawal is enabled");
        _;
    }

    modifier whenWithdrawalDisabled() {
        require(!withdrawalEnabled, "Withdrawal is already enabled");
        _;
    }

    constructor() Ownable(msg.sender) {
        withdrawalEnabled = false;
    }

    function enableWithdrawal() public onlyOwner whenStopped whenWithdrawalDisabled {
        withdrawalEnabled = true;
        emit WithdrawalEnabled(owner());
    }
}