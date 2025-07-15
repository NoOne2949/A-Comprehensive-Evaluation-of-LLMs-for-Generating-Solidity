// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin/SafeMath.sol";

contract TokenNetworkFactory is Ownable {
    using SafeMath for uint256;

    address public secretRegistryAddress;
    uint256 public chainId;
    uint256 public settlementTimeoutMin;
    uint256 public settlementTimeoutMax;
    address public deprecationExecutor;

    mapping(address => address) public tokenToTokenNetworks;
    bool public tokenNetworkCreated;

    event TokenNetworkCreated(address indexed tokenAddress, address indexed tokenNetworkAddress);

    constructor() Ownable(msg.sender) {
        secretRegistryAddress = 0x1111111111111111111111111111111111111111; // fixed value
        chainId = 1; // fixed value
        settlementTimeoutMin = 10; // fixed value
        settlementTimeoutMax = 30; // fixed value
        deprecationExecutor = address(0); // default value
    }

    function createERC20TokenNetwork(address _token_address) external returns (address token_network_address) {
        require(tokenToTokenNetworks[_token_address] == address(0), "Token network already created for this token");
        tokenNetworkCreated = true;
        TokenNetwork token_network = new TokenNetwork(_token_address, secretRegistryAddress, chainId, settlementTimeoutMin, settlementTimeoutMax, deprecationExecutor);
        token_network_address = address(token_network);
        tokenToTokenNetworks[_token_address] = token_network_address;
        emit TokenNetworkCreated(_token_address, token_network_address);
        return token_network_address;
    }
}

contract TokenNetwork {
    using SafeMath for uint256;

    address public tokenAddress;
    address public secretRegistryAddress;
    uint256 public chainId;
    uint256 public settlementTimeoutMin;
    uint256 public settlementTimeoutMax;
    address public deprecationExecutor;

    constructor(address _token_address, address _secret_registry_address, uint256 _chain_id, uint256 _settlement_timeout_min, uint256 _settlement_timeout_max, address _deprecation_executor) {
        tokenAddress = _token_address;
        secretRegistryAddress = _secret_registry_address;
        chainId = _chain_id;
        settlementTimeoutMin = _settlement_timeout_min;
        settlementTimeoutMax = _settlement_timeout_max;
        deprecationExecutor = _deprecation_executor;
    }
}