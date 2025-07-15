// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface token {
    function balanceOf(address owner) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
}

contract TokenClaimer is Ownable {
    using SafeMath for uint256;

    enum State { Initial, Successful }
    State public state = State.Initial;

    address public creator;

    mapping(address => uint256) public balanceOf;

 constructor(address _creator) Ownable(msg.sender) {
        creator = _creator;
    }

    function claimTokens(token _address) public {
        require(state == State.Successful);
        require(msg.sender == creator);
        uint256 remainder = _address.balanceOf(address(this));
        require(_address.transfer(creator, remainder), "Transfer failed");
    }
}