// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

interface IERC20Store {
    function allowed(address _owner, address _spender) external view returns (uint256);
    function setAllowance(address _owner, address _spender, uint256 _value) external;
}

interface IERC20Proxy {
    function emitApproval(address _owner, address _spender, uint256 _value) external;
}

contract ERC20Wrapper is Ownable {
    using SafeMath for uint256;

    IERC20Store public erc20Store;
    IERC20Proxy public erc20Proxy;

    constructor(address _erc20Store, address _erc20Proxy) Ownable(msg.sender) {
        erc20Store = IERC20Store(_erc20Store);
        erc20Proxy = IERC20Proxy(_erc20Proxy);
    }

    function decreaseApprovalWithSender(address _sender, address _spender, uint256 _subtractedValue) public onlyOwner returns (bool) {
        require(_spender != address(0));
        uint256 currentAllowance = erc20Store.allowed(_sender, _spender);
        uint256 newAllowance = currentAllowance.sub(_subtractedValue);
        require(newAllowance <= currentAllowance);
        erc20Store.setAllowance(_sender, _spender, newAllowance);
        erc20Proxy.emitApproval(_sender, _spender, newAllowance);
        return true;
    }
}