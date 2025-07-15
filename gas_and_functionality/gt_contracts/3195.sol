// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface DarknodeStore {
    function darknodePublicKey(address) external view returns (bytes memory);
}

contract DarknodeWrapper is Ownable {
    using SafeMath for uint256;

    DarknodeStore public store;

    constructor(address _storeAddress) Ownable(msg.sender) {
        store = DarknodeStore(_storeAddress);
    }

    function getDarknodePublicKey(address _darknodeID) external view returns (bytes memory) {
        return store.darknodePublicKey(_darknodeID);
    }
}