// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract Escrow is Ownable {
    using SafeMath for uint256;

    address public nonFungibleContract;

    constructor(address _nonFungibleContract) Ownable(msg.sender) {
        nonFungibleContract = _nonFungibleContract;
    }

    function escrow(address _owner, uint256 _tokenId) external onlyOwner {
        require(_owner != address(0), "Invalid owner address");
        (bool success, ) = nonFungibleContract.call(abi.encodeWithSelector(bytes4(keccak256("safeTransferFrom(address,address,uint256)")), _owner, address(this), _tokenId));
        require(success, "Safe transfer failed");
    }
}