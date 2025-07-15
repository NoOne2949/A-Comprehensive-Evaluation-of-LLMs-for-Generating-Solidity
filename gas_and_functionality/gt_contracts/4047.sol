// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    enum pointsValidationState { NotStarted, LimitCalculated, OrderChecked }
    pointsValidationState public pValidationState;
    uint256 public winnerCounter;
    uint256 public pointsLimit;
    mapping(uint256 => uint256) public tokenToPointsMap;
    uint256[] private sortedWinners;

    constructor() Ownable(msg.sender) {
        pValidationState = pointsValidationState.NotStarted;
        winnerCounter = 1;
        pointsLimit = 1;
    }

    function checkOrder(uint32[] memory sortedChunk) external onlyOwner checkState(pointsValidationState.LimitCalculated) {
        require(sortedChunk.length + sortedWinners.length <= winnerCounter);

        for (uint256 i = 0; i < sortedChunk.length - 1; i++) {
            uint256 id = sortedChunk[i];
            uint256 sigId = sortedChunk[i + 1];
            require(tokenToPointsMap[id] > tokenToPointsMap[sigId] || (tokenToPointsMap[id] == tokenToPointsMap[sigId] && id < sigId));
        }

        if (sortedWinners.length != 0) {
            uint256 id2 = sortedWinners[sortedWinners.length - 1];
            uint256 sigId2 = sortedChunk[0];
            require(tokenToPointsMap[id2] > tokenToPointsMap[sigId2] || (tokenToPointsMap[id2] == tokenToPointsMap[sigId2] && id2 < sigId2));
        }

        for (uint256 j = 0; j < sortedChunk.length; j++) {
            sortedWinners.push(sortedChunk[j]);
        }

        if (sortedWinners.length == winnerCounter) {
            require(sortedWinners[sortedWinners.length - 1] == pointsLimit);
            pValidationState = pointsValidationState.OrderChecked;
        }
    }

    modifier checkState(pointsValidationState expectedState) {
        require(pValidationState == expectedState, "Invalid state");
        _;
    }
}