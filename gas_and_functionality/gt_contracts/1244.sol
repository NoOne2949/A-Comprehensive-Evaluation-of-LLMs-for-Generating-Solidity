// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract GreyWrapper is Ownable {
    using SafeMath for uint256;

    struct Grey {
        string name;
    }

    mapping(uint256 => Grey) private greys;
    mapping(uint256 => uint256) public greyIndexToPrice;
    mapping(uint256 => address) public greyIndexToOwner;
    mapping(uint256 => uint256) public greyIndexToPreviousPrice;
    mapping(uint256 => address[5]) public greyIndexToPreviousOwners;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with fixed, safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            greys[i] = Grey({name: 'initialized'});
            greyIndexToPrice[i] = 1;
            greyIndexToOwner[i] = address(uint160(i) << 160);
            greyIndexToPreviousPrice[i] = 1;
            for (uint256 j = 0; j < 5; j++) {
                if (j == 0) {
                    greyIndexToPreviousOwners[i][j] = address(uint160(i + j) << 160);
                } else {
                    greyIndexToPreviousOwners[i][j] = address(0);
                }
            }
        }
    }

    function getGrey(uint256 _tokenId) public view returns (string memory, uint256, address, uint256, address[5] memory) {
        Grey storage grey = greys[_tokenId];
        return (grey.name, greyIndexToPrice[_tokenId], greyIndexToOwner[_tokenId], greyIndexToPreviousPrice[_tokenId], greyIndexToPreviousOwners[_tokenId]);
    }
}