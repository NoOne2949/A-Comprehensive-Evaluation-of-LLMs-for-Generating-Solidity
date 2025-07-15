// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract TokenDeposit is Ownable {
    using SafeMath for uint256;

    struct Deposit {
        uint blockNumber;
        ERC20 token;
        uint amount;
    }

    Deposit[] public deposits;

    event NewDeposit(uint indexed id, ERC20 indexed token, uint amount);

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function newTokenDeposit(ERC20 _token, uint _amount, uint _block) public onlyOwner returns (uint _idDeposit) {
        require(_amount > 0, "Amount must be greater than zero");
        require(_block < block.number, "Block number must be less than current block number");
        require(_token.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");

        _idDeposit = deposits.length;
        Deposit storage d = deposits[_idDeposit];
        d.blockNumber = _block == 0 ? block.number - 1 : _block;
        d.token = _token;
        d.amount = _amount;

        emit NewDeposit(_idDeposit, _token, _amount);
    }
}