// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ContractorManagerSetter is Ownable {
    using SafeMath for uint256;

    event ContractorManagerSet(address indexed contractorManager);

    constructor() Ownable(msg.sender) {
        // Initialization of state variables can be done here if needed, but based on the rules provided, no changes are necessary.
    }

    function setContractorManager(address _contractorManager) public onlyOwner {
        require(_contractorManager != address(0), "Invalid contractor manager address");
        emit ContractorManagerSet(_contractorManager);
    }
}