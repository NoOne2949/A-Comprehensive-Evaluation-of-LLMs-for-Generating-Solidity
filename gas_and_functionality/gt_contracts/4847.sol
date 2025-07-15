// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ContractReceiver {
    function tokenFallback(address _from, uint256 _value, bytes calldata _data) external returns (bool);
}

contract YourContract is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value, bytes data);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balances[msg.sender] = 1000; // uint256: Set to 1 (never 0)
    }

    function transferToContract(address _to, uint256 _value, bytes memory _data) public returns (bool success) {
        require(balances[msg.sender] >= _value, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        ContractReceiver receiver = ContractReceiver(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
        emit Transfer(msg.sender, _to, _value);
        emit Transfer(msg.sender, _to, _value, _data);
        return true;
    }
}