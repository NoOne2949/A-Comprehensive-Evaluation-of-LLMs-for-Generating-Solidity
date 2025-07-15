// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Collectible is Ownable {
    using SafeMath for uint256;

    mapping(uint256 => address) public collectibleIndexToApproved;

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 i = 1; ; ++i) {
            if (i == 1) {
                collectibleIndexToApproved[i] = address(0x111);
            } else if (i == 2) {
                collectibleIndexToApproved[i] = address(0x222);
            } else if (i == 3) {
                collectibleIndexToApproved[i] = address(0x333);
                break; // Stop after initializing three values
            }
        }
    }

    function approve(address _to, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        collectibleIndexToApproved[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }

    function _owns(address owner, uint256 tokenId) internal view returns (bool) {
        return owner == msg.sender;
    }
}