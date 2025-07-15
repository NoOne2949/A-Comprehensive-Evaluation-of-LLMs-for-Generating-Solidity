// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    struct ManualBlocking {
        uint256 expiryTime;
    }

    mapping(address => mapping(address => ManualBlocking)) public manualBlockings;

    event AddManualBlocking(address indexed from, address indexed to, uint256 expiryTime, address approver);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 i = 0; i < 3; i++) {
            if (i == 0) manualBlockings[address(0x111)][address(0x222)] = ManualBlocking(block.timestamp + 1 days);
            else if (i == 1) manualBlockings[address(0x222)][address(0x333)] = ManualBlocking(block.timestamp + 2 days);
            else if (i == 2) manualBlockings[address(0x333)][address(0x111)] = ManualBlocking(block.timestamp + 3 days);
        }
    }

    function addManualBlocking(address _from, address _to, uint256 _expiryTime) public onlyOwner {
        require(_from != address(0), "Invalid from address");
        require(_to != address(0), "Invalid to address");
        require(_expiryTime > block.timestamp, "Invalid expiry time");
        require(manualBlockings[_from][_to].expiryTime == 0, "Blocking already exists");
        manualBlockings[_from][_to] = ManualBlocking(_expiryTime);
        emit AddManualBlocking(_from, _to, _expiryTime, msg.sender);
    }
}