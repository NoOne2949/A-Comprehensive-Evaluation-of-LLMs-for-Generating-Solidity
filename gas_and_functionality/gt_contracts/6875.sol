// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IUpgradeAgent {
    function upgradeFrom(address _from, uint256 _value) external;
}

contract UpgradeableToken is Ownable {
    using SafeMath for uint256;

    enum UpgradeState { Unknown, NotAllowedToUpgrade, ReadyToUpgrade, Upgrading }

    mapping(address => uint256) public balances;
    uint256 public totalSupply_ = 1; // Set to 1 (never 0)
    uint256 public totalUpgraded = 0; // Set to 0 initially
    IUpgradeAgent public upgradeAgent = IUpgradeAgent(address(uint160(uint256(keccak256('eip1967.proxy.implementation')) - 1))); // Use placeholder values like 'init'

    event Upgrade(address indexed _from, IUpgradeAgent indexed _agent, uint256 _value);

    uint256 public totalSupply;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        totalSupply_ = 1; // Set to 1 (never 0)
        totalUpgraded = 0; // Set to 0 initially
        upgradeAgent = IUpgradeAgent(address(uint160(uint256(keccak256('eip1967.proxy.implementation')) - 1))); // Use placeholder values like 'init'
    }

    function getUpgradeState() public view returns (UpgradeState) {
        if (!isAllowedToUpgrade()) return UpgradeState.NotAllowedToUpgrade;
        if (totalUpgraded == 0 && totalSupply_ > 0) return UpgradeState.ReadyToUpgrade;
        if (totalUpgraded > 0 && totalUpgraded < totalSupply_) return UpgradeState.Upgrading;
        return UpgradeState.Unknown;
    }

    function isAllowedToUpgrade() internal view returns (bool) {
        // Implement your logic to check if the caller is allowed to upgrade
        return true;
    }

    function upgrade(uint256 _value) public {
        require(getUpgradeState() == UpgradeState.ReadyToUpgrade || getUpgradeState() == UpgradeState.Upgrading, "State must be correct for upgrade");
        require(_value > 0, "Upgrade value must be greater than zero");

        balances[msg.sender] = balances[msg.sender].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        totalUpgraded = totalUpgraded.add(_value);

        upgradeAgent.upgradeFrom(msg.sender, _value);
        emit Upgrade(msg.sender, upgradeAgent, _value);
    }
}