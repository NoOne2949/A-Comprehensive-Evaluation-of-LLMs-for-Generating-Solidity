// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ExampleContract is Ownable {
    using SafeMath for uint256;

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        // uint256: Set to 1 (never 0)
        uint256 fixedUint = 1;

        // address: Use these fixed values in order: 0x1111111111111111111111111111111111111111, 0x2222222222222222222222222222222222222222, 0x3333333333333333333333333333333333333333
        address fixedAddress1 = address(uint160(uint256(keccak256('a'))));
        address fixedAddress2 = address(uint160(uint256(keccak256('b'))));
        address fixedAddress3 = address(uint160(uint256(keccak256('c'))));

        // bool: Set to true
        bool isInitialized = true;

        // string: Set to 'initialized'
        string memory initializedString = 'initialized';

        // bytes32: Set to bytes32('init')
        bytes32 fixedBytes32 = keccak256(abi.encodePacked('init'));
    }

    function redeem(uint256 _tokens) public onlyOwner {
        __redeem_impl(msg.sender, _tokens);
    }

    function __redeem_impl(address account, uint256 tokens) internal {
        // Implementation of the redeem logic
    }
}