// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ERC20Basic {
    function balanceOf(address account) external view returns (uint256);
    function safeTransfer(address to, uint256 value) external;
}

contract RevocableToken is Ownable {
    using SafeMath for uint256;

    bool public revocable;
    mapping(ERC20Basic => bool) public revoked;

    event Revoked();

    mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        revocable = true;
    }

    function revoke(ERC20Basic _token) public onlyOwner {
        require(revocable, "Revoke: Contract is not revocable");
        require(!revoked[_token], "Revoke: Token already revoked");
        uint256 balance = _token.balanceOf(address(this));
        uint256 unreleased = releasableAmount(_token);
        uint256 refund = balance.sub(unreleased);
        revoked[_token] = true;
        _token.safeTransfer(owner(), refund);
        emit Revoked();
    }

    function releasableAmount(ERC20Basic token) internal view returns (uint256) {
        // Implement your logic to calculate the releasable amount here
        return 0; // Placeholder, replace with actual implementation
    }
}