// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IContractManager {
    function authorize(string memory contractName, address user) external view returns (bool);
}

contract WalletWrapper is Ownable {
    using SafeMath for uint256;

    IContractManager public contractManager;
    string public contractName;
    address public wallet;

    event WalletAddressChanged(address indexed oldAddress, address indexed newAddress);

    constructor(IContractManager _contractManager, string memory _contractName, address _wallet) Ownable(msg.sender) {
        contractManager = _contractManager;
        contractName = _contractName;
        wallet = _wallet;
    }

    function setWalletAddress(address _walletAddress) external {
        require(contractManager.authorize(contractName, msg.sender));
        require(_walletAddress != address(0));
        require(_walletAddress != wallet);
        address oldAddress = wallet;
        wallet = _walletAddress;
        emit WalletAddressChanged(oldAddress, _walletAddress);
    }
}