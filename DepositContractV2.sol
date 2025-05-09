//SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

/* The ownable contract establishes the owner is the only one who can run
a certain function by using a modifier. */
contract Ownable {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwnable() {
        require(msg.sender == owner, "not owner");
        _;
    }
}

//The main contract for depositing ETH
contract DepositBoxV2 is Ownable {
    /* Create a mapping of wallet address to a balances variable which tracks
    the deposit amount */
    mapping(address => uint256) balances;

    //Create two events that will be for deposits and withdrawals
    event Deposit(address addr, uint256 amount);
    event Withdraw(address addr, uint256 amount);
    event WithdrawAll(address addr, uint256 amount);

    //Receive deposits with fallback function
    receive() external payable {
        deposit();
    }

    function deposit() public payable {
        require(msg.value > 0, "invalid amount");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    //Check individual balance of user
    function checkMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    //Check the total balance of the contract deposits
    function totalBalance() public view returns (uint256) {
        return address(this).balance;
    }

    //Individual withdrawals are allowed only if they are not zero balance
    function withdraw() public {
        uint amount = balances[msg.sender];
        require(amount > 0, "No Funds To Withdraw");
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "invalid withdrawal");
        emit Withdraw(msg.sender, amount);
    }

    //Total withdrawal of deposits, restricted to the owner
    function withdrawAll() public isOwnable {
        uint256 amount = totalBalance();
        require(amount > 0, "Contract has no funds to withdraw");
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Only Owner Can Withdraw Funds");
        emit WithdrawAll(msg.sender, amount);
    }
}
