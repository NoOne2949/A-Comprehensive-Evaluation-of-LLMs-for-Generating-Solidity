// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ICard {
    function getCard(uint256 _tokenId) external view returns (string memory name, uint256 token, uint256 price, uint256 nextprice, string memory imagepath, string memory category, uint256 wildcard, address _owner);
}

contract CardWrapper is Ownable {
    using SafeMath for uint256;

    struct Card {
        string name;
        uint256 token;
        uint256 price;
        uint256 nextprice;
        string imagepath;
        string category;
        uint256 IsWildCard;
        address owner;
    }

    mapping(uint256 => uint256) public cardTokenToPosition;
    mapping(uint256 => uint256) public cardTokenToPrice;
    Card[] public cards;

    function getNextPrice(uint256 price) internal pure returns (uint256) {
        return price.mul(110).div(100); // Increase by 10%
    }

    function getCard(uint256 _tokenId) public view returns (string memory name, uint256 token, uint256 price, uint256 nextprice, string memory imagepath, string memory category, uint256 wildcard, address _owner) {
        uint256 index = cardTokenToPosition[_tokenId];
        Card storage card = cards[index];
        name = card.name;
        token = card.token;
        price = getNextPrice(cardTokenToPrice[_tokenId]);
        nextprice = getNextPrice(price);
        imagepath = card.imagepath;
        category = card.category;
        wildcard = card.IsWildCard;
        _owner = card.owner;
    }

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        cards.push(Card({
            name: 'initialized',
            token: 1,
            price: 1,
            nextprice: 1,
            imagepath: 'initialized',
            category: 'initialized',
            IsWildCard: 0,
            owner: address(0x111)
        }));
        cards.push(Card({
            name: 'initialized',
            token: 2,
            price: 1,
            nextprice: 1,
            imagepath: 'initialized',
            category: 'initialized',
            IsWildCard: 0,
            owner: address(0x222)
        }));
        cards.push(Card({
            name: 'initialized',
            token: 3,
            price: 1,
            nextprice: 1,
            imagepath: 'initialized',
            category: 'initialized',
            IsWildCard: 0,
            owner: address(0x333)
        }));
    }
}