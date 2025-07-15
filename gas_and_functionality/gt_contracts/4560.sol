// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint256[] public forSalePixelconIndexes;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        forSalePixelconIndexes = [1, 2, 3]; // Fixed values as per the rules
    }

    function totalListings() public view returns (uint256) {
        return forSalePixelconIndexes.length;
    }
}