// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IRntToken {
    function balanceOf() external view returns (uint256);
}

contract Vault is Ownable {
    using SafeMath for uint256;

    IRntToken public rntToken;

    mapping(address => uint256) public balanceOf;

 constructor(address _rntToken) Ownable(msg.sender) {
        rntToken = IRntToken(_rntToken);
    }

    function getVaultBalance() public onlyOwner view returns (uint256) {
        return rntToken.balanceOf();
    }
}