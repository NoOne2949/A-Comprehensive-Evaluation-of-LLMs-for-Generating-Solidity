// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface RaidenToken {
    function balanceOf(address account) external view returns (uint256);
    function decimals() external view returns (uint8);
}

contract Auction is Ownable {
    using SafeMath for uint256;

    enum Stages { NotDeployed, AuctionDeployed, AuctionSetUp, AuctionEnded }
    Stages public stage = Stages.NotDeployed;

    RaidenToken public token;
    uint256 public num_tokens_auctioned;
    uint256 public token_multiplier;

    event Setup();

    modifier atStage(Stages expectedStage) {
        require(stage == expectedStage, "Auction: Invalid stage");
        _;
    }

    mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        stage = Stages.AuctionDeployed;
    }

    function setup(address _token_address) public onlyOwner atStage(Stages.AuctionDeployed) {
        require(_token_address != address(0), "Token address must be valid");
        token = RaidenToken(_token_address);
        num_tokens_auctioned = token.balanceOf(address(this));
        token_multiplier = 10 ** uint256(token.decimals());
        stage = Stages.AuctionSetUp;
        emit Setup();
    }
}