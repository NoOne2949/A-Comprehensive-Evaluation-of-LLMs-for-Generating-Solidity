// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface RealityCheck {
    function submitAnswerByArbitrator(bytes32 question_id, bytes32 answer, address answerer) external;
}

contract ArbitrationWrapper is Ownable {
    using SafeMath for uint256;

    mapping(bytes32 => bool) public arbitration_bounties;
    RealityCheck public realitycheck;

    constructor(address _realityCheckAddress) Ownable(msg.sender) {
        realitycheck = RealityCheck(_realityCheckAddress);
        // Initialize state variables with safe, non-corner-case values
        arbitration_bounties[bytes32('init')] = true;
    }

    function submitAnswerByArbitrator(bytes32 question_id, bytes32 answer, address answerer) public onlyOwner {
        delete arbitration_bounties[question_id];
        realitycheck.submitAnswerByArbitrator(question_id, answer, answerer);
    }
}