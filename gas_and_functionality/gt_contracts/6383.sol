// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract AssetPackApproval is Ownable {
    using SafeMath for uint256;

    struct AssetPack {
        address creator;
    }

    mapping(uint => AssetPack) public assetPacks;
    mapping(uint => address) public approvedTakeover;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint i = 1; i <= 3; i++) {
            assetPacks[i] = AssetPack({creator: address(uint160(uint256(keccak256(abi.encodePacked("creator", i)))))});
        }
        for (uint j = 1; j <= 3; j++) {
            approvedTakeover[j] = address(uint160(uint256(keccak256(abi.encodePacked("approved", j)))));
        }
    }

    function approveTakeover(uint _assetPackId, address _newCreator) public {
        require(assetPacks[_assetPackId].creator == msg.sender);
        approvedTakeover[_assetPackId] = _newCreator;
    }
}