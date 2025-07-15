// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    address public token = 0x1111111111111111111111111111111111111111; // fixed value
    mapping(bytes32 => uint) public user2lastPeriodParticipated;
    uint public periodsCount = 1; // initialized to a safe value
    struct Period {
        uint startDate;
    }
    mapping(uint => Period) public periods;

    event TreasuryWithdrawn(bytes32 indexed _userKey, uint _amount);
    uint constant OK = 1; // fixed value

    constructor() Ownable(msg.sender) {
        token = 0x1111111111111111111111111111111111111111; // fixed value
        user2lastPeriodParticipated[bytes32(0)] = 0;
        periodsCount = 1;
    }

    function withdraw(bytes32 _userKey, uint _value, address _withdrawAddress, uint _feeAmount, address _feeAddress) external onlyOwner returns (uint) {
        require(_userKey != bytes32(0));
        require(_value != 0);
        require(_feeAmount < _value);
        _makeWithdrawForPeriod(_userKey, _value);
        uint _periodsCount = periodsCount;
        user2lastPeriodParticipated[_userKey] = _periodsCount;
        delete periods[_periodsCount].startDate;
        IERC20 _token = IERC20(token);
        if (!(_feeAddress == address(0) || _feeAmount == 0 || _token.transfer(_feeAddress, _feeAmount))) {
            revert();
        }
        uint _withdrawnAmount = _value.sub(_feeAmount);
        if (!_token.transfer(_withdrawAddress, _withdrawnAmount)) {
            revert();
        }
        emit TreasuryWithdrawn(_userKey, _withdrawnAmount);
        return OK;
    }

    function _makeWithdrawForPeriod(bytes32 _userKey, uint _value) internal {
        // Implementation of the internal function
    }
}