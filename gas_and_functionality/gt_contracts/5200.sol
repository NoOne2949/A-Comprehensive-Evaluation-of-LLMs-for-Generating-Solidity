// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}

contract ERC20Wrapper is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public balanceOf;
    event Transfer(address indexed from, address indexed to, uint256 value);

    uint256 public totalSupply;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function transferFrom(address _from, address _to, uint256 _value) public onlyOwner returns (bool success) {
        require(_from != address(0), "Invalid sender address");
        require(_to != address(0), "Invalid recipient address");
        require(_value > 0, "Invalid value");
        require(msg.sender == _from || msg.sender == _to, "Only the sender or recipient can call this function");

        uint256 fromBalance = balanceOf[_from];
        require(_value <= fromBalance, "Insufficient funds");
        balanceOf[_from] = fromBalance.sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);

        emit Transfer(_from, _to, _value);

        return true;
    }
}