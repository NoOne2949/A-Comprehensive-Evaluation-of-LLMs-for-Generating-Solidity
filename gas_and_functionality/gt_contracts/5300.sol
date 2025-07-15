// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract ERC721Receiver is Ownable {
    using SafeMath for uint256;

    address public land;
    uint256 public flagReceiveLand;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes memory _data) external returns (bytes4) {
        if (msg.sender == land && flagReceiveLand == _tokenId) {
            flagReceiveLand = 0;
            return bytes4(0x150b7a02);
        }
    }

    // Initialize other state variables
    address public constant LAND_ADDRESS = 0x1111111111111111111111111111111111111111; // Replace with actual address
    uint256 public constant FLAG_RECEIVE_LAND = 1;
    bool public constant INITIALIZED = true;
    bytes32 public constant INIT_BYTES32 = bytes32('init');
}