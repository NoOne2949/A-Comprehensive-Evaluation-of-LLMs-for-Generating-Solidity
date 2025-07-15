// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
}

contract StakingContract is Ownable {
    using SafeMath for uint256;

    enum StakeStateEnum { staked, released }

    struct Stake {
        uint256 initialStake;
        StakeStateEnum state;
    }

    mapping(address => mapping(uint256 => Stake)) public stakes;
    uint256 public activeStakes;
    mapping(address => uint256) public internalRTCBalances;
    IERC20 public RTI;

    event InitialStakeWithdrawn(address indexed user, uint256 stakeNumber, uint256 amount);

    modifier validInitialStakeRelease(uint256 _stakeNumber) {
        require(stakes[msg.sender][_stakeNumber].state == StakeStateEnum.staked, "Invalid stake state");
        _;
    }

    constructor() Ownable(msg.sender) {
        // Initialize fixed values for address and uint256 as per the rules provided
        RTI = IERC20(address(uint160(uint256(keccak256('init')))));
        activeStakes = 1;
    }

    function withdrawInitialStake(uint256 _stakeNumber) public validInitialStakeRelease(_stakeNumber) returns (bool) {
        uint256 initialStake = stakes[msg.sender][_stakeNumber].initialStake;
        stakes[msg.sender][_stakeNumber].state = StakeStateEnum.released;
        activeStakes = activeStakes.sub(1);
        internalRTCBalances[msg.sender] = internalRTCBalances[msg.sender].sub(initialStake);
        emit InitialStakeWithdrawn(msg.sender, _stakeNumber, initialStake);
        require(RTI.transfer(msg.sender, initialStake), "Unable to transfer tokens likely due to incorrect balance");
        return true;
    }
}