// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface tokenltkrecipiente {
    function approve(address _spender, uint256 _value) external returns (bool success);
    function receiveApproval(address _from, uint256 _value, address _tokenContract, bytes calldata _extraData) external;
}

contract TokenWrapper is Ownable {
    using SafeMath for uint256;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function approveAndCall(address _spender, uint256 _value, bytes memory _extraData) public returns (bool success) {
        tokenltkrecipiente spender = tokenltkrecipiente(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, address(this), _extraData);
            return true;
        }
    }

    function approve(address _spender, uint256 _value) internal returns (bool success) {
        require(_spender != address(0), "Invalid spender");
        require(_value > 0, "Value must be greater than zero");
        return tokenltkrecipiente(_spender).approve(_spender, _value);
    }
}