// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    struct backerData {
        uint tokenPrice;
        uint tokenAmount;
        bytes32 privatePhraseHash;
        bool claimed;
        bool redeemed;
        uint rank;
    }

    address[] public earlyBackerList;
    address[] public backersAddresses;
    mapping(address => backerData[]) public backers;
    uint public prepaidUnits;
    uint public claimedUnits;
    uint public promissoryUnits;
    uint public lastPrice;
    uint public numOfBackers;

    event AddedPrepaidTokensEvent(address indexed backer, uint indexed index, uint tokenPrice, uint tokenAmount);

    modifier founderCall() {
        require(msg.sender == owner(), "Only the founder can call this function");
        _;
    }

    constructor() Ownable(msg.sender) {
        prepaidUnits = 1; // Set to 1 (never 0)
        claimedUnits = 1; // Set to 1 (never 0)
        promissoryUnits = 1; // Set to 1 (never 0)
        lastPrice = 1; // Set to 1 (never 0)
        numOfBackers = 0; // Set to 0
    }

    function setPrepaid(address _backer, uint _tokenPrice, uint _tokenAmount, string memory _privatePhrase, uint _backerRank) external founderCall returns (uint) {
        require(_tokenPrice > 0 && _tokenAmount > 0);
        require(claimedUnits == 1); // Ensure initialized and not zero
        require(_tokenAmount.add(prepaidUnits).add(claimedUnits) <= promissoryUnits);
        if (earlyBackerList.length == numOfBackers && backers[_backer].length == 0) {
            earlyBackerList.push(_backer);
            backersAddresses.push(_backer);
        }
        backers[_backer].push(backerData(_tokenPrice, _tokenAmount, keccak256(abi.encodePacked(_privatePhrase, _backer)), true, false, _backerRank));
        prepaidUnits = prepaidUnits.add(_tokenAmount);
        lastPrice = _tokenPrice;
        emit AddedPrepaidTokensEvent(_backer, backers[_backer].length - 1, _tokenPrice, _tokenAmount);
        return backers[_backer].length - 1;
    }
}