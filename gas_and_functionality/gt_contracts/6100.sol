// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract TokenVesting is Ownable {
    using SafeMath for uint256;

    struct Grant {
        uint256 yearsClaimed;
        uint256 totalClaimed;
    }

    mapping(address => Grant) public tokenGrants;
    IERC20 public token;

    event GrantTokensClaimed(address indexed recipient, uint256 amount);

    constructor(address _tokenAddress) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
    }

    function calculateGrantClaim(address _recipient) internal view returns (uint256 yearsVested, uint256 amountVested) {
        // Implementation of the calculation logic for calculating vested tokens
        // This is a placeholder and should be replaced with actual implementation
        yearsVested = 0; // Example value
        amountVested = 0; // Example value
    }

    function claimVestedTokens(address _recipient) external {
        uint256 yearsVested;
        uint256 amountVested;
        (yearsVested, amountVested) = calculateGrantClaim(_recipient);
        require(amountVested > 0, "amountVested is 0");
        Grant storage tokenGrant = tokenGrants[_recipient];
        tokenGrant.yearsClaimed = yearsVested;
        tokenGrant.totalClaimed = tokenGrant.totalClaimed.add(amountVested);
        require(token.transfer(_recipient, amountVested), "no tokens");
        emit GrantTokensClaimed(_recipient, amountVested);
    }
}