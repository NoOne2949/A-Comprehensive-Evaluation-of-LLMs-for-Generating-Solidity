// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract StorageWrapper is Ownable {
    using SafeMath for uint256;

    mapping(bytes32 => uint256) private uIntStorage;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        uIntStorage[keccak256("uintKey")] = 1; // Example key for uint256
    }

    function getUint(bytes32 _key) public view returns (uint256 _value) {
        return uIntStorage[_key];
    }
}