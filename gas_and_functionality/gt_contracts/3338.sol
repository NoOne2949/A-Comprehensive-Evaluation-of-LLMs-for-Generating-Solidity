// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract AffiliateProgramWrapper is Ownable {
    using SafeMath for uint256;

    constructor() Ownable(msg.sender) {
        // No need to initialize other variables as they are already set correctly by the parent contract's constructor
    }

    function isAffiliateProgram() public pure returns (bool) {
        return true;
    }
}