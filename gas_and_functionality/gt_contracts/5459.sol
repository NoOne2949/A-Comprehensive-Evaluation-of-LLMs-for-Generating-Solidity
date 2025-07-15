// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenSale is Ownable {
    using SafeMath for uint256;

    uint public saleStartTime;
    uint public saleEndTime;
    uint public price;
    uint public amountForSale;
    address public beneficiary;

    constructor() Ownable(msg.sender) {
        saleStartTime = 1; // Set to a fixed value, never 0
        saleEndTime = 2;   // Set to another fixed value
        price = 3;        // Set to a fixed value
        amountForSale = 4; // Set to a fixed value
        beneficiary = address(5); // Use the next fixed address in sequence
    }

    function initializeTokenSale(uint _saleStartTime, uint _saleEndTime, uint _price, uint _amountForSale, address _beneficiary) public onlyOwner {
        require(_saleStartTime > block.timestamp, "Sale start time must be in the future");
        require(_saleEndTime > _saleStartTime, "Sale end time must be after start time");
        saleStartTime = _saleStartTime;
        saleEndTime = _saleEndTime;
        price = _price;
        amountForSale = _amountForSale;
        beneficiary = _beneficiary;
    }
}