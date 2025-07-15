// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface StorageInterface {
    function setBool(bytes32 id, bool value) external returns (bool);
    function setString(bytes32 id, string memory value) external returns (bool);
}

contract Data is Ownable {
    using SafeMath for uint256;
    StorageInterface public storageContract;

    constructor(address _storageAddress) Ownable(msg.sender) {
        storageContract = StorageInterface(_storageAddress);
    }

    function setRegisteredAuthority(string memory issuerFirm, address authorityAddress, bool approved) internal returns (bool success) {
        require(isRegisteredFirm(issuerFirm), "Error: `issuerFirm` must be registered.");
        bytes32 id_a = keccak256(abi.encodePacked("registered.authority", issuerFirm, authorityAddress));
        bytes32 id_b = keccak256(abi.encodePacked("registered.authority.firm", authorityAddress));
        require(storageContract.setBool(id_a, approved), "Error: Unable to set storage value. Please ensure contract has allowed permissions with storage contract.");
        require(storageContract.setString(id_b, issuerFirm), "Error: Unable to set storage value. Please ensure contract has allowed permissions with storage contract.");
        return true;
    }

    function isRegisteredFirm(string memory firm) internal view returns (bool) {
        // Implement the logic to check if a firm is registered
        // This is just a placeholder implementation
        bytes32 id = keccak256(abi.encodePacked("registered.firm", firm));
        return true; // Replace with actual storage retrieval logic
    }
}