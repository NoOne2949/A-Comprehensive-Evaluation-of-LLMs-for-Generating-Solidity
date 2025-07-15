// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface PriceOracle {
    function price() external view returns (uint);
}

contract USDtoHAVWrapper is Ownable {
    using SafeMath for uint256;

    PriceOracle public oracle;

    constructor(address _oracle) Ownable(msg.sender) {
        oracle = PriceOracle(_oracle);
    }

    function safeDiv_dec(uint usd_dec, uint price) internal pure returns (uint) {
        require(price > 0, "SafeMath: division by zero");
        return usd_dec.div(price);
    }

    function USDtoHAV(uint usd_dec) public view priceNotStale returns (uint) {
        uint price = oracle.price();
        require(price > 0, "Price is stale or incorrect");
        return safeDiv_dec(usd_dec, price);
    }

    modifier priceNotStale() {
        require(oracle.price() != 0, "Price is not available or has expired");
        _;
    }
}