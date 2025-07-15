// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IGiftToken {
    function GiftsOfOwner(address _owner) external view returns (uint256[] memory);
}

contract GiftWrapper is Ownable {
    using SafeMath for uint256;

    address public giftContractAddress;

    constructor(address _giftContractAddress) Ownable(msg.sender) {
        require(_giftContractAddress != address(0), "Invalid contract address");
        giftContractAddress = _giftContractAddress;
    }

    function giftOwnerByIndex(uint256 _index) external view returns (uint256 GiftId) {
        IGiftToken giftToken = IGiftToken(giftContractAddress);
        uint256[] memory ownerGifts = giftToken.GiftsOfOwner(owner());
        require(_index < ownerGifts.length, "Index out of bounds");
        return ownerGifts[_index];
    }
}