// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenSale is Ownable {
    using SafeMath for uint256;

    uint256 public tokenSaleHardCap;
    address private authorizedAddress;

    constructor(uint256 initialTokenSaleHardCap) Ownable(msg.sender) {
        tokenSaleHardCap = initialTokenSaleHardCap;
        authorizedAddress = msg.sender;
    }

    modifier onlyAuthorized() {
        require(msg.sender == authorizedAddress, "Only authorized address can call this function");
        _;
    }

    function setTokenSaleHardCap(uint256 newTokenSaleHardCap) public onlyAuthorized {
        tokenSaleHardCap = newTokenSaleHardCap;
    }
}