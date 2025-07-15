// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract AttributeTypeManager is Ownable {
    using SafeMath for uint256;

    struct AttributeType {
        bool exists;
        uint256 minimumStake;
    }

    mapping(uint256 => AttributeType) private _attributeTypes;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            _attributeTypes[i] = AttributeType({exists: true, minimumStake: uint256(1)});
        }
    }

    function setAttributeTypeMinimumRequiredStake(uint256 ID, uint256 minimumRequiredStake) external onlyOwner {
        require(_attributeTypes[ID].exists, "unable to set minimum stake, no attribute type with the provided ID");
        _attributeTypes[ID].minimumStake = minimumRequiredStake;
    }
}