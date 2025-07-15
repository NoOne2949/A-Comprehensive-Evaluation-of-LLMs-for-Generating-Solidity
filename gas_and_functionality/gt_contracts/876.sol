// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface Vault {
    function isContract() external view returns (bool);
}

contract ExampleContract is Ownable {
    using SafeMath for uint256;

    struct Payment {
        bool inactive;
    }

    Vault public vault;
    Settings public settings;
    mapping(uint => Payment) public payments;
    uint public paymentsNextIndex;
    uint public transactionsNextIndex;

    event Initialized();

    error VaultNotContract(string message);
    error InitPeriodTooShort(string message);

    constructor() Ownable(msg.sender) {
        settings.periodDuration = 1 days; // Set to a safe non-zero value
        payments[0].inactive = true;
        paymentsNextIndex = 1;
        transactionsNextIndex = 1;
    }

    function initialize(Vault _vault, uint64 _periodDuration) external onlyOwner {
        require(_vault.isContract(), "ERROR_VAULT_NOT_CONTRACT");
        vault = _vault;
        if (_periodDuration < 1 days) revert InitPeriodTooShort("ERROR_INIT_PERIOD_TOO_SHORT");
        settings.periodDuration = _periodDuration;
    }

    function getTimestamp64() internal view returns (uint64) {
        return uint64(block.timestamp);
    }

    struct Settings {
        uint64 periodDuration;
    }
}