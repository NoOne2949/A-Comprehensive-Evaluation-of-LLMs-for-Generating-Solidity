// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
}

struct TokenTimeLockVault {
    uint releaseTime;
    uint amount;
    uint arrayIndex;
}

event UnlockEvent(address indexed beneficiary);

contract YourContract is Ownable {
    using SafeMath for uint256;

    IERC20 public token;
    address[] public lockIndexes;
    mapping(address => TokenTimeLockVault) public tokenLocks;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        token = IERC20(_tokenAddress);
    }

    function releaseAll(uint from, uint to) external onlyOwner returns (bool) {
        require(from >= 0);
        require(to <= lockIndexes.length);
        for (uint i = from; i < to; i++) {
            address beneficiary = lockIndexes[i];
            if (beneficiary == address(0)) {
                continue;
            }
            TokenTimeLockVault memory lock = tokenLocks[beneficiary];
            if (!(block.timestamp >= lock.releaseTime && lock.amount > 0)) {
                continue;
            }
            delete tokenLocks[beneficiary];
            lockIndexes[lock.arrayIndex] = address(0);
            emit UnlockEvent(beneficiary);
            require(token.transfer(beneficiary, lock.amount));
        }
        return true;
    }
}