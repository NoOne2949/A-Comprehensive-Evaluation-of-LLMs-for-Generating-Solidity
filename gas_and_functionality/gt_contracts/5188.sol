// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IExchangeRate {
    function getExchangeRate(address numeratorToken, address denominatorToken) external view returns (uint256);
    function getTimestamp() external view returns (uint256);
}

contract ExchangeRates is Ownable {
    using SafeMath for uint256;

    IExchangeRate public exchangeRateContract;

    constructor(address _exchangeRateAddress) Ownable(msg.sender) {
        exchangeRateContract = IExchangeRate(_exchangeRateAddress);
    }

    function getExchangeRates(address[] memory numeratorTokens, address[] memory denominatorTokens) public view returns (uint256[] memory rateFractions, uint256[] memory timestamps) {
        require(numeratorTokens.length > 0 && denominatorTokens.length > 0);
        require(numeratorTokens.length == denominatorTokens.length, "Lengths must be equal");

        rateFractions = new uint256[](numeratorTokens.length * denominatorTokens.length);
        timestamps = new uint256[](numeratorTokens.length * denominatorTokens.length);

        for (uint256 i = 0; i < numeratorTokens.length; i++) {
            address numeratorToken = numeratorTokens[i];
            for (uint256 j = 0; j < denominatorTokens.length; j++) {
                address denominatorToken = denominatorTokens[j];
                uint256 rateFraction = exchangeRateContract.getExchangeRate(numeratorToken, denominatorToken);
                uint256 timestamp = exchangeRateContract.getTimestamp();
                rateFractions[i * denominatorTokens.length + j] = rateFraction;
                timestamps[i * denominatorTokens.length + j] = timestamp;
            }
        }
    }
}