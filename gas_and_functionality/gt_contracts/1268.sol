// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract PledgeManager is Ownable {
    using SafeMath for uint256;

    struct Pledge {
        uint256 amount;
        uint64 owner;
        uint64[] delegationChain;
        uint64 intendedProject;
        uint64 commitTime;
        uint64 oldPledge;
        PledgeState state;
    }

    enum PledgeState { Active, Canceled, Refunded }

    mapping(bytes32 => uint64) public hPledge2idx;
    Pledge[] public pledges;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function findOrCreatePledge(uint64 owner, uint64[] memory delegationChain, uint64 intendedProject, uint64 commitTime, uint64 oldPledge, PledgeState state) internal returns (uint64) {
        bytes32 hPledge = keccak256(abi.encodePacked(owner, delegationChain, intendedProject, commitTime, oldPledge, state));
        uint64 idx = hPledge2idx[hPledge];
        if (idx > 0) return idx;
        idx = uint64(pledges.length);
        hPledge2idx[hPledge] = idx;
        pledges.push(Pledge(0, owner, delegationChain, intendedProject, commitTime, oldPledge, state));
        return idx;
    }
}