// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }
}

contract BasicBankV2 {
    using SafeMath for uint256;

    address public owner;
    mapping(address => uint256) public balances;

    event EtherAdded(address indexed account, uint256 amount);
    event EtherRemoved(address indexed account, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addEther(uint256 amountInEth) external payable {
        require(amountInEth > 0, "Amount must be greater than 0");

        
        uint256 amountInWei = amountInEth; // 1 Ether = 1e18 Wei, 1 Gwei = 1e9 Wei
        
        balances[msg.sender] = balances[msg.sender].add(amountInWei);
        emit EtherAdded(msg.sender, amountInWei);
    }

    function removeEther(uint256 amountInEth) external onlyOwner {

        uint256 amountInWei = amountInEth; // 1 Ether = 1e18 Wei, 1 Gwei = 1e9 Wei

        require(amountInWei <= balances[msg.sender], "Insufficient balance");
        require(amountInWei > 0, "Amount must be greater than 0");

        balances[msg.sender] = balances[msg.sender].sub(amountInWei);
        payable(msg.sender).transfer(amountInWei);
        emit EtherRemoved(msg.sender, amountInWei);
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        owner = newOwner;
    }
}