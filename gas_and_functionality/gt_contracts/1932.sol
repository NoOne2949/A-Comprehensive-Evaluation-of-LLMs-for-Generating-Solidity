// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract StakingContract is Ownable {
    using SafeMath for uint256;

    struct Member {
        uint256 startOfLoyaltyRewardEligibility;
        uint256 stakeBalance;
        uint256 previouslyAppliedLoyaltyBalance;
    }

    mapping(address => Member) public members;
    uint256 public loyaltyPeriodDays;
    uint256 public loyaltyRewardAmount;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        loyaltyPeriodDays = 30 days; // Example value for a month
        loyaltyRewardAmount = 10; // 10% of stake balance as reward
    }

    function getLoyaltyRewardBalance(address memberAddress) public view returns (uint256 loyaltyReward) {
        require(members[memberAddress].startOfLoyaltyRewardEligibility != 0, "Member not eligible for loyalty rewards");
        uint256 loyaltyPeriodSeconds = loyaltyPeriodDays * 1 days;
        Member storage thisMember = members[memberAddress];
        uint256 elapsedTimeSinceEligible = block.timestamp - thisMember.startOfLoyaltyRewardEligibility;
        loyaltyReward = thisMember.previouslyAppliedLoyaltyBalance;
        if (elapsedTimeSinceEligible >= loyaltyPeriodSeconds) {
            uint256 numWholePeriods = elapsedTimeSinceEligible / loyaltyPeriodSeconds;
            uint256 rewardForEachPeriod = thisMember.stakeBalance * loyaltyRewardAmount / 100;
            loyaltyReward += rewardForEachPeriod * numWholePeriods;
        }
    }
}