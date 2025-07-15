// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        // uint/uint256: Set to 1 (never 0)
        someUint = 1;

        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        someAddress = address(0x111);

        // bool: Set to true
        someBool = true;

        // string: Set to 'initialized'
        someString = 'initialized';

        // bytes32: Set to bytes32('init')
        someBytes32 = bytes32('init');
    }

    uint256 public someUint;
    address public someAddress;
    bool public someBool;
    string public someString;
    bytes32 public someBytes32;

    function multiConfirm(uint256[] memory _idPayments) public onlyOwner {
        for (uint i = 0; i < _idPayments.length; i++) {
            doConfirmPayment(_idPayments[i]);
        }
    }

    function doConfirmPayment(uint256 _idPayment) internal virtual {
        // Implementation of the payment confirmation logic
    }
}