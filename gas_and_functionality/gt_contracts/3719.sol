// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    address public admin;

    event AdminOwnershipTransferred(address indexed previousAdmin, address indexed newAdmin);

    modifier validate_address(address addr) {
        require(addr != address(0), "Invalid address");
        _;
    }

    constructor() Ownable(msg.sender) {
        admin = msg.sender; // Use the deployer's address as the initial admin
    }

    function changeAdmin(address newAdmin) public validate_address(newAdmin) onlyOwner {
        if (admin == newAdmin) revert();
        emit AdminOwnershipTransferred(admin, newAdmin);
        admin = newAdmin;
    }
}