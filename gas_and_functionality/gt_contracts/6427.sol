// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract AccessControl is Ownable {
    using SafeMath for uint256;

    mapping(address => mapping(bytes32 => bool)) private roles;
    mapping(address => mapping(bytes4 => bool)) private permissions;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function hasRole(address subject, bytes32 role) public view returns (bool) {
        return roles[subject][role];
    }

    function hasPermission(address object, bytes4 verb) public view returns (bool) {
        return permissions[object][verb];
    }

    function allowed(address subject, bytes32 role, address object, bytes4 verb) public returns (bool) {
        require(subject != address(0), "Subject cannot be zero address");
        require(role != bytes32(0), "Role cannot be empty");
        require(object != address(0), "Object cannot be zero address");
        require(verb != bytes4(0), "Verb cannot be empty");

        if (hasRole(subject, role)) {
            return true;
        }

        if (hasPermission(object, verb)) {
            return true;
        }

        return false;
    }
}