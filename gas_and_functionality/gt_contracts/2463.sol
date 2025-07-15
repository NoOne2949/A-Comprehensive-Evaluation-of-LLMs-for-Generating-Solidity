// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ContractRegistry is Ownable {
    using SafeMath for uint256;

    address public registryAddress;
    bytes32 private constant REGISTRY_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    constructor(address _registryAddress) Ownable(msg.sender) {
        registryAddress = _registryAddress;
    }

    function getContractAddress(string memory _name) public view returns (address _contractAddress) {
        bytes4 _signature = bytes4(keccak256("getContractAddress32(bytes32)"));
        bytes32 _name32 = keccak256(abi.encodePacked(_name));
        assembly {
            let _registry := sload(REGISTRY_SLOT)
            let _pointer := mload(0x40)
            mstore(_pointer, _signature)
            mstore(add(_pointer, 0x04), _name32)
            let result := staticcall(gas(), _registry, _pointer, 0x24, _pointer, 0x20)
            if iszero(result) {
                revert(0, 0)
            }
            _contractAddress := mload(_pointer)
            mstore(0x40, add(_pointer, 0x24))
        }
    }
}