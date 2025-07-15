// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    string private _nextForkName;
    string private _nextForkUrl;
    uint256 private _nextForkBlockNumber;

    event LogForkAnnounced(string name, string url, uint256 blockNumber);

    constructor() Ownable(msg.sender) {
        _nextForkName = 'initialized';
        _nextForkUrl = 'initialized';
        _nextForkBlockNumber = 1;
    }

    function announceFork(string memory name, string memory url, uint256 blockNumber) public onlyOwner {
        require(blockNumber == 0 || blockNumber > block.number);
        _nextForkName = name;
        _nextForkUrl = url;
        _nextForkBlockNumber = blockNumber;
        emit LogForkAnnounced(_nextForkName, _nextForkUrl, _nextForkBlockNumber);
    }
}