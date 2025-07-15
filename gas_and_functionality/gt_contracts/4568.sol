// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IToken {
    function transfersEnabled() external view returns (bool);
    function doTransfer(address sender, address recipient, uint256 amount) external returns (bool);
}

contract TokenWrapper is Ownable {
    using SafeMath for uint256;

    IToken public token;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        require(_tokenAddress != address(0), "Invalid token address");
        token = IToken(_tokenAddress);
    }

    function transfer(address _to, uint256 _amount) external returns (bool success) {
        require(token.transfersEnabled(), "Transfers are disabled");
        require(_to != address(0), "Invalid recipient address");
        require(_amount > 0, "Amount must be greater than zero");
        return token.doTransfer(msg.sender, _to, _amount);
    }
}