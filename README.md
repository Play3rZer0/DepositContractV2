# DepositContractV2
# An improved version of the Deposit Contract


General purpose contract for depositing ETH with multi-purpose applications.

The contract is a simple ETH depository, like a savings bank. Users deposit their ETH to the contract.

Only users can withdraw their deposit, while the contract owner can withdraw the total balance.

*********************

<b>Improvements include the following</b>

1. Includes an event for the withdrawAll() function. This is emitted when there is a successful withdrawal made by the owner of all funds in the contract.
2. Create a function for deposit() instead of using the default receive() special function. The receive() function directs any deposited funds to the deposit() function.
3. Add a require statement to check if funds deposited are greater than zero for the withdraw() function. Users can only withdraw if they have a sufficient balance that must be greater than zero.
4. Add a require statement to withdrawAll() function to check if the total funds deposited in the contract is greater than zero. If there are no funds deposited, there is no need to run the rest of the methods in the function.

*********************

This shows an example of how to use mappings in a smart contract.

The mapping uses an Ethereum address (EOA) to a uint256 data type, effectively storing the token balance deposited by each user. This tracks association by the user to the balance of tokens they store in the contract.
