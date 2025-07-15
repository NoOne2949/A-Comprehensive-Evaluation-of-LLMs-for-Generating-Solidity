// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ERC20Interface {
    function allowance(address owner, address spender) external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}

contract TokenSale is Ownable {
    using SafeMath for uint256;

    ERC20Interface public tokenContract;
    uint256 public sellFloor;
    uint256 public sellCeiling;

    struct TradeOrder {
        uint256 quantity;
        uint256 price;
        uint256 expiry;
    }

    mapping(address => TradeOrder) public orderBook;

    event TokensOffered(address indexed seller, uint256 quantity, uint256 price, uint256 expiry);

    mapping(address => uint256) public balanceOf;

 constructor(address _tokenContract, uint256 _sellFloor, uint256 _sellCeiling) Ownable(msg.sender) {
        tokenContract = ERC20Interface(_tokenContract);
        sellFloor = _sellFloor;
        sellCeiling = _sellCeiling;
    }

    function sell(uint256 quantity, uint256 price, uint256 expiry) public {
        require(quantity > 0, "You must supply a quantity.");
        require(price > 0, "The sale price cannot be zero.");
        require(expiry > block.timestamp, "Cannot have an expiry date in the past.");
        require(price >= sellFloor, "The ask is below the minimum allowed.");
        require(sellCeiling == 0 || price <= sellCeiling, "The ask is above the maximum allowed.");

        uint256 allowed = ERC20Interface(tokenContract).allowance(msg.sender, address(this));
        require(allowed >= quantity, "You must approve the transfer of tokens before offering them for sale.");

        uint256 balance = ERC20Interface(tokenContract).balanceOf(msg.sender);
        require(balance >= quantity, "Not enough tokens owned to complete the order.");

        orderBook[msg.sender] = TradeOrder(quantity, price, expiry);
        emit TokensOffered(msg.sender, quantity, price, expiry);
    }
}