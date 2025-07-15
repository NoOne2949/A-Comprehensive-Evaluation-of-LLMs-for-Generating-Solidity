// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface MiniMeTokenFactory {
    function createCloneToken(address _parentToken, uint256 _snapshotBlock, string memory _tokenName, uint8 _decimalUnits, string memory _tokenSymbol, bool _transfersEnabled) external returns (MiniMeToken);
}

contract MiniMeToken is Ownable {
    using SafeMath for uint256;

    address public factory;
    string public name;
    uint8 public decimals;
    string public symbol;
    bool public transfersEnabled;
    uint256 public snapshotBlock;

    constructor(address _factory, uint256 _snapshotBlock, string memory _tokenName, uint8 _decimalUnits, string memory _tokenSymbol, bool _transfersEnabled) Ownable(msg.sender) {
        factory = _factory;
        name = _tokenName;
        decimals = _decimalUnits;
        symbol = _tokenSymbol;
        transfersEnabled = _transfersEnabled;
        snapshotBlock = _snapshotBlock > block.number ? block.number : _snapshotBlock;
    }

    function changeController(address _newController) public onlyOwner {
        require(_newController != address(0), "Invalid controller address");
        // Controller logic here
    }
}

contract TokenCreator is Ownable {
    using SafeMath for uint256;

    MiniMeTokenFactory public tokenFactory;

    event NewCloneToken(address indexed cloneTokenAddress, uint256 snapshotBlock);

    constructor(MiniMeTokenFactory _tokenFactory) Ownable(msg.sender) {
        tokenFactory = _tokenFactory;
    }

    function createCloneToken(string memory _cloneTokenName, uint8 _cloneDecimalUnits, string memory _cloneTokenSymbol, uint256 _snapshotBlock, bool _transfersEnabled) public returns (address) {
        if (_snapshotBlock > block.number) {
            _snapshotBlock = block.number;
        }
        MiniMeToken cloneToken = tokenFactory.createCloneToken(address(this), _snapshotBlock, _cloneTokenName, _cloneDecimalUnits, _cloneTokenSymbol, _transfersEnabled);
        cloneToken.changeController(msg.sender);
        emit NewCloneToken(address(cloneToken), _snapshotBlock);
        return address(cloneToken);
    }
}