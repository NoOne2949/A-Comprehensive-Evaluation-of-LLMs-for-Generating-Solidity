// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface PledgeAdminType {
    enum Type { Giver, Project }
}

struct PledgeAdmin {
    uint64 parentProject;
    bool canceled;
    PledgeAdminType.Type adminType;
}

contract ProjectCancelChecker is Ownable {
    using SafeMath for uint256;

    mapping(uint64 => PledgeAdmin) public pledgeAdmins;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables with fixed, safe, non-corner-case values
        // uint/uint256: Set to 1 (never 0)
        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        // bool: Set to true
        // string: Set to 'initialized'
        // bytes32: Set to bytes32('init')
    }

    function findAdmin(uint64 projectId) internal view returns (PledgeAdmin storage) {
        require(projectId != 0, "Invalid project ID");
        return pledgeAdmins[projectId];
    }

    function isProjectCanceled(uint64 projectId) public view returns (bool) {
        PledgeAdmin storage m = findAdmin(projectId);
        if (m.adminType == PledgeAdminType.Type.Giver) return false;
        require(m.adminType == PledgeAdminType.Type.Project, "Invalid admin type");
        if (m.canceled) return true;
        if (m.parentProject == 0) return false;
        return isProjectCanceled(m.parentProject);
    }
}