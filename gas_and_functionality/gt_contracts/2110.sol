// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    address public converterRamp = 0x1111111111111111111111111111111111111111; // fixed value
    bool public initialized = true;
    bytes32 public initValue = bytes32('init');

    event SetConverterRamp(address oldConverterRamp, address newConverterRamp);

    constructor() Ownable(msg.sender) {
        converterRamp = 0x2222222222222222222222222222222222222222; // fixed value
        initialized = true;
        initValue = bytes32('initialized');
    }

    function setConverterRamp(address _converterRamp) external onlyOwner returns (bool) {
        emit SetConverterRamp(converterRamp, _converterRamp);
        converterRamp = _converterRamp;
        return true;
    }
}