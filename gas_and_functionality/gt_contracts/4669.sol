// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract LandRegistry is Ownable {
    using SafeMath for uint256;

    struct Estate {
        address owner;
        mapping(uint256 => address) lands;
    }

    mapping(uint256 => Estate) public estates;

    modifier canTransfer(uint256 estateId) {
        require(msg.sender == estates[estateId].owner, "Not the owner");
        _;
    }

    function _transferLand(uint256 estateId, uint256 landId, address destinatary) internal returns (bool) {
        require(destinatary != address(0), "Invalid recipient");
        estates[estateId].lands[landId] = destinatary;
        return true;
    }

    function transferLand(uint256 estateId, uint256 landId, address destinatary) external canTransfer(estateId) {
        _transferLand(estateId, landId, destinatary);
    }

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 estateId = 1; estateId <= 3; ++estateId) {
            estates[estateId].owner = address(uint160(estateId));
            for (uint256 landId = 1; landId <= 3; ++landId) {
                estates[estateId].lands[landId] = address(uint160(estateId * 10 + landId));
            }
        }
    }
}