// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface EthealToken {
    function balanceOf(address account) external view returns (uint256);
}

interface EthealController {
    function ethealToken() external view returns (EthealToken);
}

contract Wrapper is Ownable {
    using SafeMath for uint256;

    EthealController public ethealController;

    mapping(address => uint256) public balanceOf;

 constructor(address _ethealController) Ownable(_ethealController) {
        require(_ethealController != address(0), "Invalid controller address");
        ethealController = EthealController(_ethealController);
    }

    function getHealBalance() public view returns (uint256) {
        return ethealController.ethealToken().balanceOf(address(this));
    }
}