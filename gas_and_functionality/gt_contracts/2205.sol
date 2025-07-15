// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ArbitratorContract is Ownable {
    using SafeMath for uint256;

    struct Question {
        bytes32 questionId;
        bytes32 answer;
        address answerer;
        bool answered;
    }

    mapping(bytes32 => Question) public questions;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function submitAnswerByArbitrator(bytes32 question_id, bytes32 answer, address answerer) external onlyOwner {
        require(!questions[question_id].answered, "Question already answered");
        questions[question_id] = Question({
            questionId: question_id,
            answer: answer,
            answerer: answerer,
            answered: true
        });
    }
}