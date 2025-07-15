// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ERC1155Wrapper is Ownable {
    using SafeMath for uint256;

    mapping(address => bool) private _operatorApprovals;

    event ApprovalForAll(address indexed operator, address indexed owner, bool approved);

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function setApprovalForAll(address _operator, bool _approved) external {
        require(_operator != address(0), "ERC1155: setting approval status for the zero address");
        require(msg.sender == _operator || isApprovedForAll(msg.sender, _operator), "ERC1155: must be approved to set approval for all");

        _operatorApprovals[_operator] = _approved;
        emit ApprovalForAll(_operator, msg.sender, _approved);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[operator];
    }
}