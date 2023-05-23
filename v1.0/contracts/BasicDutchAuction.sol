// SPDX-License-Identifier: MIT
// Author: Raj Mehta
// Version 1.0

pragma solidity ^0.8.0;

/**
 * @title BasicDutchAuction v1.0
 * @dev A contract that implements a Dutch auction for a single item.
 */
contract BasicDutchAuction {
    uint256 public initialPrice;                     // Current price of the item
    uint256 public immutable startAt;                // Block number when the auction started
    uint256 public immutable endsAt;                 // Block number when the auction ends
    uint256 public immutable reservePrice;           // Minimum amount of wei the seller is willing to accept
    uint256 public immutable offerPriceDecrement;    // Amount of wei the auction price decreases by in each subsequent block
    uint256 public immutable numBlocksAuctionOpen;   // Number of blocks that the auction remains open
    address payable public donor;                    // Address of the winning bidder
    address payable public owner;                    // Address of the contract owner (seller)
    address public contractAddress;                  // Address of the contract itself

    /**
     * @dev Constructor function
     * initializing all default values in constructor function.....Runs by default only once when deployed by the owner
     */
    constructor() {
        reservePrice = 2 ether;
        offerPriceDecrement = 0.01 ether;
        numBlocksAuctionOpen = 5;
        startAt = block.number;
        endsAt = block.number + numBlocksAuctionOpen;
        initialPrice = reservePrice + numBlocksAuctionOpen * offerPriceDecrement;
        owner = payable(msg.sender);
        contractAddress = address(this);
    }

    /**
     * @dev Calculates the current price of the item based on the current block number
     * @return The current price in wei
     */
    function price() public view returns (uint256) {
        if (block.number >= endsAt) {
            return reservePrice;
        }

        uint256 currentPrice = initialPrice - (block.number - startAt) * offerPriceDecrement;
        if (currentPrice < reservePrice) {
            return reservePrice;
        }

        return currentPrice;
    }

    /**
     * @dev Returns the balance of the contract
     * @return The balance in wei
     */
    function checkBalance() public view returns (uint256) {
        return contractAddress.balance;
    }

    /**
     * @dev Function to receive and process bids
     */
    function receiveMoney() public payable {
        require(donor == address(0), "Someone has already donated");
        require(msg.value >= price(), "Not enough ether sent.");
        donor = payable(msg.sender);
        uint256 finalPrice = price();
        owner.transfer(finalPrice);
        
        if (msg.value > finalPrice) {
            uint256 remainingBalance = contractAddress.balance;
            donor.transfer(remainingBalance);
        }
    }
}
