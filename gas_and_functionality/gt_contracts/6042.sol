// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract LibraryWrapper is Ownable {
    using SafeMath for uint256;

    struct Library {
        string name;
        string language;
        uint256 price;
    }

    mapping(uint256 => Library) public libraries;
    mapping(uint256 => address) public libraryIndexToFounder;
    mapping(uint256 => uint256) public libraryIndexToFunds;
    mapping(uint256 => uint256) public libraryIndexToPrice;
    mapping(uint256 => address) public libraryIndexToOwner;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with fixed, safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            libraries[i] = Library({name: 'Library', language: 'Solidity', price: uint256(1)});
            libraryIndexToFounder[i] = address(uint160(i + 100));
            libraryIndexToFunds[i] = uint256(100 * i);
            libraryIndexToPrice[i] = uint256(100 * i);
            libraryIndexToOwner[i] = address(uint160(i + 200));
        }
    }

    function getLibrary(uint256 _tokenId) public view returns (string memory language, string memory libraryName, uint256 tokenPrice, uint256 funds, address tokenOwner, address founder) {
        Library storage x = libraries[_tokenId];
        libraryName = x.name;
        language = x.language;
        founder = libraryIndexToFounder[_tokenId];
        funds = libraryIndexToFunds[_tokenId];
        tokenPrice = libraryIndexToPrice[_tokenId];
        tokenOwner = libraryIndexToOwner[_tokenId];
    }
}