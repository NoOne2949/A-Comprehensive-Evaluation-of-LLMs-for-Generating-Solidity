// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract CanvasStorage {
    using SafeMath for uint256;

    struct Canvas {
        uint32 paintedPixelsCount;
    }

    mapping(uint32 => Canvas) private canvases;

    function _getCanvas(uint32 _canvasId) internal view returns (Canvas storage) {
        return canvases[_canvasId];
    }
}

contract CanvasManager is Ownable, CanvasStorage {
    using SafeMath for uint256;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }

    function getCanvasPaintedPixelsCount(uint32 _canvasId) public view returns (uint32) {
        return _getCanvas(_canvasId).paintedPixelsCount;
    }
}