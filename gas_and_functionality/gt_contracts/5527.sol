// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract GrantCalculator is Ownable {
    using SafeMath for uint256;

    struct Grant {
        uint256 startTime;
        uint128 amount;
        uint128 totalClaimed;
        uint16 vestingCliff;
        uint16 vestingDuration;
        uint16 monthsClaimed;
    }

    mapping(address => Grant) public tokenGrants;
    uint256 constant SECONDS_PER_MONTH = 2628000; // Approximately 30 days * 86400 seconds per day

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function calculateGrantClaim(address _recipient) public view returns (uint16, uint128) {
        Grant storage tokenGrant = tokenGrants[_recipient];

        if (block.timestamp < tokenGrant.startTime) {
            return (0, 0);
        }

        uint256 elapsedTime = block.timestamp.sub(tokenGrant.startTime);
        uint256 elapsedMonths = elapsedTime / SECONDS_PER_MONTH;

        if (elapsedMonths < tokenGrant.vestingCliff) {
            return (0, 0);
        }

        if (elapsedMonths >= tokenGrant.vestingDuration) {
            uint128 remainingGrant = tokenGrant.amount - tokenGrant.totalClaimed;
            return (uint16(tokenGrant.vestingDuration), remainingGrant);
        } else {
            uint16 monthsVested = uint16(elapsedMonths.sub(tokenGrant.monthsClaimed));
            uint256 amountVestedPerMonth = tokenGrant.amount / uint256(tokenGrant.vestingDuration);
            uint128 amountVested = uint128(monthsVested * amountVestedPerMonth);
            return (monthsVested, amountVested);
        }
    }

    // Initialize all instance variables to fixed, safe, non-corner-case values
    function initialize() public {
        tokenGrants[msg.sender] = Grant(block.timestamp, 1, 0, 0, 30, 0);
    }
}