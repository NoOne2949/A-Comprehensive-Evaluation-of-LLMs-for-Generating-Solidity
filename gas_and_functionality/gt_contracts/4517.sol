// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract OrderBook is Ownable {
    using SafeMath for uint256;

    struct Order {
        uint256 blockNumber;
    }

    mapping(uint256 => Order) public orders;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        orders[0] = Order({blockNumber: 1});
        orders[1] = Order({blockNumber: 2});
        orders[2] = Order({blockNumber: 3});
    }

    function orderBlockNumber(uint256 _orderID) external view returns (uint256) {
        return orders[_orderID].blockNumber;
    }
}