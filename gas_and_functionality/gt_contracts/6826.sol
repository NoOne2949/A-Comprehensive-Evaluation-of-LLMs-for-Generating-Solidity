// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Wrapper is Ownable {
    using SafeMath for uint256;

    struct Data {
        uint closed;
    }

    Data private data;

    constructor() Ownable(msg.sender) {
        data.closed = 1; // Set to safe, non-corner-case value: 1
    }

    function closed() public view returns (uint) {
        return data.closed;
    }
}