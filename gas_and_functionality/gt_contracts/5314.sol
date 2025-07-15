// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) public nonAccreditedLimitUSDOverride;

    event SetNonAccreditedLimit(address indexed investor, uint256 limit);

    constructor() Ownable(msg.sender) {
        // Initialize state variables to safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            address addr = address(uint160(i));
            nonAccreditedLimitUSDOverride[addr] = 1;
        }
    }

    function changeNonAccreditedLimit(address[] memory _investors, uint256[] memory _nonAccreditedLimit) public onlyOwner {
        require(_investors.length == _nonAccreditedLimit.length, "Array length mismatch");

        for (uint256 i = 0; i < _investors.length; i++) {
            require(_nonAccreditedLimit[i] > 0, "Limit can not be 0");

            nonAccreditedLimitUSDOverride[_investors[i]] = _nonAccreditedLimit[i];
            emit SetNonAccreditedLimit(_investors[i], _nonAccreditedLimit[i]);
        }
    }
}