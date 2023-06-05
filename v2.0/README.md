# NFT Dutch Auction

The particular directory i.e v2.0 outlines a series of steps to be followed to implement version 2.0 of a project involving ERC721 (Ethereum Request for Comments 721) non-fungible token (NFT) contracts and a Dutch auction for NFTs. Let's break down the text and explain each step in a detailed manner using technical language.


## About the project

1. Read the ERC721 EIP and OpenZeppelin implementation:
   The first step is to familiarize yourself with the ERC721 standard, which is the official specification for NFT contracts on the Ethereum blockchain. The ERC721 standard defines a set of functions and events that allow the creation, ownership, and transfer of unique digital assets (NFTs). Additionally, you should review the implementation provided by OpenZeppelin, a widely used library for secure and tested smart contracts.

2. The following project initializes a new Hardhat project, which is a development environment and testing framework for Ethereum smart contracts.

3. The v1.0 is used as a base:
   I have identified any files from the previous versions of your project that can be reused and copy them into the v2.0 directory. Reusing existing code can save development time and ensure consistency across different versions.

4. The project required an understanding of how the ERC721 contract works by downloading an off-the-shelf version from OpenZeppelin, and writing test cases:
   To gain a deeper understanding of how ERC721 contracts function, download a pre-existing implementation of the ERC721 contract from the OpenZeppelin library. This off-the-shelf implementation will serve as a reference for your own implementation. Additionally, write comprehensive test cases to ensure that you understand how to create NFT contracts, mint NFTs (create new tokens), and transfer them between addresses. Thorough testing helps identify and resolve any issues or bugs in the contract.

5. Add contracts from OpenZeppelin into your project using npm:
   Instead of manually copying and pasting the OpenZeppelin contracts, it is recommended to use npm (Node Package Manager) to download them. OpenZeppelin contracts often have various dependencies, and using npm ensures that you have the correct versions and makes it easier to upgrade to newer versions in the future. This approach also reduces the scope of vulnerabilities and minimizes the chances of accidentally modifying the contracts.

6. Create a new contract called NFTDutchAuction.sol:
   In this step, you need to develop a new contract called NFTDutchAuction.sol. This contract should have similar functionality to BasicDutchAuction.sol, which is likely a contract for conducting Dutch auctions for physical items. However, in NFTDutchAuction.sol, the contract will facilitate the auction of NFTs instead of physical items. The contract should contain a constructor with the following parameters: erc721TokenAddress (address of the ERC721 token contract), _nftTokenId (ID of the NFT being auctioned), _reservePrice (the minimum price for the NFT), _numBlocksAuctionOpen (number of Ethereum blocks the auction will be open), and _offerPriceDecrement (price decrement for each new offer).

7. Write test cases to thoroughly test your contracts:
   To ensure the correctness and reliability of your contracts, it is crucial to write comprehensive test cases that cover different scenarios and edge cases. Test cases should validate various aspects, such as the creation of the NFTDutchAuction contract, the functionality of auction parameters, bidding mechanisms.


## Pre-requisites

```shell
npm install @nomicfoundation/hardhat-toolbox
npm install @openzeppelin/contracts
```

## Run Commands

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts

// to get solidity-coverage
npx hardhat coverage
```

## TestCases

![Test_Cases](https://github.com/Raj-Mehta2012/INFO7500_Crypto/blob/main/v2.0/screenshots/TestCases.png)

## Coverage

![Coverage](https://github.com/Raj-Mehta2012/INFO7500_Crypto/blob/main/v2.0/screenshots/v2.0_coverage.png)
