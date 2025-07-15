// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface TokenController {
    function onApprove(address _owner, address _spender, uint256 _amount) external returns (bool);
}

contract ERC20Token is Ownable {
    using SafeMath for uint256;

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    bool public transfersEnabled;
    address public controller;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) Ownable(msg.sender) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply.mul(10 ** uint256(decimals));
        balances[msg.sender] = totalSupply;
        transfersEnabled = true;
    }

    function approve(address _spender, uint256 _amount) public returns (bool success) {
        require(transfersEnabled, "Transfers are not enabled");
        require((_amount == 0) || (allowed[msg.sender][_spender] == 0), "Allowance already granted");
        if (isContract(_spender)) {
            bool onApprove = TokenController(controller).onApprove(msg.sender, _spender, _amount);
            require(onApprove, "Approval rejected by controller");
        }
        allowed[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }

    function isContract(address addr) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }
}