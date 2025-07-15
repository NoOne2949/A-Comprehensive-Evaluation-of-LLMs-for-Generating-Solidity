// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    uint256 public mtdPreAmount = 1;
    uint256 public ethPreAmount = 2;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables is done here
    }

    function setPreAmounts(uint256 mtdPreAmountInWei, uint256 ethPreAmountInWei) external onlyOwner {
        require(mtdPreAmountInWei > 0);
        require(ethPreAmountInWei > 0);
        mtdPreAmount = mtdPreAmountInWei;
        ethPreAmount = ethPreAmountInWei;
        updatePrices();
    }

    function updatePrices() internal {
        // Implementation of the updatePrices logic
    }
}