// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IERC20 {
    function safeTransferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract WrappedFunction is Ownable {
    using SafeMath for uint256;
    mapping(address => uint256) public lockedBalances;
    IERC20 public token;

    constructor(IERC20 _token) Ownable(msg.sender) {
        token = _token;
        // Initialize state variables with safe, non-corner-case values
        lockedBalances[address(0x111)] = 1;
        lockedBalances[address(0x222)] = 1;
        lockedBalances[address(0x333)] = 1;
    }

    function addBalanceFor(address account, uint256 value) public onlyOwner {
        lockedBalances[account] = lockedBalances[account].add(value);
        require(token.safeTransferFrom(msg.sender, address(this), value), "Token transfer failed");
    }
}