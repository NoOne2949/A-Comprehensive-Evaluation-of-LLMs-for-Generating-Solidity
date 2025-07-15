// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TransferCheckWrapper is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;
    bool public tokenTransfersFrozen;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balances[msg.sender] = 1000; // Set initial balance to 1 for the owner
        tokenTransfersFrozen = false; // Default to not frozen
    }

    function transferCheck(address _sender, address _receiver, uint256 _amount) external view returns (bool success) {
        require(!tokenTransfersFrozen, "Token transfers are frozen");
        require(_amount > 0, "Amount must be greater than zero");
        require(_receiver != address(0), "Receiver address cannot be the zero address");
        require(balances[_sender] >= _amount, "Insufficient balance");
        require(balances[_receiver] + _amount > balances[_receiver], "Transfer amount exceeds available balance");
        return true;
    }
}