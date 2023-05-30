
# Project Version 1.0

## Introduction
This project version includes the implementation of the BasicDutchAuction contract, which manages a Dutch auction for a single item. The auction follows specific rules where the seller is the owner and bids are accepted from Ethereum externally-owned accounts. The auction begins at the block when the contract is created and ends after a certain number of blocks. The contract determines the winner based on the first bid that meets or exceeds the current price. The winning bid is immediately transferred to the seller, and all other bids are refunded.

## Setup
To run the project, follow these steps:

1. Create a new directory in your GitHub repository called `v1.0`.
2. Initialize a new Hardhat project inside the `v1.0` directory.
3. Create a new contract file named `BasicDutchAuction.sol` and implement the Dutch auction logic as described below.
4. Write comprehensive test cases to ensure the correctness of the contract.
5. Generate a Solidity coverage report and commit it to your repository.

## BasicDutchAuction.sol Contract Description
The `BasicDutchAuction.sol` contract manages the auction of a single physical item during a single auction event. It is initialized with the following parameters:

- `reservePrice`: The minimum amount of wei that the seller is willing to accept for the item.
- `numBlocksAuctionOpen`: The number of blockchain blocks that the auction remains open for.
- `offerPriceDecrement`: The amount of wei that the auction price should decrease by during each subsequent block.

Key Features:
- The seller is the owner of the contract.
- The auction begins at the block in which the contract is created.
- The initial price of the item is derived from `reservePrice`, `numBlocksAuctionOpen`, and `offerPriceDecrement` using the formula: `initialPrice = reservePrice + numBlocksAuctionOpen * offerPriceDecrement`.
- Any Ethereum externally-owned account can submit a bid.
- The contract determines the winner based on the first bid that sends wei greater than or equal to the current price.
- The wei from the winning bid is immediately transferred to the seller.
- The contract does not accept any more bids once a winner is determined.
- All bids, except the winning bid, are refunded immediately.

Make sure to thoroughly test the contract by covering various scenarios and edge cases.

<!-- # Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
``` -->
# Run this HardHat Project

```shell
npx hardhat run scripts/deploy.js
REPORT_GAS=true npx hardhat test

// to get solidity-coverage
npx hardhat coverage
```

## Output

![TestCases](https://github.com/Raj-Mehta2012/INFO7500_Crypto/blob/main/v1.0/Screenshots/testCases_output.png)



