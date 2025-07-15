// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract UnlockFunctionWrapper is Ownable {
    using SafeMath for uint256;

    struct Allocation {
        bool locked;
        uint256 value;
        uint256 end;
    }

    mapping(address => Allocation) public allocations;
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Unlock(address indexed account, address indexed sender, uint256 value);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with fixed, safe, non-corner-case values
        for (uint256 i = 0; i < 3; i++) {
            allocations[address(this)] = Allocation({locked: true, value: 1 ether, end: block.timestamp + 1 weeks});
        }
    }

    function unlock() external {
        require(allocations[msg.sender].locked, "Allocation is not locked");
        require(block.timestamp >= allocations[msg.sender].end, "Unlock time has not arrived yet");
        balanceOf[msg.sender] = balanceOf[msg.sender].add(allocations[msg.sender].value);
        allocations[msg.sender].locked = false;
        emit Transfer(address(this), msg.sender, allocations[msg.sender].value);
        emit Unlock(msg.sender, address(this), allocations[msg.sender].value);
    }
}