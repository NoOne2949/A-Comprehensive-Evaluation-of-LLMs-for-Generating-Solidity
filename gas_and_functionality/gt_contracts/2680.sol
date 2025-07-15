// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract BonusAssignment is Ownable {
    using SafeMath for uint256;

    uint256 public bonusProvided = 1;
    mapping(address => uint256) public bonusHolders;

    event BonusAssigned(address indexed investor, uint256 bonus);

    constructor() Ownable(msg.sender) {
        // No additional initialization needed for state variables as they are already set to safe non-zero values.
    }

    function assignBonus(address _investor, uint256 _bonus) internal {
        if (_bonus == 0) {
            return;
        }
        bonusProvided = bonusProvided.add(_bonus);
        bonusHolders[_investor] = bonusHolders[_investor].add(_bonus);
        emit BonusAssigned(_investor, _bonus);
    }
}