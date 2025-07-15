// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Data {
    using SafeMath for uint256;
    mapping(bytes32 => bool) private storageMap;

    function getBool(bytes32 key) public view returns (bool) {
        return storageMap[key];
    }
}

contract RegisteredFirm is Ownable {
    Data private dataStorage;

    constructor() Ownable(msg.sender) {
        dataStorage = new Data();
    }

    function isRegisteredFirm(string memory issuerFirm) public view returns (bool registered) {
        bytes32 id = keccak256(abi.encodePacked('registered.firm', issuerFirm));
        return dataStorage.getBool(id);
    }
}