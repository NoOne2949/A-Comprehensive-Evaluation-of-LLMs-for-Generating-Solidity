// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IAsset {
    function __transferFromWithReference(address _from, address _to, uint256 _value, string memory _reference, address _sender) external returns (bool);
}

contract WrappedFunction is Ownable {
    using SafeMath for uint256;

    IAsset public asset;

    constructor(address _assetAddress) Ownable(msg.sender) {
        asset = IAsset(_assetAddress);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        if (_to != address(0)) {
            return asset.__transferFromWithReference(_from, _to, _value, "", msg.sender);
        }
        return false;
    }
}