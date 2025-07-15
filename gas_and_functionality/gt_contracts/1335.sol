// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface ERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract Wrapper is Ownable {
    using SafeMath for uint256;

    uint256 public totalSupply_;
    uint256 public creationUnit_;

    uint256 public totalSupply;

 mapping(address => uint256) public balanceOf;

 constructor() Ownable(msg.sender) {
        totalSupply_ = 1; // Set to 1 (never 0)
        creationUnit_ = 1; // Set to 1 (never 0)
    }

    function getQuantity(address token) internal view returns (uint256 quantity, bool ok) {
        // Implement your logic to determine the quantity here
        revert("Not implemented");
    }

    function withdrawExcessToken(address token) external onlyOwner {
        ERC20 erc20 = ERC20(token);
        uint256 amountOwned = erc20.balanceOf(address(this));
        uint256 quantity;
        bool ok;
        (quantity, ok) = getQuantity(token);
        uint256 withdrawAmount;
        if (ok) {
            withdrawAmount = amountOwned.sub(totalSupply_.div(creationUnit_).mul(quantity));
        } else {
            withdrawAmount = amountOwned;
        }
        require(erc20.transfer(owner(), withdrawAmount), "Transfer failed");
    }
}