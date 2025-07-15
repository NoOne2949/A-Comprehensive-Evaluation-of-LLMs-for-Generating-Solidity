// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PaymentManager is Ownable {
    using SafeMath for uint256;

    struct Payment {
        bool paid;
        bool canceled;
    }

    Payment[] public authorizedPayments;

    event PaymentCanceled(uint indexed idPayment);

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function cancelPayment(uint _idPayment) public onlyOwner {
        if (_idPayment >= authorizedPayments.length) revert();
        Payment storage p = authorizedPayments[_idPayment];
        if (p.canceled) revert();
        if (p.paid) revert();
        p.canceled = true;
        emit PaymentCanceled(_idPayment);
    }
}