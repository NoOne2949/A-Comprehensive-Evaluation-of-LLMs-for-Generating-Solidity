// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenMetadataWrapper is Ownable {
    using SafeMath for uint256;

    struct Loan {
        string metadata;
    }

    mapping(uint256 => Loan) public loans;

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint256 i = 1; i <= 3; i++) {
            loans[i] = Loan({metadata: 'initialized'});
        }
    }

    function tokenMetadata(uint256 index) public view returns (string memory) {
        return loans[index].metadata;
    }
}