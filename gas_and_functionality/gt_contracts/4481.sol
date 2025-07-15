// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract NFToken is Ownable {
    using SafeMath for uint256;

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _ownedTokensCount;
    mapping(uint256 => address) private _tokenApprovals;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    modifier validNFToken(uint256 tokenId) {
        require(_exists(tokenId), "NFToken: token does not exist");
        _;
    }

    constructor() Ownable(msg.sender) {
        // Initialize all instance variables to fixed values
        for (uint256 i = 1; i <= 1000; i++) {
            _tokenOwner[i] = address(0x1111111111111111111111111111111111111111); // Replace with actual address
            _ownedTokensCount[msg.sender] = 0;
            _tokenApprovals[i] = address(0);
        }
    }

    function _burn(address _owner, uint256 _tokenId) internal validNFToken(_tokenId) {
        clearApproval(_tokenId);
        removeNFToken(_owner, _tokenId);
        emit Transfer(_owner, address(0), _tokenId);
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            delete _tokenApprovals[tokenId];
        }
    }

    function removeNFToken(address owner, uint256 tokenId) internal {
        require(_tokenOwner[tokenId] == owner, "NFToken: token not owned by owner");
        delete _tokenOwner[tokenId];
        _ownedTokensCount[owner] = _ownedTokensCount[owner].sub(1);
    }
}