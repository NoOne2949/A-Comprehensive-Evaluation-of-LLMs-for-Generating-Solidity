// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    // Define membersArray as a state variable
    address[] public membersArray;

    constructor() Ownable(msg.sender) {
        membersArray = new address[](1);
        membersArray[0] = 0x1111111111111111111111111111111111111111; // Replace with actual address
    }

    function getMembersArrayLength() public view returns (uint256) {
        return membersArray.length;
    }
}