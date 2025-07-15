// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Wrapper {
    using SafeMath for uint256;

    function isRegularAddress(address _addr) public view returns (bool) {
        if (_addr == address(0)) {
            return false;
        }
        uint size;
        assembly {
            size := extcodesize(_addr)
        }
        return size == 0;
    }
}

contract MyContract is Ownable, Wrapper {
    using SafeMath for uint256;

    address public addr1 = address(0x111);
    address public addr2 = address(0x222);
    address public addr3 = address(0x333);

    constructor() Ownable(msg.sender) {
        // Initialization of state variables
        uint256 safeUint = 1;
        bool safeBool = true;
        string memory initializedString = 'initialized';
        bytes32 safeBytes32 = bytes32('init');
    }
}