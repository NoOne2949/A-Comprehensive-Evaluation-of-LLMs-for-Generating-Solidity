// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract VestingContract is Ownable {
    using SafeMath for uint256;

    struct Info {
        bool known;
        uint256 startTime;
        uint256 totalAmount;
        uint256 releaseTime;
    }

    mapping(address => Info) private _info;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function addBeneficiary(address beneficiary, uint256 startTime, uint256 releaseTime, uint256 amount) external onlyOwner {
        require(_info[beneficiary].known == false, "This address is already known to the contract.");
        require(releaseTime > startTime, "Release time must be later than the start time.");
        require(releaseTime > block.timestamp, "End of vesting period must be somewhere in the future.");

        Info storage info = _info[beneficiary];
        info.startTime = startTime;
        info.totalAmount = amount;
        info.releaseTime = releaseTime;
        info.known = true;
    }
}