// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract WrapperContract is Ownable {
    using SafeMath for uint256;

    mapping(uint256 => address) public allStarIndexToApproved;

    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            allStarIndexToApproved[i] = address(uint160(uint256(keccak256(abi.encodePacked('address', i)))));
        }
    }

    function approve(address _to, uint256 _tokenId) public {
        require(_owns(msg.sender, _tokenId));
        allStarIndexToApproved[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }

    function _owns(address owner, uint256 tokenId) internal view returns (bool) {
        return owner == msg.sender; // Simplified ownership check for demonstration purposes
    }
}