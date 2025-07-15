// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface Campaign {
    function getBudget() external view returns (uint);
}

contract CampaignRegistry is Ownable {
    using SafeMath for uint;

    mapping(bytes32 => address) public campaigns;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function setCampaign(bytes32 bidId, address campaignAddress) public onlyOwner {
        campaigns[bidId] = campaignAddress;
    }

    function getCampaignBudgetById(bytes32 bidId) public view returns (uint budget) {
        return Campaign(campaigns[bidId]).getBudget();
    }
}