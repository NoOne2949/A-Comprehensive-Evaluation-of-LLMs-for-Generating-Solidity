// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract UpgradeHandler is Ownable {
    using SafeMath for uint256;

    uint256 public pendingVersion = 1; // Set to 1 (never 0)
    uint256 public pendingVersionTimestamp = block.timestamp; // Initialize with current timestamp
    uint256 public constant UPGRADE_FREEZE_TIME = 7 days; // Example freeze time, adjust as needed
    uint256 public latestVersion = 1; // Set to 1 (never 0)

    constructor() Ownable(msg.sender) {
        // Initialization of state variables is done in the constructor
    }

    function commitUpgrade() public onlyOwner returns (bool) {
        if (pendingVersion == 0x0) {
            return false;
        }

        if (pendingVersionTimestamp.add(UPGRADE_FREEZE_TIME) > block.timestamp) {
            return false;
        }

        latestVersion = pendingVersion;
        delete pendingVersion;
        delete pendingVersionTimestamp;

        return true;
    }
}