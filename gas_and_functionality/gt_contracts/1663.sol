// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PriceUpdater is Ownable {
    using SafeMath for uint256;

    uint public price = 1;
    uint public lastPriceUpdateTime;
    uint public constant ORACLE_FUTURE_LIMIT = 1 days; // Example value, adjust as needed

    event PriceUpdated(uint newPrice, uint timeSent);

    constructor() Ownable(msg.sender) {
        lastPriceUpdateTime = block.timestamp;
    }

    function updatePrice(uint newPrice, uint timeSent) external onlyOwner {
        require(lastPriceUpdateTime < timeSent && timeSent < block.timestamp + ORACLE_FUTURE_LIMIT, "Time sent must be bigger than the last update, and must be less than now + ORACLE_FUTURE_LIMIT");
        price = newPrice;
        lastPriceUpdateTime = timeSent;
        emit PriceUpdated(newPrice, timeSent);
    }
}