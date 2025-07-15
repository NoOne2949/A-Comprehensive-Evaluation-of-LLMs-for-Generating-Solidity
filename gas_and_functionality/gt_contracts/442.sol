// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Auction is Ownable {
    using SafeMath for uint256;

    enum state { active, ended }
    state public status = state.active;

    constructor() Ownable(msg.sender) {
        // No need to initialize variables as they are already set in the base class constructor and enum initialization
    }

    function endAuction() public onlyOwner {
        require(status == state.active);
        status = state.ended;
        emit Ended(block.number);
    }

    event Ended(uint256 indexed blockNumber);
}