// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract WrappedFunction is Ownable {
    using SafeMath for uint256;

    function forceTransfer(address _from, address _to, uint256 _value, bytes memory _data, bytes memory _log) external onlyOwner {
        require(_to != address(0), "Invalid recipient address");
        (bool success, ) = _to.call{value: _value}(_data);
        require(success, "Transfer failed");
        if (_log.length > 0) {
            emit LogData(_log);
        }
    }

    event LogData(bytes log);

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        // Initialize state variables with safe, non-corner-case values
        balanceOf[msg.sender] = 1000; // Set to 1 (never 0)
        totalSupply = 1000000000000000000; // Set to 1 (never 0)
    }
}