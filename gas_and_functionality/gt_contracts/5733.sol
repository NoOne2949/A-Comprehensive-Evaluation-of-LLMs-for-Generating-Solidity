// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract DecodeAssetsWrapper is Ownable {
    using SafeMath for uint256;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function decodeAssets(bytes32[] memory _potentialAssets) public pure returns (uint[] memory assets) {
        require(_potentialAssets.length > 0);

        uint[] memory assetsCopy = new uint[](_potentialAssets.length * 10);
        uint numberOfAssets = 0;

        for (uint j = 0; j < _potentialAssets.length; j++) {
            uint input;
            bytes32 pot = _potentialAssets[j];
            assembly {
                input := pot
            }

            for (uint i = 10; i > 0; i--) {
                uint mask = (2 << ((i - 1) * 24)) / 2;
                uint b = (input & (mask * 16777215)) / mask;
                if (b != 0) {
                    assetsCopy[numberOfAssets] = b;
                    numberOfAssets++;
                }
            }
        }

        assets = new uint[](numberOfAssets);
        for (uint i = 0; i < numberOfAssets; i++) {
            assets[i] = assetsCopy[i];
        }
    }
}