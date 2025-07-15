// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Clawback is Ownable {
    using SafeMath for uint256;

    uint256 public constant PRESALE_MINIMUM_FUNDING = 10 ether; // Example value, adjust as needed
    uint256 public constant OWNER_CLAWBACK_DATE = 1700889600; // Example value, adjust as needed
    uint256 public totalFunding;

    constructor() Ownable(msg.sender) {
        totalFunding = 1; // Initialize to a safe non-corner-case value
    }

    function ownerClawback() external onlyOwner {
        require(totalFunding < PRESALE_MINIMUM_FUNDING);
        require(block.timestamp >= OWNER_CLAWBACK_DATE);
        payable(owner()).transfer(address(this).balance);
    }
}