// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    enum CampaignState { Initial, Active, Paused }
    CampaignState public campaignState;
    bool public paused;

    event CampaignPaused(uint timestamp);

    address public controller;

    modifier onlyController() {
        require(msg.sender == controller, "Only controller can call this function");
        _;
    }

    constructor() Ownable(msg.sender) {
        campaignState = CampaignState.Active;
        paused = false;
        controller = msg.sender;
    }

    function pauseSale() public onlyController {
        require(campaignState == CampaignState.Active, "Campaign must be active to pause");
        paused = true;
        campaignState = CampaignState.Paused;
        emit CampaignPaused(block.timestamp);
    }
}