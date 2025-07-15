// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract CanvasMarketplace is Ownable {
    using SafeMath for uint256;

    struct SellOffer {
        bool isForSale;
        address seller;
        uint minPrice;
        address onlySellTo;
    }

    mapping(uint32 => SellOffer) public canvasForSale;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function getCurrentSellOffer(uint32 _canvasId) external view returns (bool isForSale, address seller, uint minPrice, address onlySellTo) {
        SellOffer storage offer = canvasForSale[_canvasId];
        return (offer.isForSale, offer.seller, offer.minPrice, offer.onlySellTo);
    }
}