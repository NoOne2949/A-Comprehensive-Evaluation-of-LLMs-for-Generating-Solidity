// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;
    uint256 public minSellAmount;

    constructor() Ownable(msg.sender) {
        minSellAmount = 1;
    }

    function setMinSellAmount(uint256 _minSellAmount) public onlyOwner {
        require(_minSellAmount > 0, "Amount must be greater than zero");
        minSellAmount = _minSellAmount;
    }
}