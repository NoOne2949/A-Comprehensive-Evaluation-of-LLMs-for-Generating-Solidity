// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface LibStorage {
    function setBool(bytes32 id, bool value) external returns (bool);
}

interface TokenXInterface {
    function setAssetCurrency(address asset, string memory currency) external returns (bool);
}

contract TokenXWrapper is Ownable {
    using SafeMath for uint256;

    LibStorage public lib;
    TokenXInterface public tokenX;

    constructor(address _libAddress, address _tokenXAddress) Ownable(msg.sender) {
        lib = LibStorage(_libAddress);
        tokenX = TokenXInterface(_tokenXAddress);
    }

    function setTokenXCurrency(address asset, string memory currency) public onlyOwner returns (bool success) {
        bytes32 id = keccak256(abi.encodePacked('tokenx', asset, currency));
        require(lib.setBool(id, true), "Error: Unable to set storage value. Please ensure contract interface is allowed by the storage contract.");
        require(tokenX.setAssetCurrency(asset, currency), "Error: Failed to set asset currency.");
        return true;
    }
}