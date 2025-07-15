// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenWrapper is Ownable {
    using SafeMath for uint256;

    mapping(uint256 => address) private tokenOwnerMap;
    mapping(address => bool) public approvedContractAddresses;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return tokenOwnerMap[_tokenId];
    }

    function isSenderApprovedFor(uint256 _tokenId) public view returns (bool) {
        return approvedContractAddresses[msg.sender] && tokenOwnerMap[_tokenId] == tx.origin;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(_from == ownerOf(_tokenId), "wrong owner");
        require(isSenderApprovedFor(_tokenId) || (approvedContractAddresses[msg.sender] && tokenOwnerMap[_tokenId] == tx.origin), "not an approved sender");
        _clearApprovalAndTransfer(ownerOf(_tokenId), _to, _tokenId);
    }

    function _clearApprovalAndTransfer(address from, address to, uint256 tokenId) internal {
        require(from != address(0));
        require(to != address(0));
        require(ownerOf(tokenId) == from);

        // Clear existing approval
        delete tokenOwnerMap[tokenId];

        // Transfer ownership
        tokenOwnerMap[tokenId] = to;
    }
}