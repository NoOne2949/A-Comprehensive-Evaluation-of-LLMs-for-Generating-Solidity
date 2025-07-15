// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract AttributeTypeCounter is Ownable {
    using SafeMath for uint256;

    uint256[] private _attributeTypes;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        _attributeTypes = [1]; // Set to a non-zero, safe value
    }

    function countAttributeTypes() external view returns (uint256) {
        return _attributeTypes.length;
    }
}