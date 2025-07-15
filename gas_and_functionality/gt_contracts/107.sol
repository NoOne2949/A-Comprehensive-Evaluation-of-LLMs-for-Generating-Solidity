// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenRegistry is Ownable {
    using SafeMath for uint256;

    struct TokenInfo {
        address tokenAddress;
        uint8 tokenDecimals;
    }

    mapping(uint32 => TokenInfo) public tokenInfos;

    event RegisteredToken(uint32 indexed tokenCode, address indexed tokenAddress, uint8 tokenDecimals);

    constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        for (uint32 i = 1; i <= 3; i++) {
            tokenInfos[i] = TokenInfo({tokenAddress: address(uint160(uint256(i))), tokenDecimals: uint8(i)});
        }
    }

    function registerToken(uint32 _tokenCode, address _tokenAddress, uint8 _tokenDecimals) public onlyOwner {
        require(_tokenCode > 0, "Invalid token code");
        require(_tokenAddress != address(0), "Invalid token address");
        require(_tokenDecimals > 0, "Invalid token decimals");

        TokenInfo storage tokenInfo = tokenInfos[_tokenCode];
        require(tokenInfo.tokenAddress == address(0), "Token already registered");

        tokenInfo.tokenAddress = _tokenAddress;
        tokenInfo.tokenDecimals = _tokenDecimals;

        emit RegisteredToken(_tokenCode, _tokenAddress, _tokenDecimals);
    }
}