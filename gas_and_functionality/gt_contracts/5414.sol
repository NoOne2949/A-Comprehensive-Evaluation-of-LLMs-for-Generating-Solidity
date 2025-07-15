// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ChronoBankPlatform {
    function proxyTransferFromWithReference(address _from, address _to, uint _value, bytes32 _smbl, string memory _reference, address _sender) external returns (uint);
}

contract WrappedFunction is Ownable {
    using SafeMath for uint;

    ChronoBankPlatform public chronoBankPlatform;

    constructor(address _chronoBankPlatform) Ownable(msg.sender) {
        chronoBankPlatform = ChronoBankPlatform(_chronoBankPlatform);
    }

    function __transferFromWithReference(address _from, address _to, uint _value, string memory _reference, address _sender) public onlyOwner {
        require(chronoBankPlatform.proxyTransferFromWithReference(_from, _to, _value, bytes32("smbl"), _reference, _sender) == 0, "Transfer failed");
    }
}