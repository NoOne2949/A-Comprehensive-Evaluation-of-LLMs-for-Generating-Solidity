// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract YourContract is Ownable {
    using SafeMath for uint256;

    enum Stages { AuctionDeployed, AuctionSetUp }
    Stages public stage;

    uint256 public price_start;
    uint256 public price_constant1;
    uint256 public price_exponent1;
    uint256 public price_constant2;
    uint256 public price_exponent2;

    constructor() Ownable(msg.sender) {
        stage = Stages.AuctionDeployed;
        price_start = 1;
        price_constant1 = 1;
        price_exponent1 = 1;
        price_constant2 = 1;
        price_exponent2 = 1;
    }

    function changePriceCurveSettings(uint256 _price_start, uint256 _price_constant1, uint256 _price_exponent1, uint256 _price_constant2, uint256 _price_exponent2) public onlyOwner {
        require(stage == Stages.AuctionDeployed || stage == Stages.AuctionSetUp);
        require(_price_start > 0);
        require(_price_constant1 > 0);
        require(_price_constant2 > 0);

        price_start = _price_start;
        price_constant1 = _price_constant1;
        price_exponent1 = _price_exponent1;
        price_constant2 = _price_constant2;
        price_exponent2 = _price_exponent2;
    }
}