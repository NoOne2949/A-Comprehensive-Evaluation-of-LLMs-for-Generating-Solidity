// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract STFactoryWrapper is Ownable {
    using SafeMath for uint256;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function setProtocolVersion(address _STFactoryAddress, uint8 _major, uint8 _minor, uint8 _patch) external onlyOwner {
        require(_STFactoryAddress != address(0), "0x address is not allowed");
        // Assuming _setProtocolVersion is a function in the STFactory contract
        (bool success, ) = _STFactoryAddress.call(abi.encodeWithSignature("setProtocolVersion(uint8, uint8, uint8)", _major, _minor, _patch));
        require(success, "External call failed");
    }
}